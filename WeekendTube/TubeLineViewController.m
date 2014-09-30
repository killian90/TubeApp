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

@property (nonatomic) UIVisualEffectView *effectView;

@property (nonatomic) NSUserDefaults *sharedDefaults;

@end

@implementation TubeLineViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.koc.extensiontest"];
    
        NSData *encodedObject = [self.sharedDefaults objectForKey:@"currentTubeData"];
        TubeLine *tubeLine = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    
    self.tubeLineName.text = tubeLine.lineName;
    self.tubeLineName.font = [UIFont openSansLightFontOfSize:18.0f];
    self.tubeLineName.textColor = [UIColor whiteColor];
    self.tubeLineName.backgroundColor = tubeLine.lineBackgroundUIColor;
    self.tubeLineName.layer.cornerRadius = 5;
    self.tubeLineName.clipsToBounds = YES;
    
    self.tubeLineMessage.font = [UIFont openSansLightFontOfSize:18.0f];
    self.tubeLineMessage.text = tubeLine.lineMessage;
    self.tubeLineMessage.textColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
//    
//    self.tubeLineName.text = self.tubeLine.lineName;
//    self.tubeLineName.font = [UIFont openSansLightFontOfSize:18.0f];
//    self.tubeLineName.textColor = [UIColor whiteColor];
//    self.tubeLineName.backgroundColor = self.tubeLine.lineBackgroundUIColor;
//    self.tubeLineName.layer.cornerRadius = 5;
//    self.tubeLineName.clipsToBounds = YES;
//    
//    self.tubeLineMessage.font = [UIFont openSansLightFontOfSize:18.0f];
//    self.tubeLineMessage.text = self.tubeLine.lineMessage;
//    self.tubeLineMessage.textColor = [UIColor darkGrayColor];
    
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
