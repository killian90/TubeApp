//
//  TFLParser.m
//  WeekendTube
//
//  Created by Killian O Connell on 20/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import "TFLParser.h"
#import "TubeLine.h"


static NSString * const kEntryElementName = @"Line";
static NSString * const kNameElementName = @"Name";
static NSString * const kBackgroundColorElementName = @"BgColour";
static NSString * const kURLElementName = @"Url";
static NSString * const kStatusElementName = @"Status";
static NSString * const kStatusTextElementName = @"Text";

@interface TFLParser () 

@property (nonatomic) TubeLine *tubeLine;
@property (nonatomic) NSMutableString *currentParsedStringData;
@property (nonatomic) BOOL accumulatingParsedCharacterData;
@property (nonatomic) BOOL cDataFlag;
@property (nonatomic) NSString *someString;
@property (nonatomic) int backgroundColorCount;
@property (nonatomic) NSString *titleString;

@end

@implementation TFLParser


- (void)parseData {
    
    dispatch_queue_t reentrantAvoidanceQueue = dispatch_queue_create("reentrantAvoidanceQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(reentrantAvoidanceQueue, ^{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_tubeLineData];
    [parser setDelegate:self];
    [parser parse];
    [self populateArrayOfTubeLinesThatHaveDelays];

        
    });
    dispatch_sync(reentrantAvoidanceQueue, ^{ });
    
}

- (instancetype)initWithData:(NSData *)parseData {
    
    self = [super init];
    if (self) {
        _tubeLineData = parseData;
        
        _parsedTubeLines = [[NSMutableArray alloc] init];
        _currentParsedStringData = [[NSMutableString alloc] init];
    }
    return self;
}

- (NSMutableArray *)populateArrayOfTubeLinesThatHaveDelays {
    
    self.delayedTubeLines = [[NSMutableArray alloc] init];
    
    
    for (int x = 1; x < self.parsedTubeLines.count; x++) {
        
        TubeLine *tubeLine = [self.parsedTubeLines objectAtIndex:(x -1)];
        
        if (![tubeLine.lineMessage isEqualToString:@"Good Service"]) {
            
            [self.delayedTubeLines addObject:tubeLine];
        }
    }
    return self.delayedTubeLines;
}

- (void)removeTitleFromMessage:(TubeLine *)tubeLine {
    
    if ([tubeLine.lineName isEqualToString:@"Overground"]) {
        
        self.titleString = @"LONDON OVERGROUND: ";
    } else  {
        
        self.titleString = [tubeLine.lineName stringByAppendingString:@" Line: "];
    }
    
    self.tubeLine.lineMessageWithoutTitle = [tubeLine.lineMessage stringByReplacingOccurrencesOfString:self.titleString withString:@""];
    self.tubeLine.lineMessageWithoutTitle = [tubeLine.lineMessage stringByReplacingOccurrencesOfString:self.titleString.uppercaseString
                                                                                            withString:@""];
}

                                             


#pragma mark - NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:kEntryElementName]) {
        TubeLine *tubeLine = [[TubeLine alloc] init];
        self.tubeLine = tubeLine;
        self.backgroundColorCount = 0;
    
    } else if ([elementName isEqualToString:kNameElementName] || [elementName isEqualToString:kStatusTextElementName]) {
        
        self.accumulatingParsedCharacterData = YES;
        self.cDataFlag = YES;
        [self.currentParsedStringData setString:@""];
    } else if ([elementName isEqualToString:kBackgroundColorElementName] && self.backgroundColorCount == 0) {
        
        self.accumulatingParsedCharacterData = YES;
        [self.currentParsedStringData setString:@""];
        
        
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:kEntryElementName]) {
        
        [self.parsedTubeLines addObject:self.tubeLine];
        
    } else if ([elementName isEqualToString:kNameElementName]) {
        
        self.tubeLine.lineName = self.currentParsedStringData;
    }
    
    else if ([elementName isEqualToString:kStatusTextElementName]) {
        self.cDataFlag = NO;
        
        
    
    } else if ([elementName isEqualToString:kBackgroundColorElementName] && self.backgroundColorCount == 0) {

        
        self.tubeLine.lineBackgroundColor =  self.currentParsedStringData;
        self.tubeLine.lineBackgroundUIColor = [self getUIColorObjectFromHexString:self.tubeLine.lineBackgroundColor alpha:1.0];
        self.backgroundColorCount++;
    }
    
    self.accumulatingParsedCharacterData = NO;
    self.currentParsedStringData = [[NSMutableString alloc] init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (self.accumulatingParsedCharacterData) {

        [self.currentParsedStringData appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{

    if (self.cDataFlag) {
        
        
        
    self.tubeLine.lineMessage = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        
    [self removeTitleFromMessage:self.tubeLine];
        
    }
    
}

#pragma mark - Color operations

- (unsigned int)intFromHexString:(NSString *)hexStr {
    
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    
    unsigned int hexint = [self intFromHexString:hexStr];
    
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

@end
