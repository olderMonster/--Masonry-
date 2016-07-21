//
//  MTChannelCell.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTChannelCell.h"
#import "MTChannelCollectionCell.h"
#import "OMNetworkingConfiguration.h"
CGFloat kChannelCellHeight = 70;
@interface MTChannelCell()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)UICollectionView *channelCollectionView;
@property (nonatomic , strong)UIPageControl *channelPageControl;

@end

@implementation MTChannelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _channelCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _channelCollectionView.backgroundColor = [UIColor whiteColor];
        _channelCollectionView.pagingEnabled = YES;
        _channelCollectionView.showsHorizontalScrollIndicator = NO;
        _channelCollectionView.showsVerticalScrollIndicator = NO;
        _channelCollectionView.dataSource = self;
        _channelCollectionView.delegate = self;
        [_channelCollectionView registerClass:[MTChannelCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:_channelCollectionView];
        
        _channelPageControl = [[UIPageControl alloc]init];
        _channelPageControl.pageIndicatorTintColor = RGB(219, 219, 219);
        _channelPageControl.currentPageIndicatorTintColor = RGB(96, 182, 175);
        [_channelPageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_channelPageControl];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.channelCollectionView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, kChannelCellHeight *2);
    self.channelPageControl.frame = CGRectMake(0, CGRectGetMaxY(self.channelCollectionView.frame), self.contentView.bounds.size.width, 20);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.channelCollectionView) {
        NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
        self.channelPageControl.currentPage = page;
    }
}

#pragma mark - private method
- (void)pageTurn:(UIPageControl *)pageControl{
    [self.channelCollectionView scrollRectToVisible:CGRectMake(self.channelCollectionView.bounds.size.width * pageControl.currentPage, self.channelCollectionView.frame.origin.y, self.channelCollectionView.bounds.size.width, self.channelCollectionView.bounds.size.height) animated:YES];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelTable.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MTChannelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.channel = self.channelTable[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 5, kChannelCellHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - getters and setters
- (void)setChannelTable:(NSArray *)channelTable{
    _channelTable = channelTable;
    [self.channelCollectionView reloadData];
    
    self.channelPageControl.numberOfPages = (channelTable.count + 9) / 10;
}

@end
