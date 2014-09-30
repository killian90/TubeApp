//
//  TubeLine.m
//  WeekendTube
//
//  Created by Killian O Connell on 20/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import "TubeLine.h"

@implementation TubeLine

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.lineName forKey:@"lineName"];
    [encoder encodeObject:self.lineColor forKey:@"lineColor"];
    [encoder encodeObject:self.lineBackgroundColor forKey:@"lineBackgroundColor"];
    [encoder encodeObject:self.lineBackgroundUIColor forKey:@"lineBackgroundUIColor"];
    [encoder encodeObject:self.lineURL forKey:@"lineURL"];
    [encoder encodeObject:self.lineStatus forKey:@"lineStatus"];
    [encoder encodeObject:self.lineMessage forKey:@"lineMessage"];
    [encoder encodeObject:self.lineMessageWithoutTitle forKey:@"lineMessageWithoutTitle"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.lineName = [decoder decodeObjectForKey:@"lineName"];
        self.lineColor = [decoder decodeObjectForKey:@"lineColor"];
        self.lineBackgroundColor = [decoder decodeObjectForKey:@"lineBackgroundColor"];
        self.lineBackgroundUIColor = [decoder decodeObjectForKey:@"lineBackgroundUIColor"];
        self.lineURL = [decoder decodeObjectForKey:@"lineURL"];
        self.lineStatus = [decoder decodeObjectForKey:@"lineStatus"];
        self.lineMessage = [decoder decodeObjectForKey:@"lineMessage"];
        self.lineMessageWithoutTitle = [decoder decodeObjectForKey:@"lineMessageWithoutTitle"];
    }
    return self;
}

@end
