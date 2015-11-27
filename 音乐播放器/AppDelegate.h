//
//  AppDelegate.h
//  音乐播放器
//
//  Created by peilinghui on 15/11/22.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PlayerRemoteEventBlock)(UIEvent *event);//播放器远程事件block

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(copy,nonatomic)PlayerRemoteEventBlock mRemoteEventBlock;

@end

