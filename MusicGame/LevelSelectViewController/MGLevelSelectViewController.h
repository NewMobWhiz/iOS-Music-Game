//
//  MGLevelSelectViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGLevelSelectViewController : UIViewController
{
    IBOutlet UIButton* mLevel1Button;
    IBOutlet UIButton* mLevel2Button;
    IBOutlet UIButton* mLevel3Button;
    IBOutlet UIButton* mLevel4Button;
    IBOutlet UIButton* mLevel5Button;
    IBOutlet UIButton* mLevel6Button;
    IBOutlet UIButton* mLevel7Button;
    IBOutlet UIButton* mLevel8Button;
    IBOutlet UIButton* mLevel9Button;
    IBOutlet UIButton* mLevel10Button;
    
    UIImageView *appImage;
    UIButton *returnBtn;
    UIButton *goStoreBtn;
    int rand_app_num ;
}

- (IBAction)onPrevButton:(id)sender;
- (IBAction)onPlayButton:(id)sender;
- (IBAction)onSettingButton:(id)sender;
- (IBAction)onFacebookButton:(id)sender;
- (IBAction)onTwitterButton:(id)sender;
- (IBAction)onLevelSelect:(id)sender;

@property (nonatomic) int currentStage;
@end
