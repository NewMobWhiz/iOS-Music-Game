//
//  MGStageSelectViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGLevelSelectViewController.h"
#import "iAd/ADBannerView.h"
#import "iAd/iAd.h"
#import "IMOBIAPHelper.h"
#import <StoreKit/StoreKit.h>

@interface MGStageSelectViewController : UIViewController<ADBannerViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, UIAlertViewDelegate>
{
    IBOutlet UIButton* mStage1Button;
    IBOutlet UIButton* mStage2Button;
    IBOutlet UIButton* mStage3Button;
    
    int currentStage;
    IBOutlet ADBannerView *adBanner;
    SKProduct *myProduct;
}

- (IBAction)onPrevButton:(id)sender;
- (IBAction)onNextButton:(id)sender;
- (IBAction)onPlayButton:(id)sender;
- (IBAction)onSettingButton:(id)sender;
- (IBAction)onFacebookButton:(id)sender;
- (IBAction)onTwitterButton:(id)sender;
- (IBAction)onEarTrainingButton:(id)sender;
- (IBAction)onPopBalloonButton:(id)sender;
- (IBAction)onStage1Button:(id)sender;
- (IBAction)onStage2Button:(id)sender;
- (IBAction)onStage3Button:(id)sender;

@end
