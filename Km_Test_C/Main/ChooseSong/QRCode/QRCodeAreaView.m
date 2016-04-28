//
//  QRCodeAreaView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "QRCodeAreaView.h"
@interface QRCodeAreaView()
@property (nonatomic,assign) CGPoint position;
@property (nonatomic,strong)NSTimer  *timer;

@end

@implementation QRCodeAreaView

- (void)drawRect:(CGRect)rect {
    CGPoint newPosition = self.position;
    newPosition.y += 1;
    
    //判断y到达底部，从新开始下降
    if (newPosition.y > rect.size.height) {
        newPosition.y = 0;
    }
    
    //重新赋值position
    self.position = newPosition;
    
    // 绘制图片
    UIImage *image = [UIImage imageNamed:@"line"];
    
    [image drawAtPoint:self.position];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *areaView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"frame_icon"]];
        [areaView setFrame:self.bounds];
        [self addSubview:areaView];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    }
    
    return self;
}

-(void)startAnimaion{
    [self.timer setFireDate:[NSDate date]];
}

-(void)stopAnimaion{
    [self.timer setFireDate:[NSDate distantFuture]];
}


@end
