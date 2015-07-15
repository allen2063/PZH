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
@synthesize elementFound;
@synthesize matchingElementForMenuContent;
@synthesize matchingElementForLoadMainPagePic;
@synthesize soapResults1;
@synthesize elementFound1;
@synthesize matchingElement2;       //isentender
@synthesize soapResults2;
@synthesize elementFound2;
@synthesize matchingElement3;       //isextender
@synthesize elementFound3;
@synthesize matchingElement4;       //SessionID


- (id)init{
    self = [super init];
    count = 0;
    matchingElementForMenuContent = @"GetMenuContentResult";
    matchingElementForLoadMainPagePic = @"LoadMainPagePicResult";
    return self;
}

- (void)test{
    
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<GetMenuContent xmlns=\"http://tempuri.org/\">"
                         "<channelId>%@</channelId>"
                         "</GetMenuContent>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",  @"01fb7c1b-b3d2-486e-af9d-eb64126184b9"];

    NSLog(@"%@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: @"http://tempuri.org/GetMenuContent" forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

- (void)test2{
    
    NSString * soapMsg12 = [NSString stringWithFormat:
                            @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n"
                            "<soap:Envelope \r\n"
                            "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \r\n"
                            "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\r\n "
                            "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\r\n"
                            "<soap:Body>\r\n"
                            "<LoadMainPagePic  xmlns=\"http://tempuri.org/\">\r\n"
                            "</LoadMainPagePic >\r\n"
                            "</soap:Body>\r\n"
                            "</soap:Envelope>\r\n"];
    NSLog(@"%@",soapMsg12);
    
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg12 length]];
    [req addValue: @"http://tempuri.org/LoadMainPagePic" forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg12 dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

- (void)getMenuContentAPIWithChannelName:(NSString *)ChannelName andChannelNext:(NSString *)ChannelNext{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<GetMenuContent xmlns=\"http://tempuri.org/\">"
                         "<channelName>%@</channelName>"
                         "<channelNext>%@</channelNext>"
                         "</GetMenuContent>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",  ChannelName,ChannelNext];
    
    NSLog(@"%@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"http://222.86.191.71:8010/WS_PZH.asmx"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: @"http://tempuri.org/GetMenuContent" forHTTPHeaderField:@"SOAPAction"];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
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
        self.elementFound = YES;
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadMainPagePic]) {
        if (!self.soapResults) {
            self.soapResults = [[NSMutableString alloc] init];
        }
        self.elementFound1 = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (self.elementFound||self.elementFound1) {
        [self.soapResults appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (isfault) {
        return;
    }
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithObject:soapResults forKey:@"1"];
    if ([elementName isEqualToString:self.matchingElementForMenuContent]) {
        //AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMenuContentResult" object:self userInfo:d];
        //[alert show];
        self.elementFound = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }
    else if ([elementName isEqualToString:self.matchingElementForLoadMainPagePic]) {
        //AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMenuContentResult" object:self userInfo:d];
        //[alert show];
        self.elementFound = FALSE;
        // 强制放弃解析
        [self.xmlParser abortParsing];
    }}

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
