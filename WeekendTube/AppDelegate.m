//
//  AppDelegate.m
//  WeekendTube
//
//  Created by Killian O Connell on 20/09/2014.
//  Copyright (c) 2014 Killian O Connell. All rights reserved.
//

#import "AppDelegate.h"
#import "TFLParser.h"
#import "TubeLine.h"
#import "TubeLineViewController.h"
#import <OpenSans/UIFont+OpenSans.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    NSString *tubeLineName = [url host];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.koc.extensiontest"];
    
    if ([defaults objectForKey:@"weekendData"]) {
        
        NSData *tubeData = [[defaults objectForKey:@"weekendData"] copy];
        
        TFLParser *parser = [[TFLParser alloc] initWithData:tubeData];
        [parser parseData];
        for (int x = 0; x < parser.delayedTubeLines.count; x++) {
            
            TubeLine *tl = [[TubeLine alloc] init];
            tl = [parser.delayedTubeLines objectAtIndex:x];
            if ([tl.lineName isEqualToString:tubeLineName]) {
                
                [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                TubeLineViewController *tubeLineViewController = [storyboard instantiateViewControllerWithIdentifier:@"TubeLineViewController"];
                
                [self.window.rootViewController presentViewController:tubeLineViewController animated:YES completion:nil];
                return YES;
            }
        }
    }
    
    
    UIViewController *vc = [[TubeLineViewController alloc] init];
    [self.window.rootViewController presentViewController:vc
                                                 animated:NO
                                               completion:nil];
    vc.view.backgroundColor = [UIColor redColor];
    
    
    
    
    return YES;
}

@end
