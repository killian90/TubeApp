//
//  TodayViewController.m
//  WeekendTubeExt
//
//  Created by Killian OConnell on 24/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

//TODO - get rid of magic numbers

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TFLParser.h"
#import "TubeLine.h"
#import "AYVibrantButton.h"

//TODO - plist this
static NSString *feedURLString = @"http://data.tfl.gov.uk/tfl/syndication/feeds/TubeThisWeekend_v2.xml?app_id=9899e1a8&app_key=6ccf5cb5eb5c0e2eb803226684e74785";
static int kBeginningXPos = 10;
static int kBeginningYPos = 40;
static int kYIncrementor = 40;
static int kMoreInfoButtonHeight = 40;
static int kSegmentedControlHeight = 22;

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic) NSMutableArray *delayedLines;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSString *truncatedString;
@property (nonatomic) AYVibrantButton *tapForMoreButton;
@property (nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic) UIVisualEffectView *vibrantSegmentedControlView;
@property (nonatomic) TubeLine *expanededTubeLine;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.preferredContentSize = CGSizeMake(320, 50);
    
    NSURLRequest *affectedTubeLineURLRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
    
    [NSURLConnection sendAsynchronousRequest:affectedTubeLineURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (response && !error) {
                                   
                                   NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.koc.extensiontest"];
                                   
                                   [sharedDefaults setObject:data forKey:@"weekendData"];
                                   [sharedDefaults synchronize];
                                   
                                   
                                   TFLParser *tflParser = [[TFLParser alloc] initWithData:data];
                                   [tflParser parseData];
                                   self.delayedLines = tflParser.delayedTubeLines;
                                   
                                   [self createTubeLineViews:self.delayedLines];
                                   
                               }
                           }];
    
    [self setupUISegmentedControl];
    [self applyVisualEffectsToSegmentedControl];

    [self.view addSubview:self.vibrantSegmentedControlView];
}

- (void)createTubeLineViews:(NSMutableArray *)array {
    
    for (int x = 0; x < array.count; x++) {
        
        TubeLine *tubeLine = [array objectAtIndex:x];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kBeginningXPos,
                                                                      kBeginningYPos + (kYIncrementor * x),
                                                                      110,
                                                                      30)];
        
        [button addTarget:self action:@selector(didPressTubeLineButton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [self getUIColorObjectFromHexString:tubeLine.lineBackgroundColor alpha:1.0];
        button.layer.cornerRadius = 5;
        [button setTitle:tubeLine.lineName forState:UIControlStateNormal];
        
        [self.view addSubview:button];
    }
    
    self.preferredContentSize = CGSizeMake(320, array.count * 40 +kMoreInfoButtonHeight + kSegmentedControlHeight + 30 );
    self.messageLabel = [[UILabel alloc] init];
    self.imageView = [[UIImageView alloc] init];
}

//TODO - replace this with actual chevron
- (UIView *)createChevronIndicator:(int)buttonPosition {
    
    self.imageView.image = [UIImage imageNamed:@"dotIndicator"];
    self.imageView.frame = CGRectMake(124, (kBeginningYPos + (kYIncrementor * buttonPosition) +kSegmentedControlHeight), 5, 5);
    return self.imageView;
}

- (void)setupTubeLineMessageLabel {

    self.messageLabel.textColor = [UIColor whiteColor];
    [self.messageLabel setFont:[UIFont systemFontOfSize:14]];
    self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.frame = CGRectMake(140, self.segmentedControl.frame.size.height + 10, 165, self.view.bounds.size.height);
}

- (void)truncateMessage:(NSString *)string BasedOnNumberOfTubeLineViews:(int)TubeLineViews {
    
    if (string.length > (50 * TubeLineViews)) {
        
        string = [string substringToIndex:(50 * TubeLineViews)];
        self.truncatedString = [string stringByAppendingString:@"..."];
        self.messageLabel.text = self.truncatedString;
        [self.messageLabel sizeToFit];
        
    } else {
        
        self.messageLabel.text = string;
       [self.messageLabel sizeToFit];
        
    }
}

- (void)createAndShowLinkToTubeLinePage:(TubeLine *)tubeLine {
    
    if (!self.tapForMoreButton) {
        self.tapForMoreButton = [[AYVibrantButton alloc] initWithFrame:CGRectMake(130, self.messageLabel.frame.size.height + 15, 160, 20) style:AYVibrantButtonStyleInvert];
        self.tapForMoreButton.vibrancyEffect = [UIVibrancyEffect notificationCenterVibrancyEffect];
        self.tapForMoreButton.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
        self.tapForMoreButton.font = [UIFont systemFontOfSize:14];
        self.tapForMoreButton.text = @"Tap Here for more";
        [self.tapForMoreButton addTarget:self action:@selector(openTubeLinePage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.tapForMoreButton];
    }
    
    self.tapForMoreButton.frame = CGRectMake(130, self.messageLabel.frame.size.height + self.messageLabel.frame.origin.y + 10, 160, 20);
}



#pragma mark SegmentedControl methods

- (void)applyVisualEffectsToSegmentedControl {
    
    UIBlurEffect *rightBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.vibrantSegmentedControlView = [[UIVisualEffectView alloc]initWithEffect:rightBlurEffect];
    self.vibrantSegmentedControlView.frame = CGRectMake(0, 0, 200, 22);
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:rightBlurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    vibrancyEffectView.frame = CGRectMake(0, 0, 200, 22);
    
    [[vibrancyEffectView contentView] addSubview:self.segmentedControl];
    [[self.vibrantSegmentedControlView contentView] addSubview:vibrancyEffectView];
    
    self.vibrantSegmentedControlView.center = CGPointMake(self.view.center.x, 15);
}

- (void)setupUISegmentedControl {
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Today", @"Weekend"]];
    self.segmentedControl.frame = CGRectMake(0, 0, 200, 22);
    self.segmentedControl.selectedSegmentIndex = 1;
    [self.segmentedControl addTarget:self action:@selector(didChangeSegmentedControlIndex) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didChangeSegmentedControlIndex {
    
    //TODO - parse current feeds
    
    
}



#pragma mark - widget specific methods

//this gets rid of the left margin
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    
    return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    completionHandler(NCUpdateResultNewData);
}



#pragma mark - IBActions

- (IBAction)didPressTubeLineButton:(UIButton *)sender {
    
    for (int x = 0; x < self.delayedLines.count; x++) {
        
        TubeLine *tubeLine = [self.delayedLines objectAtIndex:x];
        
        if ([tubeLine.lineName isEqualToString:sender.titleLabel.text]) {
            
            [self setupTubeLineMessageLabel];
            [self truncateMessage:tubeLine.lineMessageWithoutTitle BasedOnNumberOfTubeLineViews:self.delayedLines.count];
            self.expanededTubeLine = tubeLine;
            
            [self.view addSubview:self.messageLabel];
            [self.view insertSubview:[self createChevronIndicator:x] aboveSubview:self.messageLabel];
            [self createAndShowLinkToTubeLinePage:tubeLine];

        }
    }
}

- (IBAction)tubeSegmentedControlAction:(id)sender {

    
}

- (IBAction)openTubeLinePage:(AYVibrantButton *)sender {
    
    NSString *url = [NSString stringWithFormat:@"openfromweekendextension://%@", self.expanededTubeLine.lineName ];
    //NSString *url = [NSString stringWithFormat:@"openfromweekendextension://"];
    
    NSExtensionContext *myExtension=[self extensionContext];
    [myExtension openURL:[NSURL URLWithString:url] completionHandler:nil];
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
