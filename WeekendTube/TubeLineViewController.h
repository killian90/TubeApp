//
//  TubeLineViewController.h
//  WeekendTube
//
//  Created by Killian O Connell on 28/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TubeLine.h"

@interface TubeLineViewController : UIViewController

//@property (nonatomic) TubeLine *tubeLine;
@property (nonatomic, weak) IBOutlet UILabel *tubeLineName;
@property (nonatomic, weak) IBOutlet UITextView *tubeLineMessage;
@property (nonatomic, weak) IBOutlet UIImageView *tubeLineImage;


@end
