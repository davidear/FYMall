//
//  FYAdvertiseScrollView.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/5.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYAdvertiseView.h"
#define kWidth                      [UIScreen mainScreen].bounds.size.width
#define kHeight                     155
#define kAutoScorllInterval         5
@implementation FYAdvertiseView
{
    NSInteger _imageIndex;
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    NSTimer *_timer;
}
#pragma mark - 1.2.1、创建广告栏

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _pageControl.center = CGPointMake(kWidth / 2, kHeight - 20);
}

- (void)setupSubviews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    由于使用xib和autolayout，因此尺寸只能在显示的时候才知道，无法正确设置pageControl的位置，放到layoutSubviews里面
//    pageControl.center = CGPointMake(kWidth / 2 - 50 , kHeight - 20);
    pageControl.hidesForSinglePage = YES;
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    _pageControl = pageControl;

}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    [self creatAD];
}
- (void)creatAD
{
    // 广告栏
    _scrollView.contentSize = CGSizeMake(kWidth * 3, 0);
    _scrollView.contentOffset = CGPointMake(kWidth, 0);
    
    for (int i = 0; i < 3; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArray[(i + _imageArray.count - 1)% _imageArray.count]]];
        imageView.tag = i + 1;
        imageView.userInteractionEnabled = YES;
        imageView.frame = (CGRect){kWidth * i, 0, kWidth, kHeight};
        [_scrollView addSubview:imageView];
    }
    _imageIndex = 0;
    
    _pageControl.numberOfPages = _imageArray.count;
}
#pragma mark 1.2.1.1、广告栏自动滑动
- (void)setAutoSlide:(BOOL)autoSlide
{
    _autoSlide = autoSlide;
    if (_autoSlide) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kAutoScorllInterval target:self selector:@selector(adAutoSliding) userInfo:nil repeats:YES];
    }
}

- (void)adAutoSliding
{
    [_scrollView setContentOffset:CGPointMake(kWidth * 2.0, 0) animated:YES];
}

#pragma mark - PageControl
- (void)pageChanged:(UIPageControl *)sender {
    NSLog(@"分页了 %ld", (long)sender.currentPage);
    NSInteger delta = sender.currentPage - _imageIndex;
    [_scrollView setContentOffset:CGPointMake(kWidth + kWidth * delta, 0) animated:YES];
}
#pragma mark - ScrollView Delegate
#pragma mark 滚动视图减速事件
//手势
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self switchImage];
}
//代码
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self switchImage];
}

- (void)switchImage
{
    UIImageView *image0 = (UIImageView *)[_scrollView viewWithTag:1];
    UIImageView *image1 = (UIImageView *)[_scrollView viewWithTag:2];
    UIImageView *image2 = (UIImageView *)[_scrollView viewWithTag:3];
    NSUInteger count = _imageArray.count;
    // 更换图片
    if (_scrollView.contentOffset.x > kWidth * 1.5) {                   // 往后滑动，后推一张图片
        _imageIndex = ++_imageIndex % count;
    } else if (_scrollView.contentOffset.x < kWidth * 0.5){             // 往前滑动，前推一张图片
        _imageIndex = (_imageIndex + count - 1) % count;
    } else return;
    
    _pageControl.currentPage = _imageIndex;
    
    image0.image = [UIImage imageNamed:_imageArray[(_imageIndex + count - 1)% count]];
    image1.image = [UIImage imageNamed:_imageArray[(_imageIndex ) % count]];
    image2.image = [UIImage imageNamed:_imageArray[(_imageIndex + 1) % count]];
    _scrollView.contentOffset = CGPointMake(kWidth, 0);
}

-(void)dealloc
{
    [_timer invalidate];
}
@end
