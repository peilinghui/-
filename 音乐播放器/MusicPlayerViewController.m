//
//  MusicPlayerViewController.m
//  音乐播放器
//
//  Created by peilinghui on 15/11/23.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "PlayerToolBar.h"
#import "MJExtension.h"
#import "Music.h"
#import "MusicCell.h"
#import "MusicTool.h"
#import "AppDelegate.h"

@interface MusicPlayerViewController ()<UITableViewDataSource,UITabBarDelegate,PlayerToolBarDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//当前音乐播放的索引
@property(assign,nonatomic)NSInteger musicIndex;


@property(strong,nonatomic)NSArray *musics;//音乐数据
@property(weak,nonatomic)PlayerToolBar *playerToolBar;
@end

@implementation MusicPlayerViewController

#pragma mark 懒加载音乐数
-(NSArray *)musics{
    if (!_musics) {
        _musics = [Music objectArrayWithFilename:@"songs.plist"];
            }
    
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.添加“播放工具条”
    PlayerToolBar *toolBar = [ PlayerToolBar playerToolBar];
    //设置toolbar尺寸
    toolBar.bounds = self.bottomView.bounds;
    //设置代理
    toolBar.delegate = self;
    [self.bottomView addSubview:toolBar];
    self.playerToolBar =toolBar;

    //设置表格的透明度
   // self.tableView.alpha =0.3;
    //2.设置表格的背景颜色为透明
    self.tableView.backgroundColor = [UIColor clearColor];
  //  [self.tableView registerClass:[MusicCell class] forCellReuseIdentifier:@"MusicCell"];
    //4.初始化“音乐工具类”里地播放器
  //  [[MusicTool sharedMusicTool] prepareToPlayWithMusic:self.musics[self.musicIndex]];
    //3.初始化播放的音乐
 //   toolBar.playingMusic = self.musics[self.musicIndex];

    [self playermusic];
    //设置appdelegate的block
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.mRemoteEventBlock = ^(UIEvent *event){
        //        UIEventSubtypeRemoteControlPlay                播放
        //        UIEventSubtypeRemoteControlPause               暂停,
        //        UIEventSubtypeRemoteControlStop                停止,
        //        UIEventSubtypeRemoteControlPreviousTrack      上一首
        //        UIEventSubtypeRemoteControlNextTrack下一首
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"play");
                [[MusicTool sharedMusicTool]play];
                break;
            case UIEventSubtypeRemoteControlPause:
                NSLog(@"Pause");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"Previous");
                [self previous];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"Next");
                [self next];
                break;
        }
    };
}
#pragma mark 表格的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.musics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //自定义的Cell
    MusicCell *cell = [MusicCell musicCellWithTableView:tableView];
    
    //设置数据
    Music *music = self.musics[indexPath.row];
    
    cell.music = music;
    
    return cell;
}
#pragma mark 播放工具条的代理
-(void)playerToolBar:(PlayerToolBar *)toolbar btnClickWithType:(BtnType)btnType{
    //实现这个播放，把播放的操作放在一个工具类
    switch (btnType) {
        case BtnTypePlay:
            NSLog(@"BtnTypePlay");
           [[MusicTool sharedMusicTool] play];
            break;
        case BtnTypePause:
            NSLog(@"BtnTypePause");
           [[MusicTool sharedMusicTool] pause];
            break;
        case BtnTypePrevious:
            NSLog(@"BtnTypePrevious");
            [self previous];
            break;
        case BtnTypeNext:
            NSLog(@"BtnTypeNext");
            [self next];
            break;
            
    }
}
#pragma mark 播放上一首
- (void)previous{
    if (self.musicIndex == 0) {
        self.musicIndex = self.musics.count - 1;
    }else{
        self.musicIndex --;
    }
    [self playermusic];
}
#pragma mark 播放下一首
- (void)next{
    //1.更改播放的索引
    if(self.musicIndex == self.musics.count - 1){
        self.musicIndex = 0;
    }else{
        self.musicIndex ++;
    }
    [self playermusic];
   }
- (void)playermusic{
    //1.重新初始化一个“播放器”
    [[MusicTool sharedMusicTool]prepareToPlayWithMusic:self.musics[self.musicIndex]];
    //2.设置player的代理
    [MusicTool sharedMusicTool].player.delegate = self;
    //3.更改“播放工具条”的数据
    self.playerToolBar.playingMusic = self.musics[self.musicIndex];
 

    //4.播放
    if (self.playerToolBar.isplaying) {
        [[MusicTool sharedMusicTool]play];
    }
}
#pragma mark 表格的选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath{
    //更改索引
    self.musicIndex = indexPath.row;
    //播放音乐
    [self playermusic];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark 播放器的代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //一首歌播放完，自动播放下一首
    [self next];
}
@end
