# CJNewsOrder
实现了凤凰新闻的频道订阅界面和功能，点击某个频道，可以将其移入或者移出订阅栏，剩下的频道自动重新排列。归档Model数组到本地app的Library文件夹。(参考http://code4app.com/ios/ifengNewsOrderDemo/53159e83933bf0473e8b5d08)

## Screenshots
![Example](./Screenshots/example1.gif "悬浮图片时候显示的文字")


## How to use
- ①、ChannelOrderVC的使用
```
//初始化如下：
#pragma mark - 类似网易新闻的订阅功能
- (IBAction)show_orderView:(id)sender{
    CGFloat y = 64;
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height - y;
    CGRect rect_hidden = CGRectMake(0, - height, width, height);
    CGRect rect_show = CGRectMake(0, y, width, height);

    ChannelOrderVC *orderVC = [[ChannelOrderVC alloc] init];
    orderVC.dataSource = self;
    orderVC.delegate = self;
    [orderVC.view setFrame:rect_hidden]; //注意点：setFrame要在此view被addSubview之前调用
    [self.view addSubview:orderVC.view];
    [self addChildViewController:orderVC];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
    [orderVC.view setFrame:rect_show];
    
    } completion:^(BOOL finished){
    
    }];
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
```


- ②、xxxx的使用
```

```

- ③、xxxx的使用
```

```
