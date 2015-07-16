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
- (void)getMenuContentAPIWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext;
- (void)getPicForPZHAPIWithChannelName:(NSString *)channelName andHannelNext:(NSString *)hannelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage;
- (void)getVideoForPZHAPIWihtChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext;
- (void)test;
- (void)test2;

@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFoundForMenuContent;
@property (nonatomic) BOOL elementFoundForPZHPic;
@property (nonatomic) BOOL elementFoundForPZHVideo;

@property (strong, nonatomic) NSString *matchingElementForMenuContent;
@property (strong, nonatomic) NSString *matchingElementForPZHPic;
@property (strong, nonatomic) NSString *matchingElementForPZHVideo;
@property (strong, nonatomic) NSString *matchingElementForLoadMainPagePic;

@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSMutableString *getXMLResults;

@property (strong, nonatomic) NSDictionary *resultDic;
@property (strong, nonatomic) NSArray *resultArray;

@property (strong, nonatomic) NSMutableString *soapResults1;
@property (nonatomic) BOOL elementFound1;
@property (strong, nonatomic) NSString *matchingElement2;
@property (strong, nonatomic) NSMutableString *soapResults2;
@property (nonatomic) BOOL elementFound2;
@property (strong, nonatomic) NSString *matchingElement3;
@property (nonatomic) BOOL elementFound3;
@property (strong, nonatomic) NSString *matchingElement4;
@end
