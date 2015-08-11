//
//  MGBalloonViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/24/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MGBalloonPlayBoard.h"
#import "MGLevelFailedPanel.h"
#import "MGLevelUpPanel.h"

@interface MGBalloonViewController : UIViewController < MGBalloonPlayBoardDelegate , MGLevelFiledPanelDelegate, MGLevelUpPanelDelegate>
{
    int mCurrentTask;
    int mCorrectCount;
    int mWrongCount;
    int mCurrentScore;
    IBOutlet UILabel* mTaskLabel;
    IBOutlet UILabel* mCorrectLabel;
    IBOutlet UILabel* mWrongLabel;
    IBOutlet UILabel* mScoreLabel;
    IBOutlet UIButton* mPlayButton;
    IBOutlet UIButton* mPauseButton;
    IBOutlet UIButton* mBackButton;
    
    IBOutlet UIView* mPlayView;
    MGBalloonPlayBoard* panel;
    
    AVAudioPlayer* mSuccessPlayer;
    AVAudioPlayer* mFailedPlayer;
    float volumnValue;
}

- (IBAction)onSettingButton:(id)sender;
- (IBAction)onFacebookButton:(id)sender;
- (IBAction)onTwitterButton:(id)sender;
- (IBAction)onBackButton:(id)sender;

- (IBAction)onPlayButton:(id)sender;
- (IBAction)onPauseButton:(id)sender;
@end
