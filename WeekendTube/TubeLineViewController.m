//
//  TubeLineViewController.m
//  WeekendTube
//
//  Created by Killian O Connell on 28/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import "TubeLineViewController.h"
#import <OpenSans/UIFont+OpenSans.h>

@interface TubeLineViewController ()
@property (nonatomic) TubeLine *tubeLine;
@property (weak, nonatomic) IBOutlet UILabel *tubeLineName;
@property (weak, nonatomic) IBOutlet UITextView *tubeLineMessage;
@property (strong, nonatomic) IBOutlet UIImageView *tubeLineImage;
@property (nonatomic) UIVisualEffectView *effectView;



@end

@implementation TubeLineViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {

    }
    
    return self;
}

- (void)loadTubeLineData:(TubeLine *)tubeLine {
    
    self.tubeLine = tubeLine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tubeLineName.text = self.tubeLine.lineName;
    UIColor *color1 = self.tubeLine.lineBackgroundUIColor;
    self.tubeLineName.backgroundColor = [color1 colorWithAlphaComponent:0.8f];
    self.tubeLineName.font = [UIFont openSansLightFontOfSize:18.0f];
//    self.tubeLineMessage.font = [UIFont openSansLightFontOfSize:18.0f];
    
//    self.tubeLineMessage.text = self.tubeLine.lineMessage;
    self.tubeLineName.textColor = [UIColor whiteColor];
    
    
//    
//    UIBlurEffect *rightBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    self.effectView = [[UIVisualEffectView alloc]initWithEffect:rightBlurEffect];
//    self.effectView.frame = self.tubeLineImage.frame;
//    
//    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:rightBlurEffect];
//    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
//    vibrancyEffectView.frame = self.tubeLineImage.frame;
//    
//
//        [vibrancyEffectView addConstraints:self.tubeLineImage.constraints];
//    [self.effectView addConstraints:self.tubeLineImage.constraints];
//    
//
//    [[vibrancyEffectView contentView] addSubview:self.tubeLineImage];
//    [[self.effectView contentView] addSubview:vibrancyEffectView];
//    
    
    
    self.effectView.center = self.tubeLineImage.center;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
