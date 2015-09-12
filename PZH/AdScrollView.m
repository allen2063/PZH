
//
//  AdScrollView.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdScrollView.h"

#define UISCREENWIDTHS  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHTS  self.bounds.size.height//广告的高度

#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标

static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1

@interface AdScrollView ()

{
    //广告的label
    UILabel * _adLabel;
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语(可选)
    UILabel * _leftAdLabel;
    UILabel * _centerAdLabel;
    UILabel * _rightAdLabel;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation AdScrollView

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.mainPagePicBufferDic = [[NSMutableDictionary alloc]init];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTHS, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTHS * 3, UISCREENHEIGHTS);
        self.delegate = self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MainPagePicResult:) name:@"LoadMainPagePicResult" object:nil];
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTHS, UISCREENHEIGHTS)];
        [self addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTHS, 0, UISCREENWIDTHS, UISCREENHEIGHTS)];
        [self addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTHS*2, 0, UISCREENWIDTHS, UISCREENHEIGHTS)];
        [self addSubview:_rightImageView];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
    }
    return self;
}

- (void)MainPagePicResult:(NSNotification *)note{
    
    NSString * imgUrl =  [[note userInfo] objectForKey:@"info"];
    NSMutableArray * imgUrlArray = (NSMutableArray *)[imgUrl componentsSeparatedByString:@";"];
    [imgUrlArray removeLastObject];
    
    [NSThread detachNewThreadSelector:@selector(loadImg:) toTarget:self withObject:imgUrlArray];
}

- (void)loadImg:(NSMutableArray *)imgUrlArray{
    
    NSData * leftimageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[imgUrlArray objectAtIndex:0]]];
    UIImage* leftImage = [[UIImage alloc] initWithData:leftimageData];
    NSData * centerimageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[imgUrlArray objectAtIndex:1]]];
    UIImage* centerImage = [[UIImage alloc] initWithData:centerimageData];
    NSData * rightimageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[imgUrlArray objectAtIndex:2]]];
    UIImage* rightImage = [[UIImage alloc] initWithData:rightimageData];
    
    //初始化更新缓存
    if ([self.mainPagePicBufferDic isKindOfClass:[NSMutableDictionary class]]&&(self.mainPagePicBufferDic.count == 0)) {
        _leftImageView.image =leftImage;
        _centerImageView.image =centerImage;
        _rightImageView.image =rightImage;
        NSDate * loadTime = [NSDate date];
        [self.mainPagePicBufferDic setObject:leftImage forKey:@"leftImage"];
        [self.mainPagePicBufferDic setObject:centerImage forKey:@"centerImage"];
        [self.mainPagePicBufferDic setObject:rightImage forKey:@"rightImage"];
        [self.mainPagePicBufferDic setObject:loadTime forKey:@"loadTime"];
        //写入对应位置
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documents stringByAppendingPathComponent:@"mainPagePicBufferDic.archiver"];//拓展名可以自己随便取
        
        BOOL writeResult =[NSKeyedArchiver archiveRootObject:self.mainPagePicBufferDic toFile:path];
        NSLog(@"%@",writeResult ? @"写入主页图片成功":@"写入主页图片失败");
    }
    
    NSDate * lastUpdateTime = [self.mainPagePicBufferDic objectForKey:@"loadTime"];
    NSTimeInterval timeOut = -60*60*24;
    if ((lastUpdateTime.timeIntervalSinceNow < timeOut) && (leftImage != NULL)&&(rightImage != NULL)&&(centerImage != NULL)  ) {       //超时更新缓存   无网时三个image会为空  需要判断
        _leftImageView.image =leftImage;
        _centerImageView.image =centerImage;
        _rightImageView.image =rightImage;
        NSDate * loadTime = [NSDate date];
        [self.mainPagePicBufferDic setObject:leftImage forKey:@"leftImage"];
        [self.mainPagePicBufferDic setObject:centerImage forKey:@"centerImage"];
        [self.mainPagePicBufferDic setObject:rightImage forKey:@"rightImage"];
        [self.mainPagePicBufferDic setObject:loadTime forKey:@"loadTime"];
        //写入对应位置
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documents stringByAppendingPathComponent:@"mainPagePicBufferDic.archiver"];//拓展名可以自己随便取
        
        BOOL writeResult =[NSKeyedArchiver archiveRootObject:self.mainPagePicBufferDic toFile:path];
        NSLog(@"%@",writeResult ? @"写入主页图片成功":@"写入主页图片失败");
        
    }
}

//读取图片缓存
-(void)readFileDic{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"mainPagePicBufferDic.archiver"];
    if ([[NSKeyedUnarchiver unarchiveObjectWithFile:path]isKindOfClass:[NSMutableDictionary class]]) {
        self.mainPagePicBufferDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}

#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageNameArray:(NSArray *)imageNameArray
{
    _imageNameArray = imageNameArray;
    [self readFileDic];
    if ([self.mainPagePicBufferDic isKindOfClass:[NSMutableDictionary class]]&&(self.mainPagePicBufferDic.count == 4)) {
        UIImage* leftImage = [self.mainPagePicBufferDic objectForKey:@"leftImage"];
        UIImage* centerImage = [self.mainPagePicBufferDic objectForKey:@"centerImage"];
        UIImage* rightImage = [self.mainPagePicBufferDic objectForKey:@"rightImage"];
        
        _leftImageView.image =leftImage;
        _centerImageView.image =centerImage;
        _rightImageView.image =rightImage;
    }else{
        _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
        _centerImageView.image = [UIImage imageNamed:_imageNameArray[1]];
        _rightImageView.image = [UIImage imageNamed:_imageNameArray[2]];
    }
}

#pragma mark - 设置每个对应广告对应的广告语
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle
{
    _adTitleArray = adTitleArray;
    
    if(adTitleStyle == AdTitleShowStyleNone)
    {
        return;
    }

    
    _leftAdLabel = [[UILabel alloc]init];
    _centerAdLabel = [[UILabel alloc]init];
    _rightAdLabel = [[UILabel alloc]init];
    
    
    _leftAdLabel.frame = CGRectMake(10, UISCREENHEIGHTS - 40, UISCREENWIDTHS, 20);
    //[_leftImageView addSubview:_leftAdLabel];
    _centerAdLabel.frame = CGRectMake(10, UISCREENHEIGHTS - 40, UISCREENWIDTHS, 20);
    //[_centerImageView addSubview:_centerAdLabel];
    _rightAdLabel.frame = CGRectMake(10, UISCREENHEIGHTS - 40, UISCREENWIDTHS, 20);
    //[_rightImageView addSubview:_rightAdLabel];
    
    if (adTitleStyle == AdTitleShowStyleLeft) {
        _leftAdLabel.textAlignment = NSTextAlignmentLeft;
        _centerAdLabel.textAlignment = NSTextAlignmentLeft;
        _rightAdLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (adTitleStyle == AdTitleShowStyleCenter)
    {
        _leftAdLabel.textAlignment = NSTextAlignmentCenter;
        _centerAdLabel.textAlignment = NSTextAlignmentCenter;
        _rightAdLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        _leftAdLabel.textAlignment = NSTextAlignmentRight;
        _centerAdLabel.textAlignment = NSTextAlignmentRight;
        _rightAdLabel.textAlignment = NSTextAlignmentRight;
    }
    
    
    _leftAdLabel.text = _adTitleArray[0];
    _centerAdLabel.text = _adTitleArray[1];
    _rightAdLabel.text = _adTitleArray[2];
    
}


#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageNameArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHTS - 20 + NAVIGATIONHIGHT, 20*_pageControl.numberOfPages, 20);
    }
    else if (PageControlShowStyle == UIPageControlShowStyleCenter)
    {
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTHS/2.0, HIGHT+UISCREENHEIGHTS - 10+ NAVIGATIONHIGHT);
    }
    else
    {
        _pageControl.frame = CGRectMake( UISCREENWIDTHS - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHTS - 20+ NAVIGATIONHIGHT, 20*_pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}
//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [[self superview] addSubview:_pageControl];
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    [self setContentOffset:CGPointMake(UISCREENWIDTHS * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

- (void)recountTheTimeIsPause:(BOOL)Action{
    if (!Action) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }else{
        [_moveTime setFireDate:[NSDate distantFuture]];
    }
    _isTimeUp = NO;
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.contentOffset.x == 0)
    {   if(currentImage == 0) {
        currentImage = _imageNameArray.count - 1;
        }
        else{
         currentImage = (currentImage-1)%_imageNameArray.count;
        }
        if(_pageControl.currentPage == 0) {
            _pageControl.currentPage = _imageNameArray.count - 1;
        }    else{
            _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
        }
        
        UIImage *temp = _leftImageView.image;
        _leftImageView.image = _rightImageView.image;
        _rightImageView.image = _centerImageView.image;
        _centerImageView.image = temp;
    }
    else if(self.contentOffset.x == UISCREENWIDTHS * 2)
    {
       currentImage = (currentImage+1)%_imageNameArray.count;
       _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
        
        UIImage *temp = _leftImageView.image;
        _leftImageView.image = _centerImageView.image;
        _centerImageView.image = _rightImageView.image;
        _rightImageView.image = temp;
    }
    else
    {
        return;
    }
    
    self.contentOffset = CGPointMake(UISCREENWIDTHS, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}

@end

