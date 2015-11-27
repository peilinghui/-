//
//  PlayerToolBar.h
//  音乐播放器
//
//  Created by peilinghui on 15/11/22.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BtnTypePlay,//播放
    BtnTypePause,//暂停
    BtnTypePrevious,//上一首
    BtnTypeNext//下一首
}BtnType;

@class Music,PlayerToolBar;
@protocol PlayerToolBarDelegate <NSObject>

- (void)playerToolBar:(PlayerToolBar *)toolbar btnClickWithType:(BtnType)btnType;

@end
@interface PlayerToolBar : UIView

+ (instancetype)playerToolBar;

@property(assign,nonatomic,getter=isplaying)BOOL playing;//播放状态，默认暂停状态

@property(nonatomic,strong)Music *playingMusic;//当前播放的音乐
@property(nonatomic,weak)id<PlayerToolBarDelegate> delegate;
@end
