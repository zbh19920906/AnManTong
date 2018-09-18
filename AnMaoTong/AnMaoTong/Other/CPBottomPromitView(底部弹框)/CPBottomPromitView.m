//
//  CPBottomPromitView.m
//  BottomPromitView
//
//  Created by lk06 on 17/2/15.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "CPBottomPromitView.h"

@interface CPBottomPromitView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) CPBottomPromitManager        *cancleManager;
@property (nonatomic , strong) UIView                       *backView;
@property (nonatomic , strong) UITapGestureRecognizer       *tapGestureRecognizerBackView;
@property (nonatomic , strong) UITableView                  *tableView;
@property (nonatomic , strong) NSMutableArray<CPBottomPromitManager *> *managers;
@property (nonatomic , strong) CPBottomPromitHeadView       *headView;
@property (nonatomic , strong) UILabel                      *alertLab;
@end

@implementation CPBottomPromitView

#pragma mark - set
- (void)setAlertStr:(NSString *)alertStr
{
    self.alertLab.text = alertStr;
}

- (void)setIsUnShowAlertLab:(BOOL)isUnShowAlertLab
{
    self.alertLab.hidden = isUnShowAlertLab;
}

#pragma mark - Life
+ (__kindof CPBottomPromitView *)bottomPromitViewWithStyle:(CPBlurEffectStyle)style
                                                   option:(CPBottomPromitOption *)option
{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, CPBP_ScreenSize.width, CPBP_ScreenSize.height) style:style option:option];
}

- (instancetype)initWithFrame:(CGRect)frame
                        style:(CPBlurEffectStyle)style
                       option:(CPBottomPromitOption *)option
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _style = style;
        _option = option;
        
        self.cancleManager = [CPBottomPromitManager managerWithCancleWithOption:_option];
        
        [self addSubview:self.backView];
        [self addSubview:self.tableView];
        [self addSubview:self.alertLab];
        
        self.alertLab.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(20)
        .bottomSpaceToView(self.tableView, 0);
        
    }
    return self;
}

#pragma mark - Method
-(void)addTitle:(NSString *)title
         detail:(NSString *)detail
     titleColor:(UIColor *)titleColor
    detailColor:(UIColor *)detailColor
{
    CPBottomPromitManager *manager = [CPBottomPromitManager managerWithTitle:title detail:detail titleColor:titleColor detailColor:detailColor option:_option];
    [self.managers addObject:manager];
}

-(void)addHeadViewHeadTitle:(NSString *)title
{

    __weak typeof(self) weakself = self;
    [self.headView addHeadViewTitle:title option:_option complete:^{
        weakself.tableView.tableHeaderView = weakself.headView;
    }];
}

-(void)cpChangeTableViewFrameAddHeight:(CGFloat)addHeight
{
    CGRect rect_tableView = self.tableView.frame;
    CGFloat height = self.cancleManager.height + CPBP_Spacing + addHeight;
    for (CPBottomPromitManager *manager in self.managers) {
        height += manager.height;
    }
    self.tableView.scrollEnabled = NO;
    if (height > _option.max_height) {
        _tableView.scrollEnabled = YES;
        height = _option.max_height;
    }
    rect_tableView.size.height = height;
    self.tableView.frame = rect_tableView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? self.managers.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPBottomPromitCell *cell = [tableView dequeueReusableCellWithIdentifier:[CPBottomPromitCell identifier]];
    if (indexPath.section == 0) {
         [cell setManager:self.managers[indexPath.row]];
    }else{
         [cell setManager:self.cancleManager];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return self.cancleManager.height;
    }else{
        return self.managers[indexPath.row].height;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? CPBP_Spacing : .01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *spcingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CPBP_ScreenSize.width, CPBP_Spacing)];
        spcingView.backgroundColor = _option.separatorViewColor;
        return spcingView;
    }
    else
    {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPBottomPromitCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.05];
}
-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPBottomPromitCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.cpDelegate && [self.cpDelegate respondsToSelector:@selector(bottomPromitView:didSelectRowAtIndexPath:)])
        {
            [self.cpDelegate bottomPromitView:self didSelectRowAtIndexPath:indexPath];
        }
    }
    else if (indexPath.section == 1)
    {
        if (self.cpDelegate && [self.cpDelegate respondsToSelector:@selector(bottomPromitViewForCancle:)])
        {
            [self.cpDelegate bottomPromitViewForCancle:self];
        }
    }
    [self dismissBottomPromit];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:_option.separatorInset];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:_option.separatorInset];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}


#pragma mark - CPBottomPromitCellDelegate
-(void)cpBottomPromitCellReloadIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



-(void)tapBackViewAction:(UITapGestureRecognizer *)tap
{
    [self dismissBottomPromit];
    if (self.cpDelegate && [self.cpDelegate respondsToSelector:@selector(bottomPromitViewForCancle:)])
    {
        [self.cpDelegate bottomPromitViewForCancle:self];
    }
}

-(void)showBottomPromit
{
    [self.alertLab updateLayout];
    [self cpChangeTableViewFrameAddHeight:CGRectGetHeight(_headView.frame)];
    [CPBP_GetWindow  addSubview:self];
    CGRect rect_tableView = self.tableView.frame;
    rect_tableView.origin.y = CPBP_ScreenSize.height - rect_tableView.size.height;
    __weak typeof(self) weakself = self;
    CGRect rect_backView = self.backView.frame;
    rect_backView.size.height = CPBP_ScreenSize.height - rect_tableView.size.height;
    self.alertLab.alpha = 0;
    [UIView animateWithDuration:CPBP_AnimationDuration animations:^{
        weakself.alertLab.alpha = 1;
        weakself.backView.alpha = 0.3;
        weakself.backView.frame = rect_backView;
        weakself.tableView.frame = rect_tableView;
        [weakself.alertLab updateLayout];
    }];
}

-(void)dismissBottomPromit
{
    __weak typeof(self) weakself = self;
    CGRect rect_tableView = self.tableView.frame;
    rect_tableView.origin.y = CPBP_ScreenSize.height;
    CGRect rect_backView = self.backView.frame;
    rect_backView.size.height = CPBP_ScreenSize.height;
    
    [UIView animateWithDuration:CPBP_AnimationDuration animations:^{
        weakself.backView.frame = rect_backView;
        weakself.backView.alpha = 0;
        weakself.alertLab.alpha = 0;
        weakself.tableView.frame = rect_tableView;
        [weakself.alertLab updateLayout];
    } completion:^(BOOL finished) {
        [weakself removeFromSuperview];
    }];
}

#pragma mark - get
-(UIView *)backView
{
    if (_backView == nil)
    {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.alpha = 0;
        _backView.backgroundColor = [UIColor blackColor];
        [_backView addGestureRecognizer:self.tapGestureRecognizerBackView];
    }
    return _backView;
}

-(UITapGestureRecognizer *)tapGestureRecognizerBackView
{
    if (_tapGestureRecognizerBackView == nil)
    {
        _tapGestureRecognizerBackView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackViewAction:)];
    }
    return _tapGestureRecognizerBackView;
}

-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CPBP_ScreenSize.height, CPBP_ScreenSize.width, 0) style:UITableViewStyleGrouped];
        [_tableView registerClass:[CPBottomPromitCell class] forCellReuseIdentifier:[CPBottomPromitCell identifier]];
        [_tableView setSeparatorColor:_option.separatorColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.layer.anchorPoint = CGPointMake(.5, 1);
        _tableView.backgroundColor = [UIColor clearColor];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_tableView setSeparatorInset:_option.separatorInset];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_tableView setLayoutMargins:_option.separatorInset];
        }
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyle)_style];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
        effe.frame = CGRectMake(0, 0, CPBP_ScreenSize.width, CPBP_ScreenSize.height);
        _tableView.backgroundView = effe;
    }
    return _tableView;
}


-(NSMutableArray<CPBottomPromitManager *> *)managers
{
    if (_managers == nil)
    {
        _managers = [NSMutableArray array];
    }
    return _managers;
}

-(CPBottomPromitHeadView *)headView
{
    if (_headView == nil)
    {
        _headView = [CPBottomPromitHeadView bottomPromitHeadViewWithOption:_option];
    }
    return _headView;
}

-(UILabel *)alertLab
{
    if (_alertLab == nil)
    {
        _alertLab = [UILabel new];
//        _alertLab.text = @"请上传真人头像，否则将无法通过审核";
//        _alertLab.textColor = BHColor(@"CE4E4E");
//        _alertLab.font = BHFont(12);
//        _alertLab.textAlignment = NSTextAlignmentCenter;
//        _alertLab.backgroundColor = BHColor(@"FEDBDB");
    }
    return _alertLab;;
}

@end
