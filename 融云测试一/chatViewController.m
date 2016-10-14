//
//  chatViewController.m
//  融云测试一
//
//  Created by 张雨生 on 16/7/29.
//  Copyright © 2016年 meilun. All rights reserved.
//

#import "chatViewController.h"

@interface chatViewController ()

@end

@implementation chatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
//    self.conversationMessageCollectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"129"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"129"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
