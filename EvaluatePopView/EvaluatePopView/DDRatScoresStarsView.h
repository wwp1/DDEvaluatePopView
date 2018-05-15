//
//  DDRatScoresStarsView.h
//  DingDing
//
//  Created by 王万鹏 on 2018/1/11.
//  Copyright © 2018年 ddtech. All rights reserved.
//

#import <UIKit/UIKit.h>
//根据宽度自适应星星居中，并相等间距

typedef NS_ENUM(NSUInteger, DDRatScoresStarsType) {
    DDRatScoresStarsDefault,    //正常显示评分(3.6)
    DDRatScoresStarsNormalRating, //选择整数评分(1-5分)
    DDRatScoresStarsFloatRating,  //选择小数评分(有0分)
    DDRatScoresStarsShow        //显示大星星评分
};

@class DDRatScoresStarsView;

@protocol DDRatScoresStarsViewDelegate <NSObject>


-(void)ratingStartsView:(DDRatScoresStarsView *)ratingView ratingNumber:(CGFloat)ratingNum;

@end

@interface DDRatScoresStarsView : UIView

@property(nonatomic ,assign) CGFloat ratNum;
@property(nonatomic, weak) id <DDRatScoresStarsViewDelegate> delegate;

/**
 评分星星构造方法

 @param frame View大小
 @param starHeight 星星要显示的高度
 @param type 星星的类型
 @return 星星View
 */
- (instancetype)initWithFrame:(CGRect)frame height:(CGFloat)starHeight type:(DDRatScoresStarsType)type;

@end
