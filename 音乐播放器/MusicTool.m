//
//  MusicTool.m
//  音乐播放器
//
//  Created by peilinghui on 15/11/24.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import "MusicTool.h"
#import "Music.h"
#import <MediaPlayer/MediaPlayer.h>
@interface  MusicTool()
@end

@implementation MusicTool
singleton_implementation(MusicTool)

-(void)prepareToPlayWithMusic:(Music *)music{
    //创建播放器
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    
    //准备
    [self.player prepareToPlay];
    
    //建议，锁屏信息最好在程序退出到后台的时候
    //设置锁屏音乐信息
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    //设置专辑名称
    info[MPMediaItemPropertyAlbumTitle] = @"中文十大金曲";
    //设置歌曲名
    info[MPMediaItemPropertyTitle] = music.name;
    //设置歌手
    info[MPMediaItemPropertyArtist] = music.singer;
    //设置专辑的图片
    UIImage *img = [UIImage imageNamed:music.icon];
    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc]initWithImage:img];
    info[MPMediaItemPropertyArtwork] = artwork;
    //设置时间
    info[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;
    
}

-(void)play{
    [self.player play];
}


-(void)pause{
    [self.player pause];
}
@end
