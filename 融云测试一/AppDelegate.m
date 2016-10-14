//
//  AppDelegate.m
//  融云测试一
//
//  Created by 张雨生 on 16/7/29.
//  Copyright © 2016年 meilun. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import <UIKit/UIKit.h>

#import "YourTestChatListViewController.h"

#define RONGCLOUD_IM_APPKEY @"ik1qhw0911ysp"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(UIWindow *)window{
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //融云即时通讯
    
    //初始化融云SDK。
    
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    /**
     
     * 推送处理1
     
     */
    
    if ([application
         
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        //注册推送, iOS 8
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  
                                                                  UIUserNotificationTypeSound |
                                                                  
                                                                  UIUserNotificationTypeAlert)
                                                
                                                categories:nil];
        
        [application registerUserNotificationSettings:settings];
        
    } else {
        
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        
        UIRemoteNotificationTypeAlert |
        
        UIRemoteNotificationTypeSound;
        
        [application registerForRemoteNotificationTypes:myTypes];
        
    }
    
    //融云即时通讯
    
    [[NSNotificationCenter defaultCenter]
     
     addObserver:self
     
     selector:@selector(didReceiveMessageNotification:)
     
     name:RCKitDispatchMessageNotification
     
     object:nil];
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    //加入到方法中的代码到这里
    
    //注意这里下面的4行，根据自己需要修改  也可以注释了，但是只能注释这4行，网络状态变化这个方法一定要实现
    
//    ViewController *loginVC = [[ViewController alloc] init];
    
    YourTestChatListViewController * list = [[YourTestChatListViewController alloc] init];
    
//    list.automaticallyAdjustsScrollViewInsets = YES;
    
    
    UINavigationController *_navi =
    
    [[UINavigationController alloc] initWithRootViewController:list];
    
    self.window.rootViewController = _navi;
    [self.window makeKeyAndVisible];

    

    
    return YES;
}

// 下面是单独的方法  直接加在AppDelegate.m的文件中即可

/**
 
 *  将得到的devicetoken 传给融云用于离线状态接收push ，您的app后台要上传推送证书
 
 *
 
 *  @param application <#application description#>
 
 *  @param deviceToken <#deviceToken description#>
 
 */
- (void)application:(UIApplication *)application

didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token =
    
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
       
                                                           withString:@""]
      
      stringByReplacingOccurrencesOfString:@">"
      
      withString:@""]
     
     stringByReplacingOccurrencesOfString:@" "
     
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
    
}

/**
 
 *  网络状态变化。
 
 *
 
 *  @param status 网络状态。
 
 */

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"提示"
                              
                              message:@"您"
                              
                              @"的帐号在别的设备上登录，您被迫下线！"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"知道了"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];
        

        
    }
    
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    
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

@end
