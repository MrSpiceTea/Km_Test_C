//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "ChooseSongCell.h"

@interface ArtistDetailViewController ()

@end
static const CGFloat kBackgroundHeight = 180;
@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"张学友"; 
//    self.backgroundHeight = kBackgroundHeight;
    self.backgroundImage = [UIImage imageNamed:@"zhangxueyou"];
//    [self setBackgroundDefaultImage:[UIImage imageNamed:@"AlbumDefault _Thumbnail"]];
    [self setBackgroundDefaultImageBGColor:[UIColor blueColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITablewViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ChooseSongCell alloc]initWithTitle:@"" detail:@"" reuseIdentifier:cellIdentifier];
        cell.titleLabel.text = @"每天爱你多一些";
        cell.detailLabel.text = @"张学友";
    }
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
