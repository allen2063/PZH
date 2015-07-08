//
//  CustomScrollView.m
//  PZH
//
//  Created by ZengYifei on 15/7/7.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "CustomScrollView.h"
@interface CustomScrollView()

@property (strong, nonatomic)NSMutableArray *array4Btn;
@property (strong, nonatomic)UIView *bottomLineView;

@end
@implementation CustomScrollView
@synthesize scr;
#define HYSegmentedControl_Height (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 30:70
#define HYSegmentedControl_Width ([UIScreen mainScreen].bounds.size.width)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO
#define Min_Width_4_Button 80.0

#define Define_Tag_add 1000

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate
{
    CGRect rect4View = CGRectMake(0, 0, HYSegmentedControl_Width, 70);
    if (self = [super initWithFrame:rect4View]) {
        CGFloat width4btn;
        if ([titles count]<6) {
            width4btn = rect4View.size.width/[titles count];
        }else{
            width4btn = rect4View.size.width/6;
        }
        self.backgroundColor = [UIColor blackColor];
        self.scr = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scr.backgroundColor = [UIColor redColor];
        //scr.userInteractionEnabled = YES;
        //scr.contentSize = CGSizeMake(80, 80);
        self.scr.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        self.scr.contentSize = CGSizeMake(HYSegmentedControl_Width*3, 70);
        //scr.pagingEnabled = YES;
        self.scr.showsHorizontalScrollIndicator = NO;
        self.scr.showsVerticalScrollIndicator = NO;
        self.scr.scrollsToTop = NO;
        self.scr.bounces = NO;
        self.scr.delegate = self;
        [self addSubview:scr];
        
//        self.backgroundColor = [UIColor redColor];
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
//        self.contentSize = CGSizeMake((width4btn)*[titles count], 0);
//        //scr.pagingEnabled = YES;
//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;
//        self.scrollsToTop = NO;
//        self.bounces = NO;
        
        UIButton * testBtns = [UIButton buttonWithType:UIButtonTypeCustom];//[[UITextView alloc]initWithFrame:CGRectMake(0, -64, 320*3, 130)] ;
        testBtns.frame =CGRectMake(0, -64, 50, 30);
        testBtns.backgroundColor = [UIColor blueColor];
        [testBtns setTitle:@"1111" forState:UIControlStateNormal] ;
        
        UIButton * testBtns1 = [UIButton buttonWithType:UIButtonTypeCustom];//[[UITextView alloc]initWithFrame:CGRectMake(0, -64, 320*3, 130)] ;
        testBtns1.frame =CGRectMake(250, -64, 50, 30);
        testBtns1.backgroundColor = [UIColor blueColor];
        [testBtns1 setTitle:@"2222" forState:UIControlStateNormal] ;
        
        UIButton * testBtns2 = [UIButton buttonWithType:UIButtonTypeCustom];//[[UITextView alloc]initWithFrame:CGRectMake(0, -64, 320*3, 130)] ;
        testBtns2.frame =CGRectMake(500, -64, 50, 30);
        testBtns2.backgroundColor = [UIColor blueColor];
        [testBtns2 setTitle:@"3333" forState:UIControlStateNormal] ;
        
        [self.scr addSubview:testBtns];
        [self.scr addSubview:testBtns1];
        [self.scr addSubview:testBtns2];
        
        for (int i = 0; i<[titles count]; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor yellowColor];
            btn.frame = CGRectMake(i*(width4btn), -64, width4btn-5, HYSegmentedControl_Height);
            [btn setTitleColor:UIColorFromRGBValue(0x999999) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:(isPhone? 14 : 18)];
            [btn setTitleColor:UIColorFromRGBValue(0x454545) forState:UIControlStateSelected];
            [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            //[btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = Define_Tag_add+i;
            //[self addSubview:btn];
            [_array4Btn addObject:btn];
            
            if (i == 0) {
                btn.selected = YES;
            }
        }
        
//        self.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
//        [self setUserInteractionEnabled:YES];
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;
//        self.scrollsToTop = NO;
//        self.bounces = NO;
//        //
//        //  array4btn
//        //
//        _array4Btn = [[NSMutableArray alloc] initWithCapacity:[titles count]];
//        
//        //
//        //  set button
//        //
//        CGFloat width4btn = rect4View.size.width/[titles count];
//        self.contentSize = CGSizeMake([titles count]*width4btn, 0);
//        if (width4btn < Min_Width_4_Button) {
//            width4btn = Min_Width_4_Button;
//        }
//        
//        NSLog(@"frame:%@,size:%@,point:%@",NSStringFromCGRect(self.frame) ,NSStringFromCGSize(self.contentSize),NSStringFromCGPoint(self.contentOffset));
//        for (int i = 0; i<[titles count]; i++) {
//            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(i*width4btn, -64, width4btn, HYSegmentedControl_Height);
//            [btn setTitleColor:UIColorFromRGBValue(0x999999) forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:14];
//            [btn setTitleColor:UIColorFromRGBValue(0x454545) forState:UIControlStateSelected];
//            [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
//            //[btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
//            btn.tag = Define_Tag_add+i;
//            [self addSubview:btn];
//            [_array4Btn addObject:btn];
//            
//            if (i == 0) {
//                btn.selected = YES;
//            }
//        }
//        
//        //
//        //  lineView
//        //
//        CGFloat height4Line = HYSegmentedControl_Height/3.0f;
//        CGFloat originY = (HYSegmentedControl_Height - height4Line)/2;
//        for (int i = 1; i<[titles count]; i++) {
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*width4btn-1.0f, originY-64, 1.0f, height4Line)];
//            lineView.backgroundColor = UIColorFromRGBValue(0xcccccc);
//            [self addSubview:lineView];
//        }
//        
//        //
//        //  bottom lineView
//        //
//        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, HYSegmentedControl_Height-1-64, width4btn-10.0f, 1.0f)];
//        _bottomLineView.backgroundColor = UIColorFromRGBValue(0x454545);
//        [self addSubview:_bottomLineView];
    }
    return self;
}



//- (void)segmentedControlChange:(UIButton *)btn
//{
//    btn.selected = YES;
//    for (UIButton *subBtn in self.array4Btn) {
//        if (subBtn != btn) {
//            subBtn.selected = NO;
//        }
//    }
//    
//    CGRect rect4boottomLine = self.bottomLineView.frame;
//    rect4boottomLine.origin.x = btn.frame.origin.x +5;
//    
//    CGPoint pt = CGPointZero;
//    BOOL canScrolle = NO;
//    if ((btn.tag - Define_Tag_add) >= 2 && [_array4Btn count] > 4 && [_array4Btn count] > (btn.tag - Define_Tag_add + 2)) {
//        pt.x = btn.frame.origin.x - Min_Width_4_Button*1.5f;
//        canScrolle = YES;
//    }else if ([_array4Btn count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_array4Btn count]){
//        pt.x = (_array4Btn.count - 4) * Min_Width_4_Button;
//        canScrolle = YES;
//    }else if (_array4Btn.count > 4 && (btn.tag - Define_Tag_add) < 2){
//        pt.x = 0;
//        canScrolle = YES;
//    }
//    NSLog(@"frame:%@,size:%@,point:%@",NSStringFromCGRect(self.frame) ,NSStringFromCGSize(self.contentSize),NSStringFromCGPoint(self.contentOffset));
//    NSLog(@"pt:%@",NSStringFromCGPoint(pt));
//    if (canScrolle) {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.contentOffset = pt;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 animations:^{
//                self.bottomLineView.frame = rect4boottomLine;
//            }];
//        }];
//    }else{
//        [UIView animateWithDuration:0.2 animations:^{
//            self.bottomLineView.frame = rect4boottomLine;
//        }];
//    }
//    
//    NSLog(@"frame:%@,size:%@,point:%@",NSStringFromCGRect(self.frame) ,NSStringFromCGSize(self.contentSize),NSStringFromCGPoint(self.contentOffset));
//    
//}
//
//- (void)changeSegmentedControlWithIndex:(NSInteger)index
//{
//    if (index > [_array4Btn count]-1) {
//        NSLog(@"index 超出范围");
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"index 超出范围" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//        [alertView show];
//        return;
//    }
//    
//    UIButton *btn = [_array4Btn objectAtIndex:index];
//    [self segmentedControlChange:btn];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    NSLog(@"scrollViewDidScroll");
//    CGPoint point=scrollView.contentOffset;
//    NSLog(@"%f,%f",point.x,point.y);
//    // 从中可以读取contentOffset属性以确定其滚动到的位置。
//    
//    // 注意：当ContentSize属性小于Frame时，将不会出发滚动
//    
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
