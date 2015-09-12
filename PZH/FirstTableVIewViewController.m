//
//  FirstTableVIewViewController.m
//  PZH
//
//  Created by ZengYifei on 15/8/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "FirstTableVIewViewController.h"
#import "PGCategoryView.h"
#import "PubiicServiceTableViewViewController.h"
@interface FirstTableVIewViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_leftTbale;
    UITableView *_rightTbale;
    UIView *_contentView;
    NSArray * fatherArray;
    NSArray * sonArray;
    NSInteger fatherIndex;
    AppDelegate * appDelegate;
}
@property (strong, nonatomic) PGCategoryView *categoryView;@property (strong,nonatomic)HYSegmentedControl * seg;



@end

@implementation FirstTableVIewViewController
@synthesize tableViews,titleLabel,dataList,heardDataList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil AndTagNumber:(NSInteger)tag AndSegArray:(NSMutableArray *)segArrays{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.titleLabel.text = appDelegate.title;
        self.segArray = segArrays;
        NSArray * educationTitleArray = [[NSArray alloc] initWithObjects:@"学前教育",@"小学教育",@"初中教育",@"中考",@"高中教育",@"高考",@"职业教育",@"继续教育",@"特殊教育",@"对外交流与留学教育",@"教育救助与资助",@"外来人口就读", nil];

        NSArray * arrL1R1 = @[@"招生动态",@"幼儿园名录",@"入园指南",@"收费标准",@"教学质量管理",@"政策法规"];
        NSArray * arrL1R2 = @[@"招生动态", @"小学名录",@"入学指南",@"片区划分",@"收费标准",@"招生计划",@"教学质量管理",@"政策法规",@"课程资源"];
        NSArray * arrL1R3 = @[@"招生动态",@"初中学校名录",@"入学指南",@"片区划分",@"收费标准",@"招生计划",@"教学质量管理",@"政策法规",@"课程资源"];
        NSArray * arrL1R4 = @[@"中招政策计划解读",@"中考招生人数",@"中考报名与志愿填报",@"中考特长生报考指南",@"中考加分和优先录取资格认定"];
        NSArray * arrL1R5 = @[@"招生动态",@"高中学校名录",@"入学指南",@"收费标准",@"理念录取分数线查询",@"中考录取结果查询",@"课程资源"];
        NSArray * arrL1R6 = @[@"高中会考动态",@"会考政策计划解读",@"高考政策计划解读",@"高考招考流程与招生人数",@"高考特长生报考指南",@"高考特长生报考指南",@"中考加分和优先录取资格认定"];
        NSArray * arrL1R7 = @[@"职业教育机构名录",@"入学指南",@"收费标准",@"政策法规",];
        NSArray * arrL1R8 = @[@"继续教育教育机构名录",@"入学指南",@"收费标准",@"政策法规",];
        NSArray * arrL1R9 = @[@"特殊教育教育机构名录",@"入学指南",@"收费标准",@"政策法规",];
        NSArray * arrL1R10 = @[@"对外交流服务",@"出国留学",@"来华留学",@"自费留学机构名录",];
        NSArray * arrL1R11 = @[@"救助与资助项目介绍",@"申请指南",@"表格下载",@"助学动态",];
        NSArray * arrL1R12 = @[@"外来人口就读指南",@"外来人口就读动态",];
        
        NSArray * educationDetailArray = [NSArray arrayWithObjects:arrL1R1,arrL1R2,arrL1R3,arrL1R4,arrL1R5,arrL1R6,arrL1R7,arrL1R8,arrL1R9,arrL1R10,arrL1R11,arrL1R12, nil];
        sonArray = [NSArray arrayWithArray:educationDetailArray];
        
        NSArray * insuranceTitleArray = [[NSArray alloc] initWithObjects:@"养老保险",@"医疗保险",@"工伤保险",@"失业保险",@"生育保险",@"老年人与福利",@"残疾人与福利",@"儿童福利",@"城乡最低生活保障",@"临时救助",@"农村五保供养", nil];
        
        NSArray * arrL2R1 = @[@"办事指南",@"缴费标准",@"待遇标准",@"法规政策"];
        NSArray * arrL2R2 = @[@"办事指南",@"缴费标准",@"待遇标准",@"医保定点机构",@"法规政策"];
        NSArray * arrL2R3 = @[@"办事指南",@"缴费标准",@"待遇标准",@"法规政策"];
        NSArray * arrL2R4 = @[@"办事指南",@"缴费标准",@"待遇标准",@"法规政策"];
        NSArray * arrL2R5 = @[@"办事指南",@"缴费标准",@"待遇标准",@"法规政策"];
        NSArray * arrL2R6 = @[@"办事指南",@"老年人福利院",@"老年人福利优待项目",@"法规政策"];
        NSArray * arrL2R7 = @[@"办事指南",@"残疾人服务机构",@"残疾标准查询",@"法规政策"];
        NSArray * arrL2R8 = @[@"办事指南",@"儿童福利院",@"法规政策"];
        NSArray * arrL2R9 = @[@"办事指南",@"待遇标准",@"法规政策"];
        NSArray * arrL2R10 = @[@"办事指南",@"救助标准",@"法规政策"];
        NSArray * arrL2R11 = @[@"办事指南",@"待遇标准",@"法规政策"];
        NSArray * insuranceDetailArray = [NSArray arrayWithObjects:arrL2R1,arrL2R2,arrL2R3,arrL2R4,arrL2R5,arrL2R6,arrL2R7,arrL2R8,arrL2R9,arrL2R10,arrL2R11, nil];
        
        
        NSArray * employmentTitleArray = [[NSArray alloc] initWithObjects:@"职业技能培训",@"职业技能鉴定",@"公务员招考",@"事业单位招聘",@"退伍军人安置",@"毕业生就业",@"农民工就业",@"失业人员再就业",@"人才引进",@"自主创业",@"劳动关系",@"劳动仲裁", nil];
        NSArray * arrL3R1 = @[@"办事指南",@"表格下载",@"培训机构",@"培训课程",@"补贴标准",@"政策法规"];
        NSArray * arrL3R2 = @[@"办事指南",@"职业技能鉴定机构",@"职业技能查询"];
        NSArray * arrL3R3 = @[@"招考动态",@"网上报名与缴费",@"成绩与录取情况",@"法规政策"];
        NSArray * arrL3R4 = @[@"招考动态",@"网上报名与缴费",@"成绩与录取情况",@"法规政策"];
        NSArray * arrL3R5 = @[@"办事指南",@"办理机构",@"政策法规"];
        NSArray * arrL3R6 = @[@"办事指南",@"招聘信息",@"档案查询",@"政策法规"];
        NSArray * arrL3R7 = @[@"办事指南",@"招聘信息",@"就业机构培训",@"政策法规"];
        NSArray * arrL3R8 = @[@"办事指南",@"招聘信息",@"再就业机构培训",@"政策法规"];
        NSArray * arrL3R9 = @[@"办事指南",@"创业园区",@"创业项目",@"创业服务机构",@"创业培训",@"政策法规"];
        NSArray * arrL3R10 = @[@"办事指南",@"合同范本",@"法规政策"];
        NSArray * arrL3R11 = @[@"办事指南",@"仲裁机构",@"法规政策"];
        NSArray * employmentDetailArray = [NSArray arrayWithObjects:arrL3R1,arrL3R2,arrL3R3,arrL3R4,arrL3R5,arrL3R6,arrL3R7,arrL3R8,arrL3R9,arrL3R10,arrL3R11,nil];
        
        NSArray * medicalTitleArray = [[NSArray alloc] initWithObjects:@"医疗机构与门诊住院",@"药店查询",@"药品信息",@"疾病预防",@"食品安全",@"药品安全",@"医疗救助", nil];
        NSArray * arrL4R1 = @[@"医院",@"定点医疗机构",@"社区卫生服务中心",@"诊所",@"就医指南",@"专家门诊",@"预约挂号"];
        NSArray * arrL4R2 = @[@"药店信息",@"定点药店信息"];
        NSArray * arrL4R3 = @[@"药品目录",@"药品价格"];
        NSArray * arrL4R4 = @[@"疫情报告",@"疫苗接种",@"疾控中心名录",@"职业病鉴定机构",@"疾病防治知识",@"健康知识宣传"];
        NSArray * arrL4R5 = @[@"执法监督信息",@"安全质量信息",@"食品行业信用查询",@"食品生产企业查询",@"食品经营企业查询",@"食品广告查询"];
        NSArray * arrL4R6 = @[@"执法监督信息",@"安全质量信息",@"药品基本信息",@"药品行业信用查询",@"药品经营企业查询",@"药品广告查询"];
        NSArray * arrL4R7 = @[@"办事指南",@"救助标准",@"医疗救助服务机构",@"法规政策"];
        NSArray * medicalDetailArray = [NSArray arrayWithObjects:arrL4R1,arrL4R2,arrL4R3,arrL4R4,arrL4R5,arrL4R6,arrL4R7,nil];
        
        NSArray * lodgingTitleArray = [[NSArray alloc] initWithObjects:@"廉租房",@"公共租赁房",@"经济适用房",@"购买新建商品房",@"二手房买卖",@"房屋租赁",@"房地产服务机构及人员",@"公积金缴存",@"公积金提取",@"公积金贷款", nil];
        NSArray * arrL5R1 = @[@"供应计划及进展",@"房源信息",@"办事指南",@"房租标准",@"法规政策"];
        NSArray * arrL5R2 = @[@"供应计划及进展",@"房源信息",@"办事指南",@"申请条件和房租标准",@"法规政策"];
        NSArray * arrL5R3 = @[@"供应计划及进展",@"房源信息",@"办事指南",@"申请条件",@"法规政策"];
        NSArray * arrL5R4 = @[@"成交统计分析",@"房源信息",@"购房合同及范本",@"产权登记",@"法规政策"];
        NSArray * arrL5R5 = @[@"成交统计分析",@"购房合同及范本",@"房屋产权查验指南",@"缴纳税费税率及减免规定",@"房屋验收注意事项",@"法规政策"];
        NSArray * arrL5R6 = @[@"成交统计分析",@"租房合同及范本",@"税费税率及减免规定",@"违法违规出租处罚标准",@"法规政策"];
        NSArray * arrL5R7 = @[@"房地产服务机构",@"执业（从业）人员信息",@"法规政策"];
        NSArray * arrL5R8 = @[@"办事指南",@"公积金账户查询",@"法规政策"];
        NSArray * arrL5R9 = @[@"办事指南",@"法规政策"];
        NSArray * arrL5R10 = @[@"办事指南",@"贷款查询",@"法规政策"];
        NSArray * lodgingDetailArray = [NSArray arrayWithObjects:arrL5R1,arrL5R2,arrL5R3,arrL5R4,arrL5R5,arrL5R6,arrL5R7,arrL5R8,arrL5R9,arrL5R10,nil];
        
        NSArray * trafficTitleArray = [[NSArray alloc] initWithObjects:@"公共汽车出行",@"长途汽车出行",@"出租车出行",@"路况与气象信息",@"交通其基础设施",@"道路通行费用",@"机动车服务",@"驾驶员服务",@"违法违规处理",@"事故处理", nil];
        NSArray * arrL6R1 = @[@"公共汽车查询",@"公交线路和站点",@"公交时间及班次",@"收费标准"];
        NSArray * arrL6R2 = @[@"长途汽车站信息",@"长途汽车线路",@"长途汽车班次",@"收费标准"];
        NSArray * arrL6R3 = @[@"出租车企业信息",@"收费标准",@"法规政策"];
        NSArray * arrL6R4 = @[@"路况信息",@"气象信息"];
        NSArray * arrL6R5 = @[@"停车场",@"加油站",@"收费站"];
        NSArray * arrL6R6 = @[@"收费站点费用标准"];
        NSArray * arrL6R7 = @[@"办事指南",@"服务机构名录",@"车险公司名录",@"法规政策"];
        NSArray * arrL6R8 = @[@"办事指南",@"服务机构名录",@"法规政策"];
        NSArray * arrL6R9 = @[@"办事指南",@"衡量标准",@"违法违规行为查询",@"法规政策"];
        NSArray * arrL6R10 = @[@"办事指南",@" 事故查询",@"法规政策"];
        NSArray * trafficDetailArray = [NSArray arrayWithObjects:arrL6R1,arrL6R2,arrL6R3,arrL6R4,arrL6R5,arrL6R6,arrL6R7,arrL6R8,arrL6R9,arrL6R10,nil];
        
        NSArray * marriageAndAdoptedTitleArray = [[NSArray alloc] initWithObjects:@"结婚",@"离婚",@"婚姻公正",@"生育一胎",@"生育二(多)胎",@"生育奖励扶助",@"收养登记", nil];
        NSArray * arrL7R1 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL7R2 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL7R3 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL7R4 = @[@"办事指南",@"表格下载",@"优生优育知识",@"法规政策"];
        NSArray * arrL7R5 = @[@"办事指南",@"表格下载",@"优生优育知识",@"法规政策"];
        NSArray * arrL7R6 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL7R7 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * marriageAndAdoptedDetailArray = [NSArray arrayWithObjects:arrL7R1,arrL7R2,arrL7R3,arrL7R4,arrL7R5,arrL7R6,arrL7R7,nil];
        
        NSArray * publicAndCareerTitleArray = [[NSArray alloc] initWithObjects:@"供水服务",@"供电服务",@"煤气服务",@"污水垃圾处理",@"消防安全",@"公共文化",@"体育事业",@"城市绿化",@"城市园林", nil];
        NSArray * arrL8R1 = @[@"供水指南",@"费用标准",@"服务机构",@"法规政策"];
        NSArray * arrL8R2 = @[@"停限电公告",@"供电指南",@"费用标准",@"服务机构",@"法规政策"];
        NSArray * arrL8R3 = @[@"供气指南",@"费用标准",@"服务机构",@"法规政策"];
        NSArray * arrL8R4 = @[@"办事指南",@"收费标准",@"服务企业",@"法规政策"];
        NSArray * arrL8R5 = @[@"消防报警",@"消防供水",@"消防培训",@"消防设施维修",@"办事服务",@"法规政策"];
        NSArray * arrL8R6 = @[@"服务场所",@"办事指南",@"监督管理",@"法规政策"];
        NSArray * arrL8R7 = @[@"体育场馆",@"健身设施",@"监督管理",@"法规政策"];
        NSArray * arrL8R8 = @[@"分布信息",@"规划信息",@"绿化基础设施建设",@"法规政策"];
        NSArray * arrL8R9 = @[@"分布信息",@"规划信息",@"治理信息",@"法规政策"];
        NSArray * publicAndCareerDetailArray = [NSArray arrayWithObjects:arrL8R1,arrL8R2,arrL8R3,arrL8R4,arrL8R5,arrL8R6,arrL8R7,arrL8R8,arrL8R9,nil];
        
        NSArray * certificateDealTitleArray = [[NSArray alloc] initWithObjects:@"户籍办理",@"身份证办理",@"暂住证/居住证办理",@"归国人员身份确认",@"驾驶证申请",@"驾驶证年检",@"驾驶证其他业务",@"护照办理",@"签证办理",@"通行证办理",@"教育培训类证件办理",@"医疗卫生类证件办理",@"司法律师雷证件办理",@"交通旅游类证件办理",@"工程建设类证件办理",@"其他类证件办理", nil];
        NSArray * arrL9R1 = @[@"入户",@"迁入",@"迁出",@"变更",@"注销",@"立户",@"分户",@"法规政策"];
        NSArray * arrL9R2 = @[@"申领",@"补领",@"换领",@"挂失",@"变更",@"法规政策"];
        NSArray * arrL9R3 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R4 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R5 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R6 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R7 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R8 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R9 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R10 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL9R11 = @[@"办事指南",@"表格下载",@"考试指南",@"成绩查询",@"法规政策"];
        NSArray * arrL9R12 = @[@"办事指南",@"表格下载",@"考试指南",@"成绩查询",@"法规政策"];
        NSArray * arrL9R13 = @[@"办事指南",@"表格下载",@"考试指南",@"成绩查询",@"法规政策"];
        NSArray * arrL9R14 = @[@"办事指南",@"表格下载",@"考试指南",@"成绩查询",@"法规政策"];
        NSArray * arrL9R15 = @[@"办事指南",@"表格下载",@"考试指南",@"成绩查询",@"法规政策"];
        NSArray * arrL9R16 = @[@"办事指南",@"表格下载",@"考试指南",@"成绩查询",@"法规政策"];
        NSArray * certificateDealDetailArray = [NSArray arrayWithObjects:arrL9R1,arrL9R2,arrL9R3,arrL9R4,arrL9R5,arrL9R6,arrL9R7,arrL9R8,arrL9R9,arrL9R10,arrL9R11,arrL9R12,arrL9R13,arrL9R14,arrL9R15,arrL9R16,nil];
        
        NSArray * enterprisesSetUpTitleArray = [[NSArray alloc] initWithObjects:@"名称预先登记核准",@"验资",@"前置审批许可",@"工商注册登记",@"刻制印章",@"消防证件办理",@"组织机构代码证申请",@"税务登记",@"统计登记",@"开立基本存款账户和划资", nil];
        NSArray * arrL10R1 = @[@"办事指南",@"表格下载",@"结果查询",@"名称预查询",@"法规政策"];
        NSArray * arrL10R2 = @[@"办事指南",@"表格下载",@"服务机构",@"收费标准",@"法规政策"];
        NSArray * arrL10R3 = @[@"审批事项",@"表格下载"];
        NSArray * arrL10R4 = @[@"办事指南",@"表格下载",@"结果查询",@"法规政策"];
        NSArray * arrL10R5 = @[@"办事指南",@"表格下载",@"服务机构",@"法规政策"];
        NSArray * arrL10R6 = @[@"办事指南",@"表格下载",@"结果查询",@"法规政策"];
        NSArray * arrL10R7 = @[@"办事指南",@"表格下载",@"结果查询",@"法规政策"];
        NSArray * arrL10R8 = @[@"办事指南",@"表格下载",@"结果查询",@"法规政策"];
        NSArray * arrL10R9 = @[@"办事指南",@"表格下载",@"结果查询",@"法规政策"];
        NSArray * arrL10R10 = @[@"办事指南",@"表格下载",@"服务机构",@"收费标准",@"法规政策"];
        NSArray * enterprisesSetUpDetailArray = [NSArray arrayWithObjects:arrL10R1,arrL10R2,arrL10R3,arrL10R4,arrL10R5,arrL10R6,arrL10R7,arrL10R8,arrL10R9,arrL10R10,nil];
        
        NSArray * businessTaxTitleArray = [[NSArray alloc] initWithObjects:@"企业年检",@"商标注册",@"知识产权",@"广告业务",@"合同信用",@"税务登记",@"发票业务",@"认定核定",@"申报纳税",@"税收优惠", nil];
        NSArray * arrL11R1 = @[@"办事指南",@"表格下载",@"结果查询",@"未年检企业公示",@"政策法规"];
        NSArray * arrL11R2 = @[@"办事指南",@"表格下载",@"商标代理机构",@"政策法规"];
        NSArray * arrL11R3 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL11R4 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL11R5 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL11R6 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL11R7 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL11R8 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * arrL11R9 = @[@"办事指南",@"表格下载",@"税率查询",@"法规政策"];
        NSArray * arrL11R10 = @[@"办事指南",@"表格下载",@"法规政策"];
        NSArray * businessTaxDetailArray = [NSArray arrayWithObjects:arrL11R1,arrL11R2,arrL11R3,arrL11R4,arrL11R5,arrL11R6,arrL11R7,arrL11R8,arrL11R9,arrL11R10,nil];
        
        NSArray * aptitudeTitleArray = [[NSArray alloc] initWithObjects:@"学历、非学历民办学校资质",@"职业技能培训资质",@"食品生产资质",@"食品流通资质",@"餐饮服务资质",@"医疗卫生资质",@"药品生产资质",@"药品经营资质",@"医疗器械生产资质",@"医疗器械经营资质", @"人力资源资质",@"种子生产资质",@"种子经营资质",@"农用化学制剂生产资质",@"农用化学制剂经营资质",@"农产品检验检疫资质",@"道路货运经营资质",@"道路客运经营资质",@"货(客)运站(场)经营资质",@"房地产开发企业资质",@"房地产估价机构资质",@"房产测绘单位资质",@"房地产经纪机构资质",@"物业服务企业资质",@"箭镞企业资质",@"工程勘探资质",@"工程设计资质",@"工程监理资质",@"工程造价资质",@"旅行社服务资质",@"旅行景区质量等级",nil];
        NSArray * arrL12R1 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R2 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R3 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R4 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R5 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R6 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R7 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R8 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R9 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R10 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R11 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R12 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R13 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R14 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R15 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R16 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R17 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R18 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R19 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R20 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R21 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R22 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R23 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R24 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R25 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R26 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R27 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R28 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R29 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R30 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * arrL12R31 = @[@"办事指南",@"表格下载",@"资质查询",@"法规政策",@"年检情况"];
        NSArray * aptitudeDetailArray = [NSArray arrayWithObjects:arrL12R1,arrL12R2,arrL12R3,arrL12R4,arrL12R5,arrL12R6,arrL12R7,arrL12R8,arrL12R9,arrL12R10,arrL12R11, arrL12R12,arrL12R13,arrL12R14,arrL12R15,arrL12R16,arrL12R17,arrL12R18,arrL12R19,arrL12R20,arrL12R21,arrL12R22,arrL12R23, arrL12R24,arrL12R25,arrL12R26,arrL12R27,arrL12R28,arrL12R29,arrL12R30,arrL12R31,nil];
        
        self.heardDataList=[[NSMutableArray alloc] initWithObjects:educationTitleArray,insuranceTitleArray,employmentTitleArray,medicalTitleArray,lodgingTitleArray,trafficTitleArray,marriageAndAdoptedTitleArray,publicAndCareerTitleArray,certificateDealTitleArray,enterprisesSetUpTitleArray,businessTaxTitleArray,aptitudeTitleArray, nil];
        self.dataList=[[NSMutableArray alloc] initWithObjects:educationDetailArray,insuranceDetailArray,employmentDetailArray,medicalDetailArray,lodgingDetailArray,trafficDetailArray,marriageAndAdoptedDetailArray,publicAndCareerDetailArray,certificateDealDetailArray,enterprisesSetUpDetailArray,businessTaxDetailArray,aptitudeDetailArray, nil];
        fatherArray = [NSArray arrayWithArray:[self.heardDataList objectAtIndex:tag]];
        fatherIndex =0;
        sonArray = [NSArray arrayWithArray:[self.dataList objectAtIndex:tag]];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        self.tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONHIGHT+HYSegmentedControl_Height, UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHIGHT - HYSegmentedControl_Height)];
        self.tableViews.delegate=self;
        self.tableViews.dataSource=self;
        //[self.view addSubview:self.tableViews];
        self.segArray = [NSMutableArray arrayWithObjects:appDelegate.title, nil];
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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_contentView];
    
    _leftTbale = [[UITableView alloc] init];
    _leftTbale.frame = CGRectMake(0, NAVIGATIONHIGHT+HYSegmentedControl_Height, UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHIGHT - HYSegmentedControl_Height);
    _leftTbale.dataSource = self;
    _leftTbale.delegate = self;
    _leftTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _leftTbale.showsVerticalScrollIndicator = NO;
    _leftTbale.tableFooterView = [[UIView alloc] init];
    [self.view insertSubview:_leftTbale belowSubview:_contentView];
    
    _rightTbale = [[UITableView alloc] init];
    _rightTbale.frame = CGRectMake(0, NAVIGATIONHIGHT+HYSegmentedControl_Height, _contentView.bounds.size.width, UISCREENHEIGHT - NAVIGATIONHIGHT - HYSegmentedControl_Height);
    _rightTbale.dataSource = self;
    _rightTbale.delegate = self;
    _rightTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _rightTbale.showsVerticalScrollIndicator = NO;
    _rightTbale.tableFooterView = [[UIView alloc] init];
    [_contentView addSubview:_rightTbale];
    
    
    CGRect frame = _contentView.frame;
    frame.origin.x -= 30;
    frame.size.width = 30;
    _categoryView = [PGCategoryView categoryRightView:_contentView];
    _categoryView.frame = frame;
    [self.view addSubview:_categoryView];
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTbale) {
        return fatherArray.count;
    }else{
        return [(NSArray *)[sonArray objectAtIndex:fatherIndex] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTbale) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = [fatherArray objectAtIndex:indexPath.row];
        return cell;
    }else{
        static NSString *CellIdentifier2 = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        NSLog(@"%@",indexPath);
        NSArray * arr = [sonArray objectAtIndex:fatherIndex];
        cell.textLabel.text = [arr objectAtIndex:indexPath.row];
        return cell;
    }
}

#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _leftTbale) {
        fatherIndex = indexPath.row;
        [_categoryView show];
        [_rightTbale reloadData];
        appDelegate.sonTitle = [fatherArray objectAtIndex:fatherIndex];
    }
    else{
        appDelegate.grandsonTitle = [[sonArray objectAtIndex:fatherIndex]objectAtIndex:indexPath.row];
        PubiicServiceTableViewViewController * detail = [[PubiicServiceTableViewViewController alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    
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
