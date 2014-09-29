//
//  ViewController.m
//  WeekendTube
//
//  Created by Killian O Connell on 20/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import "ViewController.h"
#import "TFLParser.h"
#import "TubeLine.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

//- (void)viewDidLoad {
//    
//    [super viewDidLoad];
//    
//    NSURLRequest *affectedTubeLineURLRequest =
//    [NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
//    
//    [NSURLConnection sendAsynchronousRequest:affectedTubeLineURLRequest
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               
//                               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//                               
//                               if (response && !error) {
//                                   TFLParser *tflParser = [[TFLParser alloc] initWithData:data];
//                                   [tflParser parseData];
//                                   
//                                   [self createTubeLineViews:[self createArrayOfTubeLinesThatHaveDelays:tflParser]];
//                               }
//                           }];
//}
//
//- (NSMutableArray *)createArrayOfTubeLinesThatHaveDelays:(TFLParser *)parser {
//    
//    NSMutableArray *delayedLines = [[NSMutableArray alloc] init];
//    
//    for (int x = 1; x < parser.parsedTubeLines.count; x++) {
//        
//        TubeLine *tubeLine = [parser.parsedTubeLines objectAtIndex:(x -1)];
//        
//        if (![tubeLine.lineMessage isEqualToString:@"Good Service"]) {
//            
//            [delayedLines addObject:tubeLine];
//        }
//    }
//    return  delayedLines;
//}
//
//
//- (void)createTubeLineViews:(NSMutableArray *)array {
//    
//    
//    for (int x = 1; x < array.count; x++) {
//        
//        TubeLine *tubeLine = [array objectAtIndex:(x -1)];
//        
//        UIButton *button;
//        
//        if (x % 2) {
//            
//            button = [[UIButton alloc] initWithFrame:CGRectMake(kOddBeginningXPos, kBeginningYPos, 100, 20)];
//        } else {
//            
//            button = [[UIButton alloc] initWithFrame:CGRectMake(kEvenBeginningXPos, kBeginningYPos, 100, 20)];
//            kBeginningYPos = kBeginningYPos + kYIncrementor;
//        }
//        
//        
//        button.backgroundColor = [self getUIColorObjectFromHexString:tubeLine.lineBackgroundColor alpha:1.0];
//        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
//        nameLabel.text = tubeLine.lineName;
//        nameLabel.textColor = [UIColor whiteColor];
//        [button addSubview:nameLabel];
//        [self.view addSubview:button];
//    }
//}
//
//- (unsigned int)intFromHexString:(NSString *)hexStr
//{
//    unsigned int hexInt = 0;
//    
//    // Create scanner
//    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
//    
//    // Scan hex value
//    [scanner scanHexInt:&hexInt];
//    
//    return hexInt;
//}
//
//- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
//{
//    // Convert hex string to an integer
//    unsigned int hexint = [self intFromHexString:hexStr];
//    
//    // Create color object, specifying alpha as well
//    UIColor *color =
//    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
//                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
//                     blue:((CGFloat) (hexint & 0xFF))/255
//                    alpha:alpha];
//    
//    return color;
//}


@end
