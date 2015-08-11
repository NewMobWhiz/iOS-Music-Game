//
//  MGEarTrainningViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/23/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MGEarTrainningViewController : UIViewController
{
    int mCurrentValue;
    int mCurrentScore;
    int mCorrectCount;
    int mWrongCount;
    BOOL isFirstLoadig;
    
    IBOutlet UILabel* mCorrectLabel;
    IBOutlet UILabel* mWrongLabel;
    IBOutlet UILabel* mScoreLabel;
    IBOutlet UIImageView* mSoundRect;
    IBOutlet UIImageView* mArrow;
    
    AVAudioPlayer* mSuccessPlayer;
    AVAudioPlayer* mFailedPlayer;
    AVAudioPlayer* mSoundPlayer;
}
- (IBAction)onBackButton:(id)sender;
- (IBAction)onSettingButton:(id)sender;
- (IBAction)onTwitterButton:(id)sender;
- (IBAction)onFacebookButton:(id)sender;

- (IBAction)onSoundButton:(id)sender;
- (IBAction)onMusicButton:(id)sender;
@end
