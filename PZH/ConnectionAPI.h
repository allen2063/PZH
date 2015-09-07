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
    float timeout;
    BOOL isback;
    BOOL isfault;
    int requestCount;
    NSNotificationCenter *nc;
    NSMutableDictionary * UserInfo;
    NSString * urlToServer;
    UIAlertView * alerts;
}

+(NSMutableDictionary *)readFileDic;
+ (NSString *)md5:(NSString *)str;  //md5加密

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
- (void)getBUMENDONGTAIContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title andCreateTime:(NSString *)createTime;        //bu部门动态页面
- (void)getAnnouncementOfWorkList;      //公告公示详情
- (void)getWorkOnlineListWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage;        //面向市民  面向企业 list
- (void)getWorkOnlineContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title;  //接口已改动  目前废弃  调用getPassage...
- (void)getCommonProblemsAndPoliciesAndRegulationsListWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title;//面向市民  面向企业的常见问题  相关政策
- (void)getCommonProblemsAndPoliciesAndRegulationsContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title;//面向市民  面向企业的常见问题  相关政策
- (void)getStatisticsOfWork;//办件统计
- (void)getOnlineBusinessSearchResultWithString:(NSString *)string;     //在线办事查询
- (void)getHotBusinessListWithPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage;     //热点办事列表
- (void)getHotBusinessContentWithTitle:(NSString *)title;

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
@property (nonatomic) BOOL elementFoundForCommonProblemsAndPoliciesAndRegulationsList;   //调用常见问题 相关政策
@property (nonatomic) BOOL elementFoundForCommonProblemsAndPoliciesAndRegulationsContent;   //调用常见问题 相关政策
@property (nonatomic) BOOL elementFoundForStatisticsOfWork;   //调用常见问题 相关政策
@property (nonatomic) BOOL elementFoundForOnlineBusinessSearchResult;   //在线办事查询结果
@property (nonatomic) BOOL elementFoundForHotBusinessList;   //热点办事列表
@property (nonatomic) BOOL elementFoundForHotBusinessContent;   //热点办事内容
@property (nonatomic) BOOL elementFoundForAnnouncementOfWorkList;   //办事公示
@property (nonatomic) BOOL elementFoundForBUMENDONGTAIContent;   //部门动态


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
@property (strong, nonatomic) NSString *matchingElementForCommonProblemsAndPoliciesAndRegulationsList;
@property (strong, nonatomic) NSString *matchingElementForCommonProblemsAndPoliciesAndRegulationsContent;
@property (strong, nonatomic) NSString *matchingElementForStatisticsOfWork;
@property (strong, nonatomic) NSString *matchingElementForOnlineBusinessSearchResult;
@property (strong, nonatomic) NSString *matchingElementForHotBusinessList;
@property (strong, nonatomic) NSString *matchingElementForHotBusinessContent;
@property (strong, nonatomic) NSString *matchingElementForAnnouncementOfWorkList;
@property (strong, nonatomic) NSString *matchingElementForBUMENDONGTAIContent;


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
