//
//  MGPlayViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MGLevelFailedPanel.h"
#import "MGLevelUpPanel.h"

@interface MGStage2PlayViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, MGLevelFiledPanelDelegate, MGLevelUpPanelDelegate>
{
    IBOutlet UIButton* mPauseButton;
    IBOutlet UIButton* mPlayButton;
    IBOutlet UIButton* mPrevButton;
    IBOutlet UIView* mMusicContainerView;
    IBOutlet UILabel* mScoreLabel;
    
    IBOutlet UICollectionView* mPlayBoard;
    
    NSMutableArray* mCollectionDataSourceArray;
    NSTimer* mPlayBoardAnimationTimer;
    int mCurrentLevelScore;
    int mMissedCount;
    
    AVAudioPlayer* mSuccessPlayer;
    AVAudioPlayer* mFailedPlayer;
    NSIndexPath* mCurrentIndexPath;
    
    BOOL hasToShowNotes;
    int mCurrentTime;
    float volumnValue;
}

@property (nonatomic) float gameSpeed;
@property (nonatomic) float gameSpeed1;
@property (nonatomic) int gameMarkCount;
@property (nonatomic) int currentLevel;

- (IBAction)onPrevButton:(id)sender;
- (IBAction)onPauseButton:(id)sender;
- (IBAction)onPlayButton:(id)sender;
- (IBAction)onSettingButton:(id)sender;
- (IBAction)onFacebookButton:(id)sender;
- (IBAction)onTwitterButton:(id)sender;

- (IBAction)onMusicButton:(id)sender;
@end
