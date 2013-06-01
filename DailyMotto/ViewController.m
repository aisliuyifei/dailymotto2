//
//  ViewController.m
//  DailyMotto
//
//  Created by 鹏 吴 on 3/20/12.
//  Copyright (c) 2012 galiumsoft. All rights reserved.
//

#import "ViewController.h"
#import "SCAppDelegate.h"
#import "UMSocialSnsService.h"
#define kWBSDKDemoAppKey @"1638447496"
#define kWBSDKDemoAppSecret @"4866007a20e88747b5ae101d6c796aaa"
#define kWBAlertViewLogOutTag 100
#define kWBAlertViewLogInTag  101
#import "ADVTheme.h"
#import "convertGB_BIG.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _socialData  = [[UMSocialData alloc] initWithIdentifier:@"UMSocialSDK" withTitle:nil];

    [self setTitle:@"每日金句"];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(buttonShareClicked:)] ;
    self.navigationItem.rightBarButtonItem = button;
    
    _convertor = [[convertGB_BIG alloc] init];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"simpleOrTrandition"]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:0] forKey:@"simpleOrTrandition"];
    }
    [ADVThemeManager customizeAppAppearance];
    labelTitle.shadowColor = [UIColor blackColor];
    labelTitle.shadowOffset = CGSizeZero;
    labelTitle.shadowBlur = 10.0f;
    labelTitle.innerShadowColor = [UIColor yellowColor];
    labelTitle.innerShadowOffset = CGSizeMake(1.0f, 2.0f);
    labelTitle.gradientStartColor = [UIColor yellowColor];
    labelTitle.gradientEndColor = [UIColor yellowColor];
    labelTitle.gradientStartPoint = CGPointMake(0.0f, 0.5f);
    labelTitle.gradientEndPoint = CGPointMake(1.0f, 0.5f);
    labelTitle.oversampling = 2;
    UIFont *tfont = [UIFont fontWithName:@"迷你简启体" size:24];  
    labelTitle.font = tfont;
    [labelTest setTextColor:[UIColor colorWithRed:1.0 green:170.0/255 blue:58.0/255 alpha:1]];
    [labelDate setTextColor:[UIColor colorWithRed:1.0 green:170.0/255 blue:58.0/255 alpha:1]];
    
	// Do any additional setup after loading the view, typically from a nib.
    scratchViewController =[[ScrachViewController alloc] initWithNibName:@"ScratchViewClear" bundle:nil];
    [scratchViewController.view setFrame:viewScrachContainer.frame];
    scratchView = scratchViewController.view;

//    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
//    [engine setRootViewController:self];
//    [engine setDelegate:self];
//    [engine setRedirectURI:@"http://"];
//    [engine setIsUserExclusive:NO];
//    self.weiBoEngine = engine;
//    [engine release];

}

-(void)buttonShareClicked:(id)sender{
    UIGraphicsBeginImageContext(CGSizeMake(320, 320));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *currentScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    _socialData.shareImage = currentScreen;
//    _socialData.shareText = [NSString stringWithFormat:@"我今天的金句是:%@ #每日金句",labelTest.text];
//
//    _socialController = [[UMSocialControllerService alloc] initWithUMSocialData:_socialData];
//    
//    
//    UINavigationController *shareListController = [_socialController getSocialShareListController];
//    [self presentViewController:shareListController animated:YES completion:nil];
    
    @try {
        [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:[NSString stringWithFormat:@"我今天的金句是:%@ #每日金句",labelTest.text] shareImage:currentScreen shareToSnsNames:nil delegate:nil];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


-(void)updateMottoWithStr :(NSString *)str{
    if (segmentControl.selectedSegmentIndex==0) {
        [labelTest setText:[_convertor big5ToGb:str]];
    }else{
        [labelTest setText: [_convertor gbToBig5:str]];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:(@"yyyy-MM-dd")];
    NSMutableString *dateStr = [NSMutableString stringWithString: [formatter stringFromDate:date]];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:dateStr]) {
        [YouMiPointsManager rewardPoints:10];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"积分奖励" message:@"今日首次获取金句，奖励10点正能量" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
    
   [segmentControl setSelectedSegmentIndex:[[[NSUserDefaults standardUserDefaults] valueForKey:@"simpleOrTrandition"] intValue]];
    [self updateMottoWithStr: [self getFirstMotto]];

    labelTest.font = [UIFont fontWithName:@"KaiTi_GB2312" size:27];
    [labelTest adjustsFontSizeToFitWidth];
    [labelTest setNeedsDisplay];
    

    labelDate.font =  [UIFont fontWithName:@"KaiTi_GB2312" size:18];
    [labelDate setText:dateStr];
    [super viewWillAppear:animated];
    [self updateFrameStyle];
}

-(void)updateFrameStyle{
    int index = [[[NSUserDefaults standardUserDefaults] valueForKey:kFrameIndex] intValue];
    [_frameView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"frame_%03d",index]]];
}

-(NSString *)getFirstMotto{
    
    SCAppDelegate *delegate = (SCAppDelegate *)[[UIApplication sharedApplication] delegate];
    FMDatabase *db = [FMDatabase databaseWithPath:[delegate dbPath]];
    db.logsErrors = YES;
    if (![db open]) {
        return @"今天你不再需要金句了。";
    }
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:(@"yyyy-MM-dd")];
    NSMutableString *ds = [NSMutableString stringWithString: [formatter stringFromDate:date]];
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:ds]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:ds];
    }
    
    NSString *tmpStr = [NSString stringWithFormat:@"SELECT \"my_motto_dailies\".* FROM \"my_motto_dailies\" WHERE DATE(created_at)= '%@'",ds]; 
    FMResultSet *s_today = [db executeQuery: tmpStr];
    if ([s_today next]) {
        //今日已经抽取
        NSString * result = [s_today stringForColumn:@"motto"];
        [db close];
        
        //显示今日刮刮卡上次刮完的样子
        [scratchViewController loadScratchPaperWithPath:@"scratch_it"];
        [scratchView setFrame:viewScrachContainer.frame];
        [self.view insertSubview:scratchView belowSubview:self.frameView];

        return result;
    }
    
    FMResultSet *s = [db executeQuery:@"SELECT * FROM 'mottos' order by random() limit 1"];
    if ([s next]) {
        NSDate * date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:(@"yyyy-MM-dd HH:mm:ss")];
        NSMutableString *dateStr = [NSMutableString stringWithString: [formatter stringFromDate:date]];
        
        NSString * result = [s stringForColumn:@"content"];
//        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO \"my_motto_dailies\" (\"created_at\", \"day\", \"motto\", \"updated_at\") VALUES (DATETIME('now'), DATETIME('now'), \"%@\", DATETIME('now'))",result]];
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO \"my_motto_dailies\" (\"created_at\", \"day\", \"motto\", \"updated_at\") VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",dateStr,dateStr,result,dateStr]];
        [db close];
        [scratchView setFrame:viewScrachContainer.frame];
        [scratchViewController setImageNamed:@"cover.002.png"];
        [self.view insertSubview:scratchView belowSubview:self.frameView];
        return result;
    }
    
    [db close];
    return @"今天你不再需要金句了。";
}

- (void)clearTodaysMotto{
    SCAppDelegate *delegate = (SCAppDelegate *)[[UIApplication sharedApplication] delegate];
    FMDatabase *db = [FMDatabase databaseWithPath:[delegate dbPath]];
    db.logsErrors = YES;
    if (![db open]) {
        [self showAlert:@"出错啦" withTitle:@"对不起"];
    }
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:(@"yyyy-MM-dd")];
    NSMutableString *ds = [NSMutableString stringWithString: [formatter stringFromDate:date]];
    
    NSString *tmpStr = [NSString stringWithFormat:@"DELETE FROM \"my_motto_dailies\" WHERE DATE(created_at)= '%@'",ds];
    
    [db executeUpdate: tmpStr];
    [db close];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-(void)mailClicked{
//    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
//    controller.mailComposeDelegate = self;
//    [controller setSubject:@"每日金句"];
//    
//    NSArray *bccRecipients = [NSArray arrayWithObject:@"wupeng_ios@foxmail.com"]; 
//    [controller setBccRecipients:bccRecipients];
//    
//    CGSize a= CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-100);
//    UIGraphicsBeginImageContext(a);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *currentScreen = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    
//    NSData *imageData = UIImagePNGRepresentation(currentScreen);
//    [controller addAttachmentData:imageData mimeType:@"image/png" fileName:@"motto_today.png"];
//    
//    
//    [controller setMessageBody:@"今天我的金句是：" isHTML:YES];
//    
//    [self presentModalViewController:controller animated:YES];
//    
//    [controller release];
//}
//- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
//    if (result == MFMailComposeResultSent) {
//        [self showAlert:@"邮件已进入后台发送" withTitle:@"提醒"];
//    }
//    [self dismissModalViewControllerAnimated:YES];
//}
//
//-(void)saveClicked{
//    CGSize a= CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-100);
//    UIGraphicsBeginImageContext(a);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *currentScreen = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    UIImageWriteToSavedPhotosAlbum(currentScreen, self,nil,nil);
//    [self showAlert:@"已保存到相册" withTitle:@"已保存"];
//
//}
//-(void)weiboClicked{
//    if ([self.weiBoEngine isLoggedIn] && ![self.weiBoEngine isAuthorizeExpired]){
//        NSLog(@"a");
//        [self performSelector:@selector(onAuthedAndPrepareToSend) withObject:nil afterDelay:0.0];
//    }else {
//        NSLog(@"b");
//        [weiBoEngine logIn];
//
//    }
//}
//
//- (void)onAuthedAndPrepareToSend
//{
//    CGSize a= CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-100);
//    UIGraphicsBeginImageContext(a);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *currentScreen = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    WBSendView *sendView = [[WBSendView alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret text:@"我今天的金句是：" image:currentScreen];
//    [sendView setDelegate:self];
//    
//    [sendView show:YES];
//    [sendView release];
//}
//
//#pragma mark - WBSendViewDelegate Methods
//
//- (void)sendViewDidFinishSending:(WBSendView *)view
//{
//    [view hide:YES];
//    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
//													   message:@"微博发送成功！" 
//													  delegate:nil
//											 cancelButtonTitle:@"确定" 
//											 otherButtonTitles:nil];
//	[alertView show];
//	[alertView release];
//}
//
//- (void)engineDidLogIn:(WBEngine *)engine
//{
//    [self performSelector:@selector(onAuthedAndPrepareToSend) withObject:nil afterDelay:0.0];
//}
//
//- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
//{
//    NSLog(@"didFailToLogInWithError: %@", error);
//    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
//													   message:@"登录失败！" 
//													  delegate:nil
//											 cancelButtonTitle:@"确定" 
//											 otherButtonTitles:nil];
//	[alertView show];
//	[alertView release];
//}
//
//
//- (void)sendView:(WBSendView *)view didFailWithError:(NSError *)error
//{
//    NSLog(@"didFailWithError: %@", error);
//    [view hide:YES];
//    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
//													   message:@"微博发送失败！" 
//													  delegate:nil
//											 cancelButtonTitle:@"确定" 
//											 otherButtonTitles:nil];
//	[alertView show];
//	[alertView release];
//}
//
//- (void)sendViewNotAuthorized:(WBSendView *)view
//{
//    [view hide:YES];
//    [self dismissModalViewControllerAnimated:YES];
//}
//
//- (void)sendViewAuthorizeExpired:(WBSendView *)view
//{
//    [view hide:YES];
//    [self dismissModalViewControllerAnimated:YES];
//}
//
//

-(void)showAlert:(NSString *)message withTitle:(NSString*)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(IBAction)segmentValueChanged:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:[segmentControl selectedSegmentIndex]] forKey:@"simpleOrTrandition"];
    if (segmentControl.selectedSegmentIndex==0) {
        [labelTest setText:[_convertor big5ToGb:[self getFirstMotto]]];
    }else{
        [labelTest setText: [_convertor gbToBig5:[self getFirstMotto]]];
    }
}

-(IBAction)buttonResetClicked:(id)sender{
    if ([YouMiPointsManager pointsRemained]>=10) {
        NSString *msg = [NSString stringWithFormat:@"更换金句需需要消耗10点正能量，\n您当前剩余积分：%d正能量\n是否确认继续？",[YouMiPointsManager pointsRemained]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"积分消耗" message:msg delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"确认", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"积分不够" message:@"更换金句需要消耗10点正能量,您当前正能量点数不足。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [YouMiSpot showSpotDismiss:^{
            if ([YouMiPointsManager pointsRemained]>=10) {
                [YouMiPointsManager spendPoints:10];
                [self clearTodaysMotto];
                [self updateMottoWithStr:[self getFirstMotto]];
            }
        }];
    }
    if ([YouMiPointsManager pointsRemained]<10 &&buttonIndex==0) {
        [YouMiSpot showSpotDismiss:^{
        }];
    }
}

#pragma mark - UMSocialUIDelegate
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didCloseUIViewController with type is %d",fromViewControllerType);
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController is %@",response);
}

@end
