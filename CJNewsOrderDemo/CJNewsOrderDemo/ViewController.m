//
//  ViewController.m
//  CJNewsOrderDemo
//
//  Created by lichq on 15/11/4.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "ViewController.h"
#import "PopupNewsOrderVC.h"

#define KDefaultCountOfUpsideList 10    //默认订阅频道数

//频道名称和对应的请求接口
#define KChannelList @"头条",@"娱乐",@"健康",@"星座",@"社会",@"佛教",@"时事",@"时尚",@"军事",@"旅游",@"房产",@"汽车",@"港澳",@"教育",@"历史",@"文化",@"财经",@"读书",@"台湾",@"体育",@"科技",@"评论"
#define KChannelUrlStringList @"http://api.3g.ifeng.com/iosNews?id=aid=SYLB10&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=YL53&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=JK36&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=XZ09&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=SH133&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=FJ31&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=XW23&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=SS78&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=JS83&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=LY67&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=FC81&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=QC45&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=GA18&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=JY90&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=LS153&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=WH25&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=CJ33&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=DS57&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=TW73&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=TY43,FOCUSTY43&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=KJ123&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=PL40&imgwidth=100&type=list&pagesize=20"


@interface ViewController ()
{
    
}

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"首页", nil);
}


- (IBAction)goPopupNewsOrderVC:(id)sender{
    PopupNewsOrderVC *vc = [[PopupNewsOrderVC alloc]initWithNibName:@"PopupNewsOrderVC" bundle:nil];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

//
- (IBAction)pushNewsOrderVC:(id)sender{
    ChannelOrderVC *orderVC = [[ChannelOrderVC alloc] init];
    orderVC.dataSource = self;
    orderVC.delegate = self;
    orderVC.title = @"新闻订阅";
    [self.navigationController pushViewController:orderVC animated:YES];
}



#pragma mark 数据源:ChannelOrderVCDataSource
- (NSMutableArray *)originChannelOrderYES_whenChannelFileNoExist{
    NSArray *channelNames = [NSArray arrayWithObjects:KChannelList, nil] ;
    NSArray *channelUrls = [NSArray arrayWithObjects:KChannelUrlStringList, nil];
    
    NSMutableArray *channel_order_YES_Ori = [NSMutableArray array]; //Origin
    for (int i = 0; i < channelNames.count; i++) {
        NSString *channelName = [channelNames objectAtIndex:i];
        NSString *channelUrl = [channelUrls objectAtIndex:i];
        ChannelModel *channel = [[ChannelModel alloc]initWithTitle:channelName urlString:channelUrl];
        if (i < KDefaultCountOfUpsideList - 1) {
            [channel_order_YES_Ori addObject:channel];
        }
    }
    return channel_order_YES_Ori;
}

- (NSMutableArray *)originChannelOrderNO_whenChannelFileNoExist{
    NSArray *channelNames = [NSArray arrayWithObjects:KChannelList, nil] ;
    NSArray *channelUrls = [NSArray arrayWithObjects:KChannelUrlStringList, nil];
    
    NSMutableArray *channel_order_NO_Ori = [NSMutableArray array];
    for (int i = 0; i < channelNames.count; i++) {
        NSString *channelName = [channelNames objectAtIndex:i];
        NSString *channelUrl = [channelUrls objectAtIndex:i];
        ChannelModel *channel = [[ChannelModel alloc]initWithTitle:channelName urlString:channelUrl];
        if (i >= KDefaultCountOfUpsideList - 1) {
            [channel_order_NO_Ori addObject:channel];
        }
    }
    return channel_order_NO_Ori;
}

#pragma mark 委托:ChannelOrderVCDelegate
- (void)hiddenChannelOrderVC:(ChannelOrderVC *)orderVC{
    if (orderVC->_viewArr1.count < 3) {
        [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示", nil)
                                   message:NSLocalizedString(@"请至少选择三个", nil)
                                  delegate:nil
                         cancelButtonTitle:NSLocalizedString(@"确定", nil)
                         otherButtonTitles:nil] show];
        return;
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGFloat width = self.view.bounds.size.width;//本例中orderButton.vc等于self
        CGFloat height = self.view.bounds.size.height;
        CGRect rect_hidden = CGRectMake(0, - height, width, height);
        [orderVC.view setFrame:rect_hidden];
        
    } completion:^(BOOL finished){
        [orderVC updateCurrentOrder_whenChangeOrder];
        
        [orderVC.view removeFromSuperview];
        [orderVC removeFromParentViewController];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
