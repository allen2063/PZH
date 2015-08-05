//
//  ConnectionAPI.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "ConnectionAPI.h"
#import "AppDelegate.h"
@implementation ConnectionAPI


@synthesize webData;
@synthesize soapResults;
@synthesize xmlParser;
@synthesize conn;
@synthesize getXMLResults;
@synthesize resultDic;
@synthesize resultArray;
@synthesize elementFoundForMenuContent,elementFoundForPZHPic,elementFoundForPZHVideo,elementFoundForLoadMainPagePic,elementFoundForLoadTopNews,elementFoundForLoadTopNewsContent,elementFoundForAnnouncementOfPublicArrayList,elementFoundForAnnouncementOfPublicContent,elementFoundForOpenGovernmentAffairsArrayList,elementFoundForPassageContent,elementFoundForPassageList,elementFoundForCommonProblemsAndPoliciesAndRegulationsList,elementFoundForCommonProblemsAndPoliciesAndRegulationsContent,elementFoundForStatisticsOfWork,elementFoundForOnlineBusinessSearchResult,elementFoundForHotBusinessList,elementFoundForHotBusinessContent;

@synthesize matchingElementForMenuContent,matchingElementForPZHPic,matchingElementForPZHVideo,matchingElementForLoadMainPagePic,matchingElementForLoadTopNews,matchingElementForLoadTopNewsContent,matchingElementForAnnouncementOfPublicArrayList,matchingElementForAnnouncementOfPublicContent,matchingElementForOpenGovernmentAffairsArrayList,matchingElementForPassageContent,matchingElementForPassageList,matchingElementForCommonProblemsAndPoliciesAndRegulationsList,matchingElementForCommonProblemsAndPoliciesAndRegulationsContent,matchingElementForStatisticsOfWork,matchingElementForOnlineBusinessSearchResult,matchingElementForHotBusinessList,matchingElementForHotBusinessContent;
//@synthesize soapResults1;
//@synthesize elementFound1;
//@synthesize matchingElement2;       //isentender
//@synthesize soapResults2;
//@synthesize elementFound2;
//@synthesize matchingElement3;       //isextender
//@synthesize elementFound3;
//@synthesize matchingElement4;       //SessionID


- (id)init{
    self = [super init];
    count = 0;
    matchingElementForMenuContent = @"GetMenuContentResult";
    matchingElementForPZHPic = @"GetYXPZH_ContentResult";
    matchingElementForPZHVideo = @"GetSPPZH_ContentResult";
    matchingElementForLoadMainPagePic = @"LoadMainPagePicResult";   ///
    matchingElementForLoadTopNews = @"LoadTopNewsResult";     ///
    matchingElementForLoadTopNewsContent = @"LoadTopNewsContentResult";
    matchingElementForAnnouncementOfPublicArrayList = @"GetGGGS_ListResult";
    matchingElementForAnnouncementOfPublicContent = @"GetGGGS_ContentResult";
    matchingElementForOpenGovernmentAffairsArrayList = @"GetZWGK_ListResult";//根据接口  貌似政务公开里面领导活动 工作会议 部门动态 区县快讯的list都用同一个接口
    matchingElementForPassageContent = @"GetGGFW_ContentResult";//所有文章详情都是用此接口
    matchingElementForPassageList = @"GetGGFW_ListResult";//所有文章列表都是用此接口
    matchingElementForCommonProblemsAndPoliciesAndRegulationsList = @"GetMXQY_ListResult";  //常见问题等
    matchingElementForCommonProblemsAndPoliciesAndRegulationsContent = @"GetMXQY_ContentResult";  //常见问题等
    matchingElementForStatisticsOfWork= @"GetBJTJ_SUMResult"; //办件统计
    matchingElementForOnlineBusinessSearchResult= @"OnLineSelectResult"; //在线办事查询
    matchingElementForHotBusinessList= @"GetRDBS_ListResult"; //热点办事列表
    matchingElementForHotBusinessContent= @"GetRDBS_URLResult"; //热点办事内容

    return self;
}

- (void)withInterface:(NSString *)interface{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<%@ xmlns=\"http://tempuri.org/\">"
                         "</%@>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",interface,interface];
    
    NSLog(@"%@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: [NSString stringWithFormat: @"http://tempuri.org/%@",interface] forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value {
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<%@ xmlns=\"http://tempuri.org/\">"
                         "<%@>%@</%@>"
                         "</%@>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",interface,argument1Name,argument1Value,argument1Name,interface];
    
    NSLog(@"%@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: [NSString stringWithFormat: @"http://tempuri.org/%@",interface] forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}


- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(NSString *)argument2Value{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<%@ xmlns=\"http://tempuri.org/\">"
                         "<%@>%@</%@>"
                         "<%@>%@</%@>"
                         "</%@>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",interface,argument1Name,argument1Value,argument1Name,argument2Name,argument2Value,argument2Name,interface];
    
    NSLog(@"%@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: [NSString stringWithFormat: @"http://tempuri.org/%@",interface] forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(NSString *)argument2Value andArgument3Name:(NSString *)argument3Name andArgument3Value:(NSString *)argument3Value{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<%@ xmlns=\"http://tempuri.org/\">"
                         "<%@>%@</%@>"
                         "<%@>%@</%@>"
                         "<%@>%@</%@>"
                         "</%@>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",interface,argument1Name,argument1Value,argument1Name,argument2Name,argument2Value,argument2Name,argument3Name,argument3Value,argument3Name,interface];
    
    NSLog(@"%@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: [NSString stringWithFormat: @"http://tempuri.org/%@",interface] forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(NSString *)argument2Value andArgument3Name:(NSString *)argument3Name andArgument3Value:(NSString *)argument3Value andArgument4Name:(NSString *)argument4Name andArgument4Value:(NSString *)argument4Value{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<%@ xmlns=\"http://tempuri.org/\">"
                         "<%@>%@</%@>"
                         "<%@>%@</%@>"
                         "<%@>%@</%@>"
                         "<%@>%@</%@>"
                         "</%@>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",interface,argument1Name,argument1Value,argument1Name,argument2Name,argument2Value,argument2Name,argument3Name,argument3Value,argument3Name,argument4Name,argument4Value,argument4Name,interface];
    
    NSLog(@"%@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: [NSString stringWithFormat: @"http://tempuri.org/%@",interface] forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

- (void)getMainPagePic{
    [self withInterface:@"LoadMainPagePic"];
}

- (void)getTopNews{
    [self withInterface:@"LoadTopNews"];
}

- (void)getTopNewsContentWithTitile:(NSString *)title{
    [self withInterface:@"LoadTopNewsContent" andArgument1Name:@"title" andArgument1Value:title];
}


- (void)getMenuContentAPIWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext{
    [self withInterface:@"GetMenuContent" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext];
}

- (void)getPicForPZHAPIWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage{
    [self withInterface:@"GetYXPZH_Content" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext andArgument3Name:@"PageSize" andArgument3Value:pageSize andArgument4Name:@"CurPage" andArgument4Value:curPage];
}

- (void)getVideoForPZHAPIWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext{
    [self withInterface:@"GetSPPZH_Content" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext];
}

- (void)getAnnouncementOfPublicArrayListWithPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage{
    [self withInterface:@"GetGGGS_List" andArgument1Name:@"PageSize" andArgument1Value:pageSize andArgument2Name:@"CurPage" andArgument2Value:curPage];
}

- (void)getAnnouncementOfPublicContentWithTitle:(NSString *)title{
    [self withInterface:@"GetGGGS_Content" andArgument1Name:@"strTitle" andArgument1Value:title];
}

- (void)getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsListWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage{
    [self withInterface:@"GetZWGK_List" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext andArgument3Name:@"PageSize" andArgument3Value:pageSize andArgument4Name:@"CurPage" andArgument4Value:curPage];
}

- (void)getPassageContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title andCreateTime:(NSString *)createTime{
    [self withInterface:@"GetGGFW_Content" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext andArgument3Name:@"title" andArgument3Value:title andArgument4Name:@"createTime" andArgument4Value:createTime];
}

- (void)getAnnouncementOfWork{
    [self withInterface:@"GetBSGG_List"];
}

- (void)getWorkOnlineListWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage{
    [self withInterface:@"GetGGFW_List" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext andArgument3Name:@"PageSize" andArgument3Value:pageSize andArgument4Name:@"CurPage" andArgument4Value:curPage];
}

- (void)getWorkOnlineContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title{
    [self withInterface:@"GetGGFW_Content" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext andArgument3Name:@"title" andArgument3Value:title ];
}

- (void)getCommonProblemsAndPoliciesAndRegulationsListWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title{
    [self withInterface:@"GetMXQY_List" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext andArgument3Name:@"title" andArgument3Value:title ];
}

- (void)getCommonProblemsAndPoliciesAndRegulationsContentWithChannelName:(NSString *)channelName andChannelNext:(NSString *)channelNext andTitle:(NSString *)title{
    [self withInterface:@"GetMXQY_Content" andArgument1Name:@"channelName" andArgument1Value:channelName andArgument2Name:@"channelNext" andArgument2Value:channelNext andArgument3Name:@"title" andArgument3Value:title ];
}

- (void)getStatisticsOfWork{
    [self withInterface:@"GetBJTJ_SUM"];
}

- (void)getOnlineBusinessSearchResultWithString:(NSString *)string{
    [self withInterface:@"OnLineSelect" andArgument1Name:@"GscProjectCodeId" andArgument1Value:string];
}

- (void)getHotBusinessListWithPageSize:(NSString *)pageSize andCurPage:(NSString *)curPage{
    [self withInterface:@"GetRDBS_List" andArgument1Name:@"PageSize" andArgument1Value:pageSize andArgument2Name:@"CurPage" andArgument2Value:curPage];
}

- (void)getHotBusinessContentWithTitle:(NSString *)title{
    [self withInterface:@"GetRDBS_URL" andArgument1Name:@"Title" andArgument1Value:title];
}
//连接

#pragma mark URL Connection Data Delegate Methods

// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [self.webData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [self.webData appendData:data];
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    self.conn = nil;
    self.webData = nil;
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[self.webData mutableBytes]
                                                length:[self.webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
    NSLog(@"%@", theXML);
    //服务器报错
    isfault = NO;
    if ([theXML rangeOfString:@"soap:Fault"].length!=0) {
        isfault = YES;
    }
    // 使用NSXMLParser解析出我们想要的结果
    self.xmlParser = [[NSXMLParser alloc] initWithData: self.webData];
    [self.xmlParser setDelegate: self];
    [self.xmlParser setShouldResolveExternalEntities: YES];
    [self.xmlParser parse];
}


#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:self.matchingElementForMenuContent]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForMenuContent = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForPZHPic]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForPZHPic = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForPZHVideo]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForPZHVideo = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadMainPagePic]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForLoadMainPagePic = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadTopNewsContent]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForLoadTopNewsContent = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadTopNews]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForLoadTopNews = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForAnnouncementOfPublicArrayList]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForAnnouncementOfPublicArrayList = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForAnnouncementOfPublicContent]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForAnnouncementOfPublicContent = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForOpenGovernmentAffairsArrayList]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForOpenGovernmentAffairsArrayList = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForPassageContent]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForPassageContent = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForPassageList]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForPassageList = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForCommonProblemsAndPoliciesAndRegulationsList]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForCommonProblemsAndPoliciesAndRegulationsList = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForCommonProblemsAndPoliciesAndRegulationsContent]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForCommonProblemsAndPoliciesAndRegulationsContent = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForStatisticsOfWork]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForStatisticsOfWork = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForOnlineBusinessSearchResult]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForOnlineBusinessSearchResult = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForHotBusinessList]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForHotBusinessList = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForHotBusinessContent]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFoundForHotBusinessContent = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (self.elementFoundForPZHPic||self.elementFoundForPZHVideo||self.elementFoundForMenuContent||self.elementFoundForLoadMainPagePic||self.elementFoundForLoadTopNews||self.elementFoundForLoadTopNewsContent||self.elementFoundForAnnouncementOfPublicArrayList||self.elementFoundForAnnouncementOfPublicContent||self.elementFoundForOpenGovernmentAffairsArrayList||self.elementFoundForPassageContent||self.elementFoundForPassageList||self.elementFoundForCommonProblemsAndPoliciesAndRegulationsList||self.elementFoundForCommonProblemsAndPoliciesAndRegulationsContent||self.elementFoundForStatisticsOfWork||self.elementFoundForOnlineBusinessSearchResult||self.elementFoundForHotBusinessList||self.elementFoundForHotBusinessContent) {
        [self.soapResults appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (isfault) {
        return;
    }
    NSMutableDictionary *d;
    if (self.soapResults != nil) {
        d = [[NSMutableDictionary alloc]initWithObjectsAndKeys:self.soapResults,@"info", nil];
        //d = [NSMutableDictionary dictionaryWithObject:self.soapResults forKey:@"info"];
        NSLog(@"");
    }
    else  NSLog(@"插入字典数据为空 ");
    if ([elementName isEqualToString:self.matchingElementForMenuContent]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetWebResult" object:self userInfo:d];
        self.elementFoundForMenuContent = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForPZHPic]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetYXPZH_ContentResult" object:self userInfo:d];
        self.elementFoundForPZHPic = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForPZHVideo]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetSPPZH_ContentResult" object:self userInfo:d];
        self.elementFoundForPZHVideo = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadMainPagePic]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadMainPagePicResult" object:self userInfo:d];
        self.elementFoundForLoadMainPagePic = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadTopNews]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadTopNewsResult" object:self userInfo:d];
        self.elementFoundForLoadTopNews = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadTopNewsContent]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadTopNewsContentResult" object:self userInfo:d];
        self.elementFoundForLoadTopNewsContent = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForAnnouncementOfPublicArrayList]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetGGGS_ListResult" object:self userInfo:d];
        self.elementFoundForAnnouncementOfPublicArrayList = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForAnnouncementOfPublicContent]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PassageContentResult" object:self userInfo:d];
        self.elementFoundForAnnouncementOfPublicContent = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForOpenGovernmentAffairsArrayList]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetZWGK_ListResult" object:self userInfo:d];
        self.elementFoundForOpenGovernmentAffairsArrayList = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForPassageContent]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PassageContentResult" object:self userInfo:d];
        self.elementFoundForPassageContent = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForPassageList]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PassageListResult" object:self userInfo:d];
        self.elementFoundForPassageList = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForCommonProblemsAndPoliciesAndRegulationsList]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMXQY_ListResult" object:self userInfo:d];
        self.elementFoundForCommonProblemsAndPoliciesAndRegulationsList = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForCommonProblemsAndPoliciesAndRegulationsContent]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMXQY_ContentResult" object:self userInfo:d];
        self.elementFoundForCommonProblemsAndPoliciesAndRegulationsContent = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForStatisticsOfWork]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetBJTJ_SUMResult" object:self userInfo:d];
        self.elementFoundForStatisticsOfWork = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForOnlineBusinessSearchResult]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OnLineSelectResult" object:self userInfo:d];
        self.elementFoundForOnlineBusinessSearchResult = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForHotBusinessList]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetRDBS_ListResult" object:self userInfo:d];
        self.elementFoundForHotBusinessList = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForHotBusinessContent]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetRDBS_URLResult" object:self userInfo:d];
        self.elementFoundForHotBusinessContent = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.soapResults) {
        self.soapResults = nil;
    }
    if (isfault) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fault" object:self userInfo:nil];
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.soapResults) {
        self.soapResults = nil;
    }
}

#pragma mark - readFileArray

//读取热点业务
-(NSArray *)readFileArray
{
    NSLog(@"To read hotBusi........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"hotBusi.txt"];
    //从filePath 这个指定的文件里读
    NSArray * collectBusiArray = [NSArray arrayWithContentsOfFile:filePath];
    //NSLog(@"%@",[collectBusiArray objectAtIndex:0] );
    return collectBusiArray;
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}



@end
