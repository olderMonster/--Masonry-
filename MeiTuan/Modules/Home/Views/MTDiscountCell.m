//
//  MTDiscountCell.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTDiscountCell.h"
#import "OMNetworkingConfiguration.h"

#import "MTDiscountCollectionCell.h"

CGFloat kDiscountCellHeight = 60;

@interface MTDiscountCell()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)UICollectionView *discountCollectionView;

@end

@implementation MTDiscountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _discountCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _discountCollectionView.backgroundColor = RGB(235, 235, 241);
        _discountCollectionView.showsHorizontalScrollIndicator = NO;
        _discountCollectionView.showsVerticalScrollIndicator = NO;
        _discountCollectionView.scrollEnabled = NO;
        _discountCollectionView.dataSource = self;
        _discountCollectionView.delegate = self;
        [_discountCollectionView registerClass:[MTDiscountCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:_discountCollectionView];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.discountCollectionView.frame = self.contentView.bounds;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.discountTable.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MTDiscountCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.discount = self.discountTable[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 1) / 2, kDiscountCellHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}


#pragma mark - getters and setters
- (void)setDiscountTable:(NSArray *)discountTable{
    _discountTable = discountTable;
    [self.discountCollectionView reloadData];
}

@end
