//
//  MGStage3ViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/22/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MGLevelFailedPanel.h"
#import "MGLevelUpPanel.h"

@interface MGStage3ViewController : UIViewController < MGLevelFiledPanelDelegate, MGLevelUpPanelDelegate >
{
    IBOutlet UIButton* mPlayButton;
    IBOutlet UIButton* mPauseButton;
    IBOutlet UIButton* mBackButton;
    
    IBOutlet UILabel* mCorrectLabel;
    IBOutlet UILabel* mWrongLabel;
    IBOutlet UILabel* mScoreLabel;
    
    IBOutlet UIView* mPianoView;
    IBOutlet UIImageView* mPianoPointImage;
    
    NSTimer* gamePlayTimer;
    int mCurrentValueForPiano;
    int correctCount;
    int wrongCount;
    int totalScore;
    int currentCount;
    
    AVAudioPlayer* mSuccessPlayer;
    AVAudioPlayer* mFailedPlayer;
    float volumnValue;
}

@property (nonatomic) int gameSpeed;
@property (nonatomic) int gameSpeed1;
@property (nonatomic) int currentLevel;
@property (nonatomic) int gamePointCount;

- (IBAction)onBottomButtonPressed:(id)sender;
//- (IBAction)onCButtonPressed:(id)sender;
//- (IBAction)onDButtonPressed:(id)sender;
//- (IBAction)onEButtonPressed:(id)sender;
//- (IBAction)onFButtonPressed:(id)sender;
//- (IBAction)onGButtonPressed:(id)sender;
//- (IBAction)onAButtonPressed:(id)sender;
//- (IBAction)onBButtonPressed:(id)sender;
//- (IBAction)onCSharpButtonPressed:(id)sender;
//- (IBAction)onDSharpButtonPressed:(id)sender;
//- (IBAction)onFSharpButtonPressed:(id)sender;
//- (IBAction)onGSharpButtonPressed:(id)sender;
//- (IBAction)onASharpButtonPressed:(id)sender;

- (IBAction)onPlayButtonPressed:(id)sender;
- (IBAction)onPauseButtonPressed:(id)sender;
- (IBAction)onSettingButtonPressed:(id)sender;
- (IBAction)onFacebookButtonPressed:(id)sender;
- (IBAction)onTwitterButtonPressed:(id)sender;
- (IBAction)onBackButtonPressed:(id)sender;

@end
