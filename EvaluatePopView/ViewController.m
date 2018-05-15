//
//  ViewController.m
//  EvaluatePopView
//
//  Created by 王万鹏 on 2018/5/14.
//  Copyright © 2018年 王万鹏. All rights reserved.
//

#import "ViewController.h"
#import "DDEvaluatePopView.h"

@interface ViewController ()

@property(nonatomic, strong)DDEvaluatePopView *evaluateView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake((self.view.frame.size.width - 200) * 0.5, 100, 200, 50);
    [firstButton setBackgroundColor:[UIColor grayColor]];
    [firstButton setTitle:@"去评价" forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(clickedFirstButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstButton];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake((self.view.frame.size.width - 200) * 0.5, firstButton.frame.size.height + firstButton.frame.origin.y + 100, 200, 50);
    [secondButton setBackgroundColor:[UIColor grayColor]];
    [secondButton setTitle:@"评价完成" forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(clickedSecondButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
}


- (void)clickedFirstButton:(UIButton *)btn {
    
    NSArray *titleArr = @[@[@"严重迟到",@"环境脏乱",@"车号不符",@"态度恶劣",@"多绕路",@"性骚扰",@"车内抽烟",@"酒驾",@"私下收费"],
                          @[@"车主迟到",@"话多唠叨",@"态度不好",@"让半路下车",@"私下收费",@"无wifi",@"无空调",@"带宠物",@"车技很烂"],
                          @[@"严重迟到",@"环境脏乱",@"车号不符",@"态度恶劣",@"多绕路",@"性骚扰",@"车内抽烟",@"酒驾",@"私下收费"],
                          @[@"车主迟到",@"话多唠叨",@"态度不好",@"让半路下车",@"私下收费",@"无wifi",@"无空调",@"带宠物",@"车技很烂"],
                          @[@"严重迟到",@"环境脏乱",@"车号不符",@"态度恶劣",@"多绕路",@"性骚扰",@"车内抽烟",@"酒驾",@"私下收费"]];

    [self.view addSubview:self.evaluateView];
    
    //设置默认评价分数
    [self.evaluateView refreshViewWithNumber:4 titleArr:titleArr];
    
    CGRect rect = _evaluateView.frame;
    
    NSUInteger kIPhoneXBottomHeight = [[UIScreen mainScreen] bounds].size.height == 812.0 ? 34 :0;
    
    rect.origin.y = self.view.frame.size.height - ([UIScreen mainScreen].bounds.size.width/375 * 64 + 120) - kIPhoneXBottomHeight;
    [UIView animateWithDuration:.5 animations:^{
        self.evaluateView.frame = rect;
    }];
    
}

- (void)clickedSecondButton:(UIButton *)btn {
    NSLog(@"评价完成的评分：%ld \n评价内容：%@",_evaluateView.evaluateNumber,_evaluateView.evaluateTextStr);
    [_evaluateView removeFromSuperview];
    _evaluateView = nil;
    
}
- (DDEvaluatePopView *)evaluateView {
    if (!_evaluateView) {
        _evaluateView = [[DDEvaluatePopView alloc]initWithFrame:CGRectMake(16 * self.view.frame.size.width/375, self.view.frame.size.height, self.view.frame.size.width - 32 * self.view.frame.size.width/375, 64 * self.view.frame.size.width/375 + 120)];
        _evaluateView.backgroundColor = [UIColor whiteColor];
        
    }
    return _evaluateView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
