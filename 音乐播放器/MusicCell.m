//
//  MusicCell.m
//  音乐播放器
//
//  Created by peilinghui on 15/11/23.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import "MusicCell.h"
#import "Music.h"

@implementation MusicCell

+(instancetype)musicCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MusicCell";
    return [tableView dequeueReusableCellWithIdentifier:ID];
    
}

//显示cell的数据
-(void)setMusic:(Music *)music{
    _music = music;
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
}


@end
