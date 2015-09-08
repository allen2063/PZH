//
//  PicForPZHViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "PicForPZHViewController.h"
#import "DetailWebViewController.h"
#import "GMDCircleLoader.h"
#import "DJRefresh.h"
#import "HYSegmentedControl.h"
@interface PicForPZHViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DJRefreshDelegate>{
    AppDelegate * appDelegate;
    DJRefreshDirection directionForNow;
    int threadCount;
    int totalCellForSeg;        //此seg里面共有多少图片
    BOOL loadNextPage;
}
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)DJRefresh * refresh;
@property (atomic,strong)NSMutableArray * dataList;
@end

@implementation PicForPZHViewController
@synthesize titleLabel,seg,segArray,tempArray,currentSegTitle,picBufferDic;
#define CELLVIEWHEIGHT 98
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetYXPZH_ContentResult:) name:@"GetYXPZH_ContentResult" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouchedForPic:) name:@"segTouched" object:nil];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.segArray = [NSMutableArray arrayWithObjects:@"城市新貌",@"自然风光",@"美食天地",@"开发建设",@"旅游产品",@"节庆赛事",@"幸福家园", nil];
        self.tempArray = [[NSMutableArray alloc]init];
        self.picBufferDic = [[NSMutableDictionary alloc]init];
        self.currentSegTitle = @"城市新貌";
        [self createSegmentedControl];
    }
    return self;
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    if (appDelegate.writePicFinished) {
        appDelegate.writePicFinished =NO;
        [NSThread detachNewThreadSelector:@selector(writePic) toTarget:self withObject:nil];
    }
}

-(void)GetYXPZH_ContentResult:(NSNotification *)note{
    NSString *htmlString = [[[note userInfo] objectForKey:@"info"]stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableArray * tempArrays = (NSMutableArray *)[htmlString componentsSeparatedByString:@";"];
    totalCellForSeg = [[tempArrays objectAtIndex:0]intValue];       //此seg里面共有多少图片
    [tempArrays removeObjectAtIndex:0];
    int picsInPage = NUMBEROFPICFORPAGE;
    //如果返回的实际图片数小于请求的图片数
    if (NUMBEROFPICFORPAGE > (tempArrays.count-1)) {
        picsInPage = (int)tempArrays.count -1;    //去除切除后尾部的空元素
        loadNextPage = NO;
    }
    //NSLog(@"多进程开始  计时开始");
    //多线程返回计数
    threadCount = 0;
    [self.tempArray removeAllObjects];
    for (int i = 0; i<picsInPage; i++) {
        NSArray * tempArrayss = [[tempArrays objectAtIndex:i ] componentsSeparatedByString:@","];
        NSMutableArray * tempArraysss = [[NSMutableArray alloc]initWithArray:tempArrayss];
        [tempArraysss addObject:[NSString stringWithFormat:@"%d",picsInPage]];
        [tempArraysss addObject:[NSString stringWithFormat:@"%d",i]];               //线程标记
        NSLog(@"线程%d已抛出",i);
        [NSThread detachNewThreadSelector:@selector(loadData:) toTarget:self withObject:tempArraysss];
    }
    
}

- (void) loadData:(NSMutableArray *) tempArraysss
{
    
    NSString * url = [(NSString*)[tempArraysss objectAtIndex:1]stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary * dic;
//    NSTimeInterval timeOut = -60*60*24;          //超时控制  如果超过这个时间则要从网络请求更新图片
//    if ([[self.picBufferDic objectForKey:url] isKindOfClass:[NSDictionary class]] ) {
//        NSDate * lastLoadingTime = [[self.picBufferDic objectForKey:url] objectForKey:@"loadDate"];
//        if (lastLoadingTime.timeIntervalSinceNow > timeOut) {     //缓存未超时
//            dic = [self.picBufferDic objectForKey:url];
//            NSLog(@"读取图片缓存,%f",lastLoadingTime.timeIntervalSinceNow);
//        }
//        else{           //超时  更新
//            NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
//            UIImage* image = [[UIImage alloc] initWithData:imageData];
//            UIImageView * ImgView = [[UIImageView alloc]initWithImage:image];
//            NSDate * loadDate=[NSDate date];
//            dic = [[NSDictionary alloc]initWithObjectsAndKeys:[tempArraysss objectAtIndex:0],@"title",ImgView,@"imgView",image,@"img",url,@"url",loadDate,@"loadDate", nil];
//            if ([[dic objectForKey:@"imgView"] isKindOfClass:[UIImageView class]] && [[dic objectForKey:@"imgView"] respondsToSelector:@selector(setFrame:)])  //判断返回的图片是否受损
//            {
//                [self.picBufferDic setObject:dic forKey:url];
//            }
//        }
//    }
//    else{       //为空  更新
//        NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
//        UIImage* image = [[UIImage alloc] initWithData:imageData];
//        UIImageView * ImgView = [[UIImageView alloc]initWithImage:image];
//        NSDate * loadDate=[NSDate date];
//        dic = [[NSDictionary alloc]initWithObjectsAndKeys:[tempArraysss objectAtIndex:0],@"title",ImgView,@"imgView",image,@"img",url,@"url",loadDate,@"loadDate", nil];
//        if ([[dic objectForKey:@"imgView"] isKindOfClass:[UIImageView class]] && [[dic objectForKey:@"imgView"] respondsToSelector:@selector(setFrame:)])  //判断可能返回的图片是否受损
//        {
//            [self.picBufferDic setObject:dic forKey:url];
//        }
//    }
    //检测缓存中是否有此图片
    if ([[self.picBufferDic objectForKey:url] isKindOfClass:[NSDictionary class]] ) {
        NSDate * lastLoadingTime = [[self.picBufferDic objectForKey:url] objectForKey:@"loadDate"];
        dic = [self.picBufferDic objectForKey:url];
        NSLog(@"读取图片缓存,%f",lastLoadingTime.timeIntervalSinceNow);
        //超时  更新
        if ([[dic objectForKey:@"imgView"] isKindOfClass:[UIImageView class]] && [[dic objectForKey:@"imgView"] respondsToSelector:@selector(setFrame:)])  //判断返回的图片是否受损
        {
            [self.picBufferDic setObject:dic forKey:url];
        }
    }
    else{       //为空  更新
        NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        UIImageView * ImgView = [[UIImageView alloc]initWithImage:image];
        NSDate * loadDate=[NSDate date];
        dic = [[NSDictionary alloc]initWithObjectsAndKeys:[tempArraysss objectAtIndex:0],@"title",ImgView,@"imgView",image,@"img",url,@"url",loadDate,@"loadDate", nil];
        if ([[dic objectForKey:@"imgView"] isKindOfClass:[UIImageView class]] && [[dic objectForKey:@"imgView"] respondsToSelector:@selector(setFrame:)])  //判断可能返回的图片是否受损
        {
            [self.picBufferDic setObject:dic forKey:url];
        }
    }


    [self.tempArray addObject:dic];
    threadCount++;
    NSLog(@"come:%@ back:%@ total:%@",[tempArraysss objectAtIndex:3],[NSString stringWithFormat:@"%d",threadCount],[tempArraysss objectAtIndex:2]);
    if([[tempArraysss objectAtIndex:2] isEqualToString:[NSString stringWithFormat:@"%d",threadCount]]){ //核对已抛出的线程总数和已返回的线程数
        [self performSelectorOnMainThread:@selector(returnToMainThread:) withObject:self.tempArray  waitUntilDone:YES];
        NSLog(@"%d图片加在完毕",threadCount);
        
    }
    
}

- (void)writePic{
    //写入对应位置
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"picBufferDic.archiver"];//拓展名可以自己随便取
    
    BOOL writeResult =[NSKeyedArchiver archiveRootObject:self.picBufferDic toFile:path];
    appDelegate.writePicFinished = YES;
    NSLog(@"%@",writeResult ? @"写入图片缓存成功":@"写入图片缓存失败");
}

//读取图片缓存
-(void)readFileDic{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"picBufferDic.archiver"];
    if ([[NSKeyedUnarchiver unarchiveObjectWithFile:path]isKindOfClass:[NSMutableDictionary class]]) {
        self.picBufferDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        //NSLog(@"%@",self.picBufferDic);
    }
}

-(void) returnToMainThread:(NSMutableArray*) arr{
    //NSLog(@"多进程结束  计时结束");
    //调用结束动画
    __weak typeof(self)weakSelf=self;
    __strong typeof(weakSelf)strongSelf=weakSelf;
    
    
    if (directionForNow == DJRefreshDirectionTop) {
        [self.dataList removeAllObjects];
    }
    for (id dic in self.tempArray) {
        [self.dataList addObject:dic];
    }
    [strongSelf addDataForDirection:directionForNow];
}

- (void)segTouchedForPic:(NSNotification *)note{
    //获取二级标题  然后调用动画效果
    self.currentSegTitle = [[note userInfo] objectForKey:@"title"];
    [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"图看攀枝花";
    appDelegate.title = @"图看攀枝花";
    loadNextPage = YES;
    [self readFileDic];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //self.view.backgroundColor=[UIColor whiteColor];
    for (NSInteger i=0; i<NUMBEROFPICFORPAGE; i++) {
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"图看攀枝花",@"title",@"defaultPic",@"imgView", nil];
        [self.tempArray addObject:dic];
    }
    _dataList=[[NSMutableArray alloc] initWithArray:self.tempArray];

    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake(88, CELLVIEWHEIGHT);
    flowLayout.minimumLineSpacing=5;
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 14, 10, 14);
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.translatesAutoresizingMaskIntoConstraints=NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    _collectionView.alwaysBounceVertical=YES;
    
    NSDictionary * viewDicationary=@{@"collectionView":_collectionView};
    NSArray * ch=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:0 metrics:nil views:viewDicationary];
    NSArray * cv=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-104-[collectionView]-0-|" options:0 metrics:nil views:viewDicationary];
    
    [self.view addConstraints:ch];
    [self.view addConstraints:cv];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_collectionView delegate:self];
    _refresh.topEnabled=YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:NO];
    });
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction
{   //获取方向  方便在接收到服务器返回后调用结束动画时传递方向
    directionForNow = direction;
    //self.collectionView.userInteractionEnabled = NO;
    NSString * countOfPic = [NSString stringWithFormat:@"%d",NUMBEROFPICFORPAGE];
    if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
    {
        //self.dataList = [[NSMutableArray alloc] initWithArray:self.tempArray];
        for (NSInteger i=0; i<NUMBEROFPICFORPAGE; i++) {
            NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"图看攀枝花",@"title",@"defaultPic",@"imgView", nil];
            [self.dataList addObject:dic];
        }
        [appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andChannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:@"1"];
        appDelegate.currentPageNumber = 1;
    }
    else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
        if (loadNextPage) {
            NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
            [appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andChannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:curPage];
        }else{
            [self.refresh finishRefreshingDirection:direction animation:NO];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"所有图片加载已完成！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
}

- (void)addDataForDirection:(DJRefreshDirection)direction
{
    if (_dataList==nil) {
        _dataList=[[NSMutableArray alloc] init];
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"图看攀枝花",@"title",@"defaultPic",@"imgView", nil];
        [self.dataList addObject:dic];
    }
    
    [self.refresh finishRefreshingDirection:direction animation:NO];

    ///设置是否有下拉刷新
    if ([self.dataList count]>8)
    {
        self.refresh.bottomEnabled=YES;
    }
    else{
        self.refresh.bottomEnabled=NO;
    }
    [self.collectionView reloadData];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataList count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath ];
    
    UIButton * testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(0, 0, 88, CELLVIEWHEIGHT);
    UIImageView * testImgView;
    UILabel * testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 73, 88, 23)];
    testLabel.font = [UIFont systemFontOfSize:13];
    testLabel.textAlignment = NSTextAlignmentCenter;
    //(self.dataList.count == NUMBEROFPICFORPAGE)&&
 
    
    if ([[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"imgView"] isKindOfClass:[UIImageView class]] && [[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"imgView"] respondsToSelector:@selector(setFrame:)])  //由于网络缘故  很可能返回的图片已经受损
    {
        testImgView = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"imgView"];
        testLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
        //NSLog(@"%ld",(long)indexPath.row);
    }
    else if([[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"imgView"] isKindOfClass:[NSString class]]){            //初始化
        testImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jz.png"]];
        testLabel.text = @"图看攀枝花";
    }
    else if (![[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"imgView"] isKindOfClass:[UIImageView class]] || ![[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"imgView"] respondsToSelector:@selector(setFrame:)]){
        testImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jzsb.png"]];
        testLabel.text = @"图片加载失败";
    }
    
    testImgView.frame = CGRectMake(0, 0, 88, 75);
    [testBtn addSubview:testLabel];
    [testBtn addSubview:testImgView];
    
    cell.backgroundView =testBtn ;
    return cell;
}

- (void)collectionView:(UICollectionView * )collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    backgroundView.center = self.view.center;
    backgroundView.tag = 101;
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    [self.view addSubview:backgroundView];
    
    UIImage * selectedImg = [self.dataList[indexPath.row]objectForKey:@"img"];
    float imgRatio = selectedImg.size.height/selectedImg.size.width ;
    NSLog(@"imgRatio:%@",NSStringFromCGSize(selectedImg.size));
    float screeRatio = self.view.frame.size.height/self.view.frame.size.width;
    CGSize bigImgSize;
    if (imgRatio>screeRatio) {
        //长为最大值   宽等比例转换
        bigImgSize = CGSizeMake((self.view.frame.size.height*18/20)/imgRatio, self.view.frame.size.height*18/20);
    }else{
        //宽为最大值   长等比例转换
        bigImgSize = CGSizeMake(self.view.frame.size.width*18/20, (self.view.frame.size.width*18/20)*imgRatio);
    }
    
    UIImageView * bigImgView = [[UIImageView alloc]initWithImage:selectedImg];
    bigImgView.frame = CGRectZero;
    bigImgView.tag = 102;
    bigImgView.center = CGPointMake(self.view.center.x, self.view.center.y+32);
    bigImgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bigImgView];
    NSLog(@"bigImgSize:%@ screenSize:%@",NSStringFromCGSize(bigImgSize),NSStringFromCGSize(self.view.frame.size));

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSelectedPic)];
    [bigImgView addGestureRecognizer:recognizer];
    [backgroundView addGestureRecognizer:recognizer];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    backgroundView.alpha = 0.4;
    if (imgRatio>screeRatio) {
        //长为最大值  则高度固定    宽的起始点浮动（frame.x）
        bigImgView.frame = CGRectMake((self.view.frame.size.width-bigImgSize.width)/2  , self.view.frame.size.height*1/20+32, bigImgSize.width, bigImgSize.height);
    }
    else{
        //宽为最大值  则宽度固定    长的高度点浮动（frame.y）
        bigImgView.frame = CGRectMake(self.view.frame.size.width*1/20, (self.view.frame.size.height-bigImgSize.height)/2 +32, bigImgSize.width, bigImgSize.height);
    }
    [UIView commitAnimations];
}

- (void)cancelSelectedPic{
    UIView * backgroundView = [self.view viewWithTag:101];
    [backgroundView removeFromSuperview];

    UIView * bigImgView = [self.view viewWithTag:102];
    [bigImgView removeFromSuperview];
}

- (void)getDataForCollectionView{
    //appDelegate.conAPI getPicForPZHAPIWithChannelName:appDelegate.title andHannelNext:<#(NSString *)#> andPageSize:<#(NSString *)#> andCurPage:<#(NSString *)#>;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
