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
}
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)DJRefresh * refresh;
@property (nonatomic,strong)NSMutableArray * dataList;
@end

@implementation PicForPZHViewController
@synthesize titleLabel,seg,segArray,tempArray,currentSegTitle;
#define CELLVIEWHEIGHT 98
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetYXPZH_ContentResult:) name:@"GetYXPZH_ContentResult" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouched:) name:@"segTouched" object:nil];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.segArray = [NSMutableArray arrayWithObjects:@"城市新貌",@"自然风光",@"美食天地",@"开发建设",@"旅游产品",@"节庆赛事",@"新福家园", nil];
        self.tempArray = [[NSMutableArray alloc]init];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"图看攀枝花";
    appDelegate.title = @"图看攀枝花";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    for (NSInteger i=0; i<NUMBEROFPICFORPAGE; i++) {
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"图看攀枝花",@"title",@"defaultPic",@"img", nil];
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
    NSString * countOfPic = [NSString stringWithFormat:@"%d",NUMBEROFPICFORPAGE];
    if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
    {
        self.dataList = [[NSMutableArray alloc] initWithArray:self.tempArray];
        [appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andHannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:@"1"];
        appDelegate.currentPageForPic = 1;
    }
    else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
        NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageForPic];
        [appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andHannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:curPage];
    }
    
//    __weak typeof(self)weakSelf=self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        __strong typeof(weakSelf)strongSelf=weakSelf;
//        [strongSelf addDataForDirection:directionForNow];
//    });
}

-(void)GetYXPZH_ContentResult:(NSNotification *)note{
    
    if ([[[self.dataList objectAtIndex:0] objectForKey:@"img"] isKindOfClass:[NSString class]]) {
        [self.dataList removeAllObjects];
    }
    
    NSString *htmlString = [[[note userInfo] objectForKey:@"1"]stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray * tempArrays = [htmlString componentsSeparatedByString:@";"];
    int picsInPage = NUMBEROFPICFORPAGE;
    //如果返回的实际图片数小于请求的图片数
    if (NUMBEROFPICFORPAGE > (tempArrays.count-1)) {
        picsInPage = (int)tempArrays.count -1;    //去除切除后尾部的空元素
    }
    for (int i = 0; i<picsInPage; i++) {
        NSArray * tempArrayss = [[tempArrays objectAtIndex:i ] componentsSeparatedByString:@","];
        NSString * url = [(NSString*)[tempArrayss objectAtIndex:1]stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        UIImageView * testImgView = [[UIImageView alloc]initWithImage:image];
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:[tempArrayss objectAtIndex:0],@"title",testImgView,@"img", nil];
        [self.dataList addObject:dic];
    }
    //调用结束动画
    __weak typeof(self)weakSelf=self;
    __strong typeof(weakSelf)strongSelf=weakSelf;
    
    [strongSelf addDataForDirection:directionForNow];
    
}

- (void)segTouched:(NSNotification *)note{
    //获取二级标题  然后调用动画效果
    self.currentSegTitle = [[note userInfo] objectForKey:@"title"];
    [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:NO];
}


- (void)addDataForDirection:(DJRefreshDirection)direction
{
    
    
    if (_dataList==nil) {
        _dataList=[[NSMutableArray alloc] init];
    }
    
//    if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
//    {
//        self.dataList = [[NSMutableArray alloc] initWithArray:self.tempArray];
//        [appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andHannelNext:@"城市新貌" andPageSize:@"15" andCurPage:@"1"];
//    }
    
    
//    for (int i=0; i<40; i++)
//    {
//        [self.dataList addObject:@""];
//    }
    
    
    [self.refresh finishRefreshingDirection:direction animation:NO];
    
    [self.collectionView reloadData];
    
    
    
    ///设置是否有下拉刷新
    if ([self.dataList count]>8)
    {
        self.refresh.bottomEnabled=YES;
    }
    else{
        self.refresh.bottomEnabled=NO;
    }
    
    
    
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
    
    if ([[[self.dataList objectAtIndex:0] objectForKey:@"img"] isKindOfClass:[UIImageView class]]) {
        testImgView = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"img"];
        testLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
        NSLog(@"%ld",(long)indexPath.row);
    }else{
        testImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jz.png"]];
        testLabel.text = @"图看攀枝花";
    }
    testImgView.frame = CGRectMake(0, 0, 88, 75);

    [testBtn addSubview:testLabel];
    [testBtn addSubview:testImgView];
    
    cell.backgroundView =testBtn ;
    return cell;
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
