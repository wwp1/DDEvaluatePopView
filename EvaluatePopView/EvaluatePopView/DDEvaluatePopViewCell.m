//
//  DDEvaluatePopViewCell.m
//  DingDing
//
//  Created by 王万鹏 on 2017/12/19.
//  Copyright © 2017年 ddtech. All rights reserved.
//

#import "DDEvaluatePopViewCell.h"
#import "UIColor+DDColor.h"

@implementation DDEvaluatePopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _titleLabel.textAlignment = 1;
        _titleLabel.layer.borderColor = [UIColor colorWithHex:@"#E7E7E7"].CGColor;
        _titleLabel.layer.borderWidth = 0.5;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.cornerRadius = 2;
        [self addSubview:_titleLabel];
    }
    return self;
}



- (void)refreshFrame {
    _titleLabel.frame = self.bounds;
    _titleLabel.textColor = [UIColor colorWithHex:@"#999999"];

    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.layer.borderColor = [UIColor colorWithHex:@"#E7E7E7"].CGColor;
}

- (void)setSeclectedBool:(BOOL)seclectedBool {
    if (seclectedBool) {
        UIColor *color = [UIColor colorWithRed:247.0/255 green:230.0/255 blue:230.0/255 alpha:1];
        _titleLabel.textColor = [UIColor colorWithHex:@"#E04D54"];
        _titleLabel.backgroundColor = color;
        _titleLabel.layer.borderColor = color.CGColor;

    }else {
        _titleLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    _seclectedBool = seclectedBool;
}

@end
