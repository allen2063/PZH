//
//  ConnectionAPI.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ConnectionAPI : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>{
    //UIAlertView * alerts;

    BOOL isfault;
    int count;
    NSNotificationCenter *nc;
    NSMutableDictionary * UserInfo;
}

- (void)getTopNews;                     //获取首页热点新闻的图片、标题、内容
- (void)getTopNewsContentWithTitile:(NSString *)title;              //点击热点新闻后加载热点新闻详情
- (void)getMainPagePic;                 //获取首页三张滚动图片
- (void)getMenuContentAPIWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext;            //走进攀枝花详情
- (void)getPicForPZHAPIWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage;          //图看攀枝花详情
- (void)getVideoForPZHAPIWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext;        //视频攀枝花视频链接
- (void)getAnnouncementOfPublicArrayListWithPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage;       //公告公示文章列表
- (void)getAnnouncementOfPublicContentWithTitle:(NSString *)title;      //公告公示详情
- (void)getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsListWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage;       //领导活动、工作会议、部门动态列表
- (void)getPassageContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title andCreateTime:(NSString *)createTime;        //领导活动等详情页面
- (void)getAnnouncementOfWork;      //公告公示详情
- (void)getWorkOnlineListWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage;        //面向市民  面向企业 list
- (void)getWorkOnlineContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title;  //接口已改动  目前废弃  调用getPassage...
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFoundForMenuContent;
@property (nonatomic) BOOL elementFoundForPZHPic;
@property (nonatomic) BOOL elementFoundForPZHVideo;
@property (nonatomic) BOOL elementFoundForLoadMainPagePic;
@property (nonatomic) BOOL elementFoundForLoadTopNews;
@property (nonatomic) BOOL elementFoundForLoadTopNewsContent;
@property (nonatomic) BOOL elementFoundForAnnouncementOfPublicArrayList;
@property (nonatomic) BOOL elementFoundForAnnouncementOfPublicContent;
@property (nonatomic) BOOL elementFoundForOpenGovernmentAffairsArrayList;
@property (nonatomic) BOOL elementFoundForPassageContent;   //调用公共服务content接口
@property (nonatomic) BOOL elementFoundForPassageList;   //调用公共服务list接口

@property (strong, nonatomic) NSString *matchingElementForMenuContent;
@property (strong, nonatomic) NSString *matchingElementForPZHPic;
@property (strong, nonatomic) NSString *matchingElementForPZHVideo;
@property (strong, nonatomic) NSString *matchingElementForLoadMainPagePic;
@property (strong, nonatomic) NSString *matchingElementForLoadTopNews;
@property (strong, nonatomic) NSString *matchingElementForLoadTopNewsContent;
@property (strong, nonatomic) NSString *matchingElementForAnnouncementOfPublicArrayList;
@property (strong, nonatomic) NSString *matchingElementForAnnouncementOfPublicContent;
@property (strong, nonatomic) NSString *matchingElementForOpenGovernmentAffairsArrayList;
@property (strong, nonatomic) NSString *matchingElementForPassageContent;
@property (strong, nonatomic) NSString *matchingElementForPassageList;



@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSMutableString *getXMLResults;

@property (strong, nonatomic) NSDictionary *resultDic;
@property (strong, nonatomic) NSArray *resultArray;

//@property (strong, nonatomic) NSMutableString *soapResults1;
//@property (nonatomic) BOOL elementFound1;
//@property (strong, nonatomic) NSString *matchingElement2;
//@property (strong, nonatomic) NSMutableString *soapResults2;
//@property (nonatomic) BOOL elementFound2;
//@property (strong, nonatomic) NSString *matchingElement3;
//@property (nonatomic) BOOL elementFound3;
//@property (strong, nonatomic) NSString *matchingElement4;
@end
