//
//  MFTopAdvanceView.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/6.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFTopAdvanceView.h"
#import "UIImageView+WebCache.h"
@interface MFTopAdvanceView ()<UIScrollViewDelegate>

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 分页控制器 */
@property (nonatomic, strong) UIPageControl *pageControl;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MFTopAdvanceView
{
    /** 图片数组 */
    NSArray *_imageArray;
}
/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/** 设置 */
- (void)setup{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

/** 布局 */
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i*SCREEN_W);
            make.size.mas_equalTo(CGSizeMake(SCREEN_W,self.height));
            
        }];
    }
    
    self.scrollView.contentOffset = CGPointZero;
}

#pragma mark - lazy load

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{

    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}


#pragma mark - setter

- (void)setPageControlCurrentColor:(UIColor *)currentColor
                        otherColor:(UIColor *)otherColor
                  placeholderImage:(UIImage *)placeholderImage
                        imageArray:(NSArray *)imageArray{
    
    _imageArray = imageArray;
    /** 设置颜色 */
    self.pageControl.currentPageIndicatorTintColor = currentColor;
    self.pageControl.pageIndicatorTintColor = otherColor;
    
    /** 移除之前的所有imageView */
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    /** 根据图片名创建对应个数的imageView */
    for (int i = 0; i<imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:placeholderImage];
        [self.scrollView addSubview:imageView];
        
        /** 事件回调 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap handleRecognizerBlock:^(UIGestureRecognizer* sender) {
            CGPoint touchPoint = [sender locationInView:_scrollView];
            NSInteger index    = touchPoint.x / SCREEN_W;
            !_MFTopAdvanceImageViewClickedBlock ? : _MFTopAdvanceImageViewClickedBlock(index);
        }];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_W * imageArray.count, self.height);
    
    /** 设置总页数 */
    self.pageControl.numberOfPages = imageArray.count;
    [self startTimer];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

#pragma mark - 定时器控制

/** 开启定时器 */
- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                  target:self
                                                selector:@selector(nextPage)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer
                              forMode:NSRunLoopCommonModes];
}
/** 停止定时器 */
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

/** 下一页 */
- (void)nextPage{
    
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x       = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

@end
