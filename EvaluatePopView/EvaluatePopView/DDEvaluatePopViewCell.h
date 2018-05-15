//
//  DDEvaluatePopViewCell.h
//  DingDing
//
//  Created by 王万鹏 on 2017/12/19.
//  Copyright © 2017年 ddtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDEvaluatePopViewCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *titleLabel;   //标签
@property(nonatomic, assign) BOOL seclectedBool;    //是否选中

//刷新页面布局
- (void)refreshFrame;

@end
