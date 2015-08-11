//
//  MGStageSelectViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGStageSelectViewController.h"
#import "MGSettingViewController.h"
#import "MGEarTrainningViewController.h"
#import "MGBalloonViewController.h"


@interface MGStageSelectViewController ()

@end

@implementation MGStageSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"show_Ads"];
    
    mStage2Button.enabled = YES;//NO;
    mStage3Button.enabled = YES;//NO;
    mStage2Button.alpha = 1.0;
    mStage3Button.alpha = 1.0;
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"buy_stage"] isEqualToString:@"buy"]) {
        mStage2Button.alpha = 0.5;
        mStage3Button.alpha = 0.5;
    }
    currentStage = 1;

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage2"]) {
//        mStage2Button.enabled = YES;
        currentStage = 2;
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage3"]) {
//        mStage3Button.enabled = YES;
        currentStage = 3;
    }
    
    adBanner.delegate = self;
    adBanner.frame = CGRectMake(0, self.view.bounds.size.height - 32, self.view.bounds.size.width, 32);
    
    [[IMOBIAPHelper sharedInstance]requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if(products && products.count>0){
            myProduct = products[0];
        }
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayBackgroundMusic" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}
- (void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)productPurchased:(NSNotification *)notification{
    NSString *productIdentifier = notification.object;
    NSLog(@"kkkkk-Identifier: %@", productIdentifier);
    [[NSUserDefaults standardUserDefaults] setValue:@"buy" forKey:@"buy_stage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    mStage2Button.alpha = 1.0;
    mStage3Button.alpha = 1.0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onPrevButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onNextButton:(id)sender
{
    MGLevelSelectViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGLevelSelectViewController"];
    viewCon.currentStage = currentStage;
    [self.navigationController pushViewController:viewCon animated:YES];
    
}

- (IBAction)onPlayButton:(id)sender
{
    MGLevelSelectViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGLevelSelectViewController"];
    viewCon.currentStage = currentStage;
    [self.navigationController pushViewController:viewCon animated:YES];
}

- (IBAction)onSettingButton:(id)sender
{
    MGSettingViewController* settingViewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGSettingViewController"];
    [self.navigationController pushViewController:settingViewCon animated:YES];
}

- (IBAction)onFacebookButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FaceBookPost" object:nil];
}

- (IBAction)onTwitterButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TwitterPost" object:nil];
}

- (IBAction)onEarTrainingButton:(id)sender
{
    MGEarTrainningViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MGEarTrainningViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onPopBalloonButton:(id)sender
{
    MGBalloonViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MGBalloonViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onStage1Button:(id)sender
{
    MGLevelSelectViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGLevelSelectViewController"];
    viewCon.currentStage = 1;
    [self.navigationController pushViewController:viewCon animated:YES];
}

- (IBAction)onStage2Button:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"buy_stage"] isEqualToString:@"buy"]) {
        MGLevelSelectViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGLevelSelectViewController"];
        viewCon.currentStage = 2;
        [self.navigationController pushViewController:viewCon animated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Do you want to buy stage2,3 by $0.99?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Purchase", @"Restore", nil];
        [alertView show];
    }
}

- (IBAction)onStage3Button:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"buy_stage"] isEqualToString:@"buy"]) {
        MGLevelSelectViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGLevelSelectViewController"];
        viewCon.currentStage = 3;
        [self.navigationController pushViewController:viewCon animated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Do you want to buy stage2,3 by $0.99?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Purchase", @"Restore", nil];
        [alertView show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[IMOBIAPHelper sharedInstance]buyProduct:myProduct];
    } else if(buttonIndex == 2){
        [[IMOBIAPHelper sharedInstance] restoreCompletedTransactions];
    }else{
        
    }
}
#pragma mark ADBannerViewDelegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    banner.frame = CGRectMake(0, self.view.bounds.size.height - 32, self.view.bounds.size.width, 32);
    [UIView animateWithDuration:0.5 animations:^{ adBanner.alpha = 1.0;}];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView animateWithDuration:0.5 animations:^{ adBanner.alpha = 0.0;}];
}

@end
