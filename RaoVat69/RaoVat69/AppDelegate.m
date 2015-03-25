//
//  AppDelegate.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/20/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "AppDelegate.h"
#import <GooglePlus/GooglePlus.h>


@interface AppDelegate()<CLLocationManagerDelegate>
@property (strong, nonatomic)CLLocationManager  *locationManager;
@end


@implementation AppDelegate{
    
}
@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [UserGoole share];
    
    [self performSelectorOnMainThread:@selector(RequestLocation) withObject:nil waitUntilDone:YES];
    [self RunNotification:application];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


-(void)RunNotification:(UIApplication *)application{
    UIUserNotificationType type = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
    if (type == UIUserNotificationTypeNone){
        NSLog(@"Disable notiication");
    }
    
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    // 2
    [application registerUserNotificationSettings:settings];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 3
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        // 4
        [application registerForRemoteNotifications];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"didReceiveRemoteNotification: %@",userInfo);
}
// 5
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"deviceToken: %@",deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@",error.userInfo);
}





#pragma mark ---LocationUpdate-----


-(void)RequestLocation{
    NSLog(@"run update location");
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate =(id)self;

    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
}
- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message  delegate:self cancelButtonTitle:nil otherButtonTitles:@"Settings", nil];
        alertView.tag=69;
        [alertView show];
    }
    
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==69) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [self requestAlwaysAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    NSLog(@"%@", [locations lastObject]);
}
#pragma mark -

#pragma mark ---DelegateForFacebook-----
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"url open: %@",url.absoluteString);
    if ([url.absoluteString rangeOfString:@"fb343857559153159"].location!=NSNotFound) {
        return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[UserFB share].session];
    }else{
        if ([url.absoluteString rangeOfString:@"com.app69.raovat"].location!=NSNotFound) {
            return [GPPURLHandler handleURL:url  sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {    
    [[UserFB share].session close];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActiveWithSession:[UserFB share].session];
}
#pragma mark -



@end
