//
//  FTMPAppDelegate.m
//  Fotomap
//
//  Created by Matt Quiros on 5/24/14.
//  Copyright (c) 2014 ActionStack. All rights reserved.
//

#import "FTMPAppDelegate.h"

#import "FTMPHomeViewController.h"

@implementation FTMPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FTMPHomeViewController *homeViewController = [[FTMPHomeViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    self.window.rootViewController = navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
