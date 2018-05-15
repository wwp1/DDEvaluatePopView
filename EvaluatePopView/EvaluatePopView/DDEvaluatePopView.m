//
//  DDEvaluatePopView.m
//  DingDing
//
//  Created by 王万鹏 on 2017/12/18.
//  Copyright © 2017年 ddtech. All rights reserved.
//

#import "DDEvaluatePopView.h"
#import "DDEvaluatePopViewCell.h"
#import "UIColor+DDColor.h"

static NSString *cellReuseIdentifier = @"DDEvaluatePopViewCell";
static CGFloat CollectionViewItem_Height = 30;

@implementation DDEvaluatePopView

{
    DDRatScoresStarsView *_ratingView;  //星星View
    UICollectionView *_collectionView;  //评价标签collectionView
    
    NSMutableArray *_dataSourceArr;   //CollectionView数据源数组
    NSInteger _itemWidth;    //CollectionView 标签宽度
    CGFloat _spaceBetweenCell;  //cell之间的间距
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _dataSourceArr = [NSMutableArray new];
        _evaluateTitleArr = [NSMutableArray new];
        _itemWidth = 10;
        _spaceBetweenCell = 10;
        
        [self creatViews];
    }
    return self;
}

- (void)creatViews {
    
    _ratingView = [[DDRatScoresStarsView alloc]initWithFrame:CGRectMake(60 * [UIScreen mainScreen].bounds.size.width/375, 0, self.frame.size.width - 120 * [UIScreen mainScreen].bounds.size.width/375, 36 * [UIScreen mainScreen].bounds.size.width/375) height:25 type:DDRatScoresStarsNormalRating];
    _ratingView.delegate = self;
    [self addSubview:_ratingView];
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    //item预设大小
    layOut.itemSize = CGSizeMake(8, 8);
    //水平间距
    layOut.minimumInteritemSpacing = 2 ;
    //行间距
    layOut.minimumLineSpacing = 2 ;
    
    _collectionView = [[UICollectionView  alloc]initWithFrame:CGRectMake(12, 50 * [UIScreen mainScreen].bounds.size.width/375, self.frame.size.width - 24, 120) collectionViewLayout:layOut];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.scrollEnabled = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[DDEvaluatePopViewCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
    [self addSubview:_collectionView];
}
#pragma mark - public
- (void)refreshViewWithNumber:(NSInteger)evaluateNumber titleArr:(NSArray *)titleArr {
    [self.evaluateTitleArr removeAllObjects];
    [self.evaluateTitleArr addObjectsFromArray:titleArr];
    self.evaluateNumber = evaluateNumber;
    _ratingView.ratNum = evaluateNumber;
    
}

#pragma mark - RatingViewDelegate

- (void)ratingStartsView:(DDRatScoresStarsView *)ratingView ratingNumber:(CGFloat)ratingNum {
    //记录点击的评分
    self.evaluateNumber = (NSInteger)ratingNum;
}

#pragma mark -UICollectionViewDataSource / UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_dataSourceArr.count > 0) {
        return _dataSourceArr.count / 3;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_dataSourceArr.count > 0) {
        return 3;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDEvaluatePopViewCell *cell = (DDEvaluatePopViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    [cell.titleLabel setText:_dataSourceArr[indexPath.row + indexPath.section * 3]];
    [cell refreshFrame];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.userInteractionEnabled = NO;
    DDEvaluatePopViewCell *cell = (DDEvaluatePopViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *textStr = [NSString stringWithFormat:@"%@;",_dataSourceArr[indexPath.row + indexPath.section * 3]];
    if (cell.seclectedBool) {
        cell.seclectedBool = NO;
        NSRange range = [self.evaluateTextStr rangeOfString:textStr];
        if (range.length > 0) [self.evaluateTextStr deleteCharactersInRange:range];
    }else{
        cell.seclectedBool = YES;
        [self.evaluateTextStr appendString:textStr];
    }
    collectionView.userInteractionEnabled = YES;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_itemWidth, CollectionViewItem_Height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, _spaceBetweenCell, 11, _spaceBetweenCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return _spaceBetweenCell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return _spaceBetweenCell;
}

#pragma mark - pravite
//计算CollectionCell 的width 和 间距
-(void)calculateCollectionFrame {
    if (_dataSourceArr.count > 0) {
        
        NSInteger maxNum = 0;
        CGSize textSize;
        for (NSInteger i = 0; i < _dataSourceArr.count; i++) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = NSStringDrawingUsesLineFragmentOrigin;
            NSDictionary * tdic = @{NSFontAttributeName: [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraphStyle.copy};
            NSString *str = _dataSourceArr[i];
            if(str.length > 0){
                textSize = [str boundingRectWithSize:CGSizeMake(300, 20)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:tdic
                                             context:nil].size;
            }
            
            CGFloat num1 = textSize.width;
            maxNum = num1 > maxNum ? num1 : maxNum;
        }
        _itemWidth = maxNum + 10;
        _spaceBetweenCell = (_collectionView.frame.size.width -  _itemWidth * 3) / 6.0;
    }
}

#pragma mark - set/get lazyload

- (NSMutableString *)evaluateTextStr {
    if (!_evaluateTextStr) {
        _evaluateTextStr = [[NSMutableString alloc]init];
    }
    return _evaluateTextStr;
}

- (void)setEvaluateNumber:(NSInteger)evaluateNumber {
    _evaluateNumber = evaluateNumber;
    //改变collectionView标签
    _ratingView.userInteractionEnabled = NO;
    [self.evaluateTextStr setString:@""];
    
    if (self.evaluateNumber == 0) self.evaluateNumber = 1;
    NSInteger count = self.evaluateNumber - 1;
    //赋值CollectionView数据源dataSource 并刷新
    if (_evaluateTitleArr.count >= _evaluateNumber) {
        [_dataSourceArr removeAllObjects];
        [_dataSourceArr addObjectsFromArray:_evaluateTitleArr[count]];
        [self calculateCollectionFrame];
        [_collectionView reloadData];
        
    }
    _ratingView.userInteractionEnabled = YES;
}

@end
