//
//  MusicTool.h
//  音乐播放器
//
//  Created by peilinghui on 15/11/24.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <AVFoundation/AVFoundation.h>
@class Music;
@interface MusicTool : NSObject
singleton_interface(MusicTool)
@property(nonatomic,strong)AVAudioPlayer *player;//播放器
/*
 *音乐播放前的准备工作
 */
-(void)prepareToPlayWithMusic:(Music *)music;
/*
 *播放
 */
-(void)play;
/*
 *暂停
 */
-(void)pause;

@end
