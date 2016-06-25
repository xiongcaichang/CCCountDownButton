//
//  ViewController.m
//  CountDownButtonDemo
//
//  Created by bear on 16/6/17.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+countDown.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"test" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor brownColor];
    
    [button setTintColor:[UIColor blackColor]];
    
    button.frame=CGRectMake(50, 50, 200, 30);
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(startCountDown:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)startCountDown:(UIButton *)btn{
    
    btn.countDownFormat=@"%d秒后重试";
    
    [btn countDownWithTimeInterval:10];
}


@end
