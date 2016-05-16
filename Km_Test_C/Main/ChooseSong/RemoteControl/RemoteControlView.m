//
//  RemoteControlView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RemoteControlView.h"


@implementation RemoteControlView

- (instancetype)init{
    if (self = [super init]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self setFrame:kSCREEN_BOUNDS];
    self.backgroundColor = RGB(50, 45, 55);
    CGFloat fontSize = 13.0f;
    
    //TODO:todo custombutton
    //top
    UIButton *servicesBtn = [[UIButton alloc]init];
    [servicesBtn setImage:[UIImage imageNamed:@"btn_service_normal"] forState:UIControlStateNormal];
    [servicesBtn setImage:[UIImage imageNamed:@"btn_service_hl"] forState:UIControlStateNormal];
    [servicesBtn.imageView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:servicesBtn];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"没有绑定包厢啦，快点去绑定吧"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:titleLabel];
    
    [servicesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 120));
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(20);
    }];
    
    
    //centerplayctrl_new_acc_hlz
    UIButton *oriaccButton = [UIButton new];
    [oriaccButton setImage:[UIImage imageNamed:@"playctrl_new_acc"] forState:UIControlStateNormal];
    [oriaccButton setImage:[UIImage imageNamed:@"playctrl_new_acc_hl"] forState:UIControlStateHighlighted];
    
    UIButton *cutsongButton = [UIButton new];
    [cutsongButton setImage:[UIImage imageNamed:@"btn_cut_song_n2"] forState:UIControlStateNormal];
    [cutsongButton setImage:[UIImage imageNamed:@"btn_cut_song_hl2"] forState:UIControlStateHighlighted];
    
    UIButton *pauseplayButton = [UIButton new];
    [pauseplayButton setImage:[UIImage imageNamed:@"playctrl_new_play"] forState:UIControlStateNormal];
    [pauseplayButton setImage:[UIImage imageNamed:@"playctrl_new_play_hl"] forState:UIControlStateHighlighted];
    
    UIButton *resongButton = [UIButton new];
    [resongButton setImage:[UIImage imageNamed:@"playctrl_new_replay"] forState:UIControlStateNormal];
    [resongButton setImage:[UIImage imageNamed:@"playctrl_new_replay_hl"] forState:UIControlStateHighlighted];
    
    [self addSubview:oriaccButton];
    [self addSubview:cutsongButton];
    [self addSubview:pauseplayButton];
    [self addSubview:resongButton];
    
    
    [cutsongButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).with.offset(15);
        make.bottom.equalTo(self.mas_centerY).with.offset(-40);
        make.size.mas_offset(CGSizeMake(100, 100));
    }];
    
    [pauseplayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cutsongButton.mas_right).with.offset(-8);
        make.centerY.equalTo(cutsongButton);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    
    [oriaccButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cutsongButton.mas_left).with.offset(8);
        make.centerY.equalTo(cutsongButton);
        make.size.mas_offset(CGSizeMake(70, 70));
    }];
    
    [resongButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pauseplayButton.mas_right).with.offset(-12);
        make.centerY.equalTo(cutsongButton);
        make.size.mas_offset(CGSizeMake(70, 70));
    }];
    
    
    //title
    UILabel *oriaccLabel = [UILabel new];
    oriaccLabel.font = [UIFont systemFontOfSize:fontSize];
    oriaccLabel.textColor = [UIColor whiteColor];
    oriaccLabel.text = @"原/伴";
    
    UILabel *cutsongLabel = [UILabel new];
    cutsongLabel.font = [UIFont systemFontOfSize:fontSize];
    cutsongLabel.textColor = [UIColor whiteColor];
    cutsongLabel.text = @"切歌";
    
    UILabel *pauseplayLabel = [UILabel new];
    pauseplayLabel.font = [UIFont systemFontOfSize:fontSize];
    pauseplayLabel.textColor = [UIColor whiteColor];
    pauseplayLabel.text = @"播放/停";
    
    UILabel *resongLabel = [UILabel new];
    resongLabel.font = [UIFont systemFontOfSize:fontSize];
    resongLabel.textColor = [UIColor whiteColor];
    resongLabel.text = @"重唱";
    
    [self addSubview:oriaccLabel];
    [self addSubview:cutsongLabel];
    [self addSubview:pauseplayLabel];
    [self addSubview:resongLabel];
    
    [oriaccLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(oriaccButton.mas_centerX);
        make.bottom.equalTo(cutsongButton).with.offset(20);
    }];
    
    [cutsongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cutsongButton.mas_centerX);
        make.bottom.equalTo(oriaccLabel);
    }];
    
    [pauseplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pauseplayButton.mas_centerX);
        make.bottom.equalTo(oriaccLabel);
    }];
    
    [resongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(resongButton.mas_centerX);
        make.bottom.equalTo(oriaccLabel);
    }];
    
    // playctrl_new_vol-0
    UIButton *mpMinButton = [UIButton new];
    [mpMinButton setImage:[UIImage imageNamed:@"playctrl_new_vol-0"] forState:UIControlStateNormal];
    [mpMinButton setImage:[UIImage imageNamed:@"playctrl_new_vol-_hl"] forState:UIControlStateHighlighted];
    
    UIButton *mpMaxButton = [UIButton new];
    [mpMaxButton setImage:[UIImage imageNamed:@"playctrl_new_vol+"] forState:UIControlStateNormal];
    [mpMaxButton setImage:[UIImage imageNamed:@"playctrl_new_vol+_hl"] forState:UIControlStateHighlighted];
    
    UIButton *volMinButton = [UIButton new];
    [volMinButton setImage:[UIImage imageNamed:@"playctrl_new_vol-0"] forState:UIControlStateNormal];
    [volMinButton setImage:[UIImage imageNamed:@"playctrl_new_vol-_hl"] forState:UIControlStateHighlighted];
    
    UIButton *volMaxButton = [UIButton new];
    [volMaxButton setImage:[UIImage imageNamed:@"playctrl_new_vol+"] forState:UIControlStateNormal];
    [volMaxButton setImage:[UIImage imageNamed:@"playctrl_new_vol+_hl"] forState:UIControlStateHighlighted];
    
    UILabel *mpLabel = [UILabel new];
    mpLabel.font = [UIFont systemFontOfSize:fontSize];
    mpLabel.textColor = [UIColor whiteColor];
    [mpLabel setText:@"麦克风"];
    
    UILabel *volLabel = [UILabel new];
    volLabel.font = [UIFont systemFontOfSize:fontSize];
    volLabel.textColor = [UIColor whiteColor];
    [volLabel setText:@"音乐"];
    
    [self addSubview:mpMaxButton];
    [self addSubview:mpMinButton];
    [self addSubview:volMinButton];
    [self addSubview:volMaxButton];
    [self addSubview:mpLabel];
    [self addSubview:volLabel];
    
    UIButton *closeButton = [UIButton new];
    [closeButton setTag:999];
    [closeButton setImage:[UIImage imageNamed:@"btn_close_page_hl"] forState:UIControlStateNormal];
    [closeButton setBackgroundColor:RGB(45, 45, 60)];
    [closeButton addTarget:self action:@selector(buttonActoin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(kSCREEN_WIDTH, 60));
        make.bottom.equalTo(self);
    }];
    
    [mpMaxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).with.offset(-40);
        make.top.equalTo(self.mas_centerY).with.offset(20);
        make.size.mas_offset(CGSizeMake(50, 35));
    }];
    
    [mpMinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mpMaxButton.mas_left).with.offset(0);
        make.top.equalTo(mpMaxButton);
        make.size.mas_offset(CGSizeMake(50, 35));
    }];
    
    [volMinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).with.offset(50);
        make.top.equalTo(mpMaxButton);
        make.size.mas_offset(CGSizeMake(50, 35));
    }];
    
    [volMaxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(volMinButton.mas_right).with.offset(0);
        make.top.equalTo(volMinButton);
        make.size.mas_offset(CGSizeMake(50, 35));
    }];
    
    [mpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mpMinButton.mas_right);
        make.top.equalTo(mpMinButton.mas_bottom).with.offset(10);
    }];
    
    [volLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(volMaxButton.mas_left);
        make.top.equalTo(volMaxButton.mas_bottom).with.offset(10);
    }];
    
    //bottom
    NSMutableArray *array = [NSMutableArray new];
    UIButton *lightButton = [UIButton new];
    [lightButton setImage:[UIImage imageNamed:@"btn_light_normal"] forState:UIControlStateNormal];
    [lightButton setImage:[UIImage imageNamed:@"btn_light_hl"] forState:UIControlStateHighlighted];
    
    UIButton *microButton = [UIButton new];
    [microButton setImage:[UIImage imageNamed:@"btn_micro_normal"] forState:UIControlStateNormal];
    [microButton setImage:[UIImage imageNamed:@"btn_micro_hl"] forState:UIControlStateHighlighted];
    
    UIButton *gradeButton = [UIButton new];
    [gradeButton setImage:[UIImage imageNamed:@"switch_grade_n"] forState:UIControlStateNormal];
    [gradeButton setImage:[UIImage imageNamed:@"switch_grade_hl"] forState:UIControlStateHighlighted];
    [gradeButton setImage:[UIImage imageNamed:@"switch_grade_disable"] forState:UIControlStateDisabled];
    
    UIButton *videoButton = [UIButton new];
    [videoButton setImage:[UIImage imageNamed:@"video_ctrl_icon_n"] forState:UIControlStateNormal];
    [videoButton setImage:[UIImage imageNamed:@"video_ctrl_icon_hl"] forState:UIControlStateHighlighted];
    [videoButton setImage:[UIImage imageNamed:@"video_ctrl_icon_disable"] forState:UIControlStateDisabled];
    
    [array addObjectsFromArray:@[lightButton,microButton,gradeButton,videoButton]];
    [self addSubview:lightButton];
    [self addSubview:microButton];
    [self addSubview:gradeButton];
    [self addSubview:videoButton];
    
    CGFloat bottomMargin = -60.0f;
    if (kDevice_Is_iPhone4) {
        bottomMargin = -20.0f;
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:20 tailSpacing:20];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(closeButton.mas_top).with.offset(bottomMargin);
        make.height.equalTo(@60);
    }];
    
    UILabel *lightLabel = [UILabel new];
    lightLabel.font = [UIFont systemFontOfSize:fontSize];
    lightLabel.textColor = [UIColor whiteColor];
    lightLabel.text = @"灯光";
    
    UILabel *microLabel = [UILabel new];
    microLabel.font = [UIFont systemFontOfSize:fontSize];
    microLabel.textColor = [UIColor whiteColor];
    microLabel.text = @"音效";
    
    UILabel *gradeLabel = [UILabel new];
    gradeLabel.font = [UIFont systemFontOfSize:fontSize];
    gradeLabel.textColor = [UIColor whiteColor];
    gradeLabel.text = @"平分开关";
    
    UILabel *videoLabel = [UILabel new];
    videoLabel.font = [UIFont systemFontOfSize:fontSize];
    videoLabel.textColor = [UIColor whiteColor];
    videoLabel.text = @"视屏录像";
    
    [self addSubview:lightLabel];
    [self addSubview:microLabel];
    [self addSubview:gradeLabel];
    [self addSubview:videoLabel];
    
    [lightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lightButton);
        make.top.equalTo(lightButton.mas_bottom).with.offset(8);
    }];
    
    [microLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(microButton);
        make.centerY.equalTo(lightLabel);
    }];
    
    [gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(gradeButton);
        make.centerY.equalTo(lightLabel);
    }];
    
    [videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(videoButton);
        make.centerY.equalTo(lightLabel);
    }];
}

#pragma mark - Action
- (void)buttonActoin:(UIButton *)button{
    [self.delegate RemoteControlButtonAction:button];
}


@end
