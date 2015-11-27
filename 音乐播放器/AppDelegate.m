//
//  AppDelegate.m
//  音乐播放器
//
//  Created by peilinghui on 15/11/22.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置音乐后台播放的会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    //开启接收远程事件
    [application beginReceivingRemoteControlEvents];
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   //开启后台任务
    [application beginBackgroundTaskWithExpirationHandler:nil];
    
}
#pragma mark 接收远程事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    //判断是否为远程事件
    if (event.type == UIEventTypeRemoteControl) {
        NSLog(@"接收到远程事件");
        //调用block
        self.mRemoteEventBlock(event);
    }
}

@end
