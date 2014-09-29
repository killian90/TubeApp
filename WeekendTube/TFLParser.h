//
//  TFLParser.h
//  WeekendTube
//
//  Created by Killian O Connell on 20/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TFLParser : NSObject <NSXMLParserDelegate>

- (id)initWithData:(NSData *)parseData;
- (void)parseData;


@property (copy, readonly) NSData *tubeLineData;
@property (nonatomic) NSMutableArray *parsedTubeLines;
@property (nonatomic) NSMutableArray *delayedTubeLines;


@end
