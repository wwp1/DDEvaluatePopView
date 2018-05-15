//
//  DDEvaluatePopView.h
//  DingDing
//
//  Created by 王万鹏 on 2017/12/18.
//  Copyright © 2017年 ddtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDRatScoresStarsView.h"

@interface DDEvaluatePopView : UIView <UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , DDRatScoresStarsViewDelegate>

@property(nonatomic, strong) NSMutableString *evaluateTextStr;  //评价内容
@property(nonatomic, assign) NSInteger evaluateNumber;  //选择的的评分
@property(nonatomic, strong) NSMutableArray *evaluateTitleArr;   //CollectionView数据源数组


/**
 设置默认评分

 @param evaluateNumber 默认评分
 @param titleArr 评价内容数组（5组，每组9个字符串）
 */
- (void)refreshViewWithNumber:(NSInteger)evaluateNumber titleArr:(NSArray *)titleArr;

@end
