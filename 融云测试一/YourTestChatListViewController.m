//
//  YourTestChatListViewController.m
//  融云测试一
//
//  Created by 张雨生 on 16/7/29.
//  Copyright © 2016年 meilun. All rights reserved.
//

#import "YourTestChatListViewController.h"
#import "chatViewController.h"
/**
 *  根据 token 设定当前是谁在登录
 */
//#define RONGCLOUD_IM_Token @"3b08/Ys/M08dzqOfYXbfXy45I5pjIZv95MVsB/R/awXvhNFKymj9F/W69K8fswR49PMmItu0e5w="
//#define RONGCLOUD_IM_Token  @"+6lEf5sge9jQIOCkPIgGDUEkSMNJ8g5EShCL81vk0zAcX8zz/84Ph5NSDbMU7IXS0uJJvxG+9qui9A6VU4Okcg=="

//#define RONGCLOUD_IM_Token  @"NP4fMtFJf6i1bz0pIL8Wp42k37a7voFImICPvKGx/UjqMzlegCdYxWNYYjPJ+3BVeu8G+I5mnRcx8fXD+1VhAg=="

//#define RONGCLOUD_IM_Token @"TPZ0Mc8yD78H/qrS8fAQ1I2k37a7voFImICPvKGx/UjqMzlegCdYxWFN7I9SZnJLsWXogbZDilMx8fXD+1VhAg=="

#define  RONGCLOUD_IM_Token  @"w65jj3ravwhF54R7HDqDCo2k37a7voFImICPvKGx/UiQkPiX8PAy97v4WkO1DQMbf2KwKvMsRXkx8fXD+1VhAg=="

/**
 *  设定当前是跟谁聊天
 */


#define FRIENDS @"1"


@interface YourTestChatListViewController ()

@end

@implementation YourTestChatListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理

//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
    
    
    
    
    //登陆融云
    
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    
//    NSString *token= RONGCLOUD_IM_Token;
    
    [[RCIM sharedRCIM] connectWithToken:RONGCLOUD_IM_Token success:^(NSString *userId) {
        
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取 这里会跳到会话列表界面  就是我们平常QQ聊天都有一个会话的列表  如果想直接跳到聊天界面 下面再说
        
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
        NSLog(@"Login successfully with userId: %@.", userId);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            chatViewController *chat = [[chatViewController alloc]init];
            
            
            //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
            chat.conversationType = ConversationType_PRIVATE;
            //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
            chat.targetId = FRIENDS;
            //设置聊天会话界面要显示的标题
            chat.title = @"与XXX的聊天";
            
            [self.navigationController pushViewController:chat animated:YES];
            
        });
        
    } error:^(RCConnectErrorCode status) {
        
        NSLog(@"login error status: %ld.", (long)status);
        
    } tokenIncorrect:^{
        
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
        
    }];
}

//
//  ViewController.m
//  融云测试一
//
//  Created by 张雨生 on 16/7/29.
//  Copyright © 2016年 meilun. All rights reserved.
//

//#import "ViewController.h"

//#import <Foundation/Foundation.h>

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
}




/**
 
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 
 */

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion

{
    
    //此处为了演示写了一个用户信息
    
    if ([@"1" isEqual:userId]) {
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        
        user.userId = @"1";
        
        user.name = @"李雷";
        
        user.portraitUri = @"";
        
        return completion(user);
        
    }else if([@"2" isEqual:userId]) {
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        
        user.userId = @"2";
        
        user.name = @"韩梅梅";
        
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
        
    }else if([@"3" isEqual:userId]) {
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        
        user.userId = @"3";
        
        user.name = @"韩梅梅";
        
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
        
    }
    
}

@end
