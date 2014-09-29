//
//  TubeLine.h
//  WeekendTube
//
//  Created by Killian O Connell on 20/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TubeLine : NSObject

@property (nonatomic) NSString *lineName;
@property (nonatomic) NSString *lineColor;
@property (nonatomic) NSString *lineBackgroundColor;
@property (nonatomic) UIColor *lineBackgroundUIColor;
@property (nonatomic) NSString *lineURL;
@property (nonatomic) NSString *lineStatus;
@property (nonatomic) NSString *lineMessage;
@property (nonatomic) NSString *lineMessageWithoutTitle;

@end
