//
//  MTDropdownListView.m
//  MeiTuan
//
//  Created by kehwa on 16/7/20.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTDropdownListView.h"

static NSString *kLeftTableViewCellIdentifier = @"kLeftTableViewCellIdentifier";
static NSString *kRightTableViewCellIdentifier = @"kRightTableViewCellIdentifier";

@interface MTDropdownListView()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)UIView *maskView;
@property (nonatomic , strong)UIView *contentView;

@property (nonatomic , strong)UITableView *leftTableView;
@property (nonatomic , strong)UITableView *rightTableView;

@property (nonatomic , strong)UITableView *onlyTableView;

@property (nonatomic , strong)UIButton *categoryButton;
@property (nonatomic , strong)UIButton *zoneButton;
@property (nonatomic , strong)UIButton *sortButton;
@property (nonatomic , strong)UIButton *lastSelectedButton;

@property (nonatomic , assign)NSInteger index;

@end

@implementation MTDropdownListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootController.view addSubview:self.maskView];
        [rootController.view addSubview:self.contentView];
        
        _categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryButton setTitle:@"全部分类" forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _categoryButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_categoryButton addTarget:self action:@selector(showOrHidden:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_categoryButton];
        
        
        _zoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zoneButton setTitle:@"全程" forState:UIControlStateNormal];
        [_zoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_zoneButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _zoneButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_zoneButton addTarget:self action:@selector(showOrHidden:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_zoneButton];
        
        _sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sortButton setTitle:@"智能排序" forState:UIControlStateNormal];
        [_sortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sortButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _sortButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_sortButton addTarget:self action:@selector(showOrHidden:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sortButton];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat btnW = self.bounds.size.width / 3;
    
    self.categoryButton.frame = CGRectMake(0, 0, btnW, self.bounds.size.height);
    self.zoneButton.frame = CGRectMake(CGRectGetMaxX(self.categoryButton.frame), 0, btnW, self.bounds.size.height);
    self.sortButton.frame = CGRectMake(CGRectGetMaxX(self.zoneButton.frame), 0, btnW, self.bounds.size.height);
    
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    CGRect rect = [self convertRect:self.frame toView:rootController.view];
    self.maskView.frame = CGRectMake(0, CGRectGetMaxY(rect) - 64, rootController.view.bounds.size.width, rootController.view.bounds.size.height - (CGRectGetMaxY(rect) - 64));
    self.contentView.frame = CGRectMake(rect.origin.x, CGRectGetMaxY(rect) - 64,rect.size.width, rect.size.height * 10);
    self.leftTableView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width * 0.3, self.contentView.bounds.size.height);
    self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 0, self.bounds.size.width - self.leftTableView.bounds.size.width, self.contentView.bounds.size.height);

    
    if ([self.leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.leftTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.leftTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.leftTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    if ([self.rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.rightTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.rightTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - public method
- (void)addItems:(NSArray *)items listType:(MTDropdownListViewType)listType rightTableViewType:(MTDropdownListViewRightTableViewType)rightType  defaultItemTitle:(NSString *)title{
    
}

- (void)closeDropList{
    self.contentView.hidden = YES;
    self.maskView.hidden = YES;
}


#pragma mark - event response
- (void)showOrHidden:(UIButton *)clickedButton{
    
    if (self.lastSelectedButton == clickedButton) {
        clickedButton.selected = !clickedButton.selected;
    }else{
        self.lastSelectedButton.selected = NO;
        clickedButton.selected = YES;
        self.lastSelectedButton = clickedButton;
    }
    
    if (clickedButton.selected) {
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        self.maskView.hidden = NO;
        self.contentView.hidden = NO;
    }else{
        self.maskView.hidden = YES;
        self.contentView.hidden = YES;
    }
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.categoryButton.selected) {
        if (tableView == self.leftTableView) {
            return self.categoryTable.count;
        }
        NSArray *listTable = self.categoryTable[self.index][@"list"];
        if (listTable) {
            return listTable.count;
        }
    }else if (self.zoneButton.selected){
        if (tableView == self.leftTableView) {
            return self.zoneTable.count;
        }
        NSArray *listTable = self.zoneTable[self.index][@"list"];
        if (listTable) {
            return listTable.count;
        }
    }else if (self.sortButton.selected){
        if (tableView == self.leftTableView) {
            return self.sortTable.count;
        }
        NSArray *listTable = self.sortTable[self.index][@"list"];
        if (listTable) {
            return listTable.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftTableViewCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLeftTableViewCellIdentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

        }
        
        NSArray *currentArray = self.categoryButton.selected?self.categoryTable:(self.zoneButton.selected?self.zoneTable:self.sortTable);
        cell.textLabel.text = currentArray[indexPath.row][@"name"];
        return cell;
        
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRightTableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRightTableViewCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:243/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    NSArray *currentArray = self.categoryButton.selected?self.categoryTable:(self.zoneButton.selected?self.zoneTable:self.sortTable);
    cell.textLabel.text = currentArray[self.index][@"list"][indexPath.row][@"name"];
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *currentArray = self.categoryButton.selected?self.categoryTable:(self.zoneButton.selected?self.zoneTable:self.sortTable);
    UIButton *currentButton = self.categoryButton?self.categoryButton:(self.zoneButton.selected?self.zoneButton:self.sortButton);
    
    if (tableView == self.leftTableView) {
        self.index = indexPath.row;
        
        NSArray *list = currentArray[self.index][@"list"];
        if (list) {
            [self.rightTableView reloadData];
        }else{
            [currentButton setTitle:currentArray[self.index][@"name"] forState:UIControlStateNormal];
            [self showOrHidden:currentButton];
        }
        
    }
    
    if (tableView == self.rightTableView) {
        
        [currentButton setTitle:currentArray[self.index][@"list"][indexPath.row][@"name"] forState:UIControlStateNormal];
        [self showOrHidden:currentButton];
        
    }

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark - getters and setters
- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.hidden = YES;
        
        [_contentView addSubview:self.leftTableView];
        [_contentView addSubview:self.rightTableView];
    }
    return _contentView;
}


- (UIView *)maskView{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]init];
        _maskView.hidden = YES;
        _maskView.backgroundColor = [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:0.5];
    }
    return _maskView;
}

- (UITableView *)leftTableView{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.tableFooterView = [[UIView alloc]init];
        _leftTableView.showsVerticalScrollIndicator = NO;
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.tableFooterView = [[UIView alloc]init];
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.rowHeight = 40;
    }
    return _rightTableView;
}

@end
