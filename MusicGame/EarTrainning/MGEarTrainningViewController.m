//
//  MGEarTrainningViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/23/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGEarTrainningViewController.h"
#import "MGSettingViewController.h"

@interface MGEarTrainningViewController ()

@end

@implementation MGEarTrainningViewController

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
    mCurrentValue = arc4random() % 7 + 1;
    
    NSString* audio_name = [[NSBundle mainBundle] pathForResource: @"success" ofType:@"wav" inDirectory: @"Sound"];
    mSuccessPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
    mSuccessPlayer.currentTime = 0;
    mSuccessPlayer.volume = 1.0;
    
    audio_name = [[NSBundle mainBundle] pathForResource: @"fail" ofType:@"wav" inDirectory: @"Sound"];
    mFailedPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
    mFailedPlayer.currentTime = 0;
    mFailedPlayer.volume = 1.0;
    
    mArrow.hidden = YES;
    mSoundRect.hidden = NO;
    isFirstLoadig = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PauseBackgroundMusic" object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayBackgroundMusic" object:nil];
}


- (IBAction)onBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)onSoundButton:(id)sender
{
    mSoundRect.hidden = YES;
    
    if (isFirstLoadig) {
        mArrow.hidden = NO;
    }
    
    NSString* audio_name = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%d", mCurrentValue] ofType:@"mp3" inDirectory: @"Sound/piano"];
    mSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
    mSoundPlayer.currentTime = 0;
    mSoundPlayer.volume = 1.0;

    [mSoundPlayer stop];
    [mSoundPlayer play];
}

- (IBAction)onMusicButton:(id)sender
{
    
    isFirstLoadig = NO;
    mArrow.hidden = YES;
    
    UIButton* button = (UIButton*)sender;
    int tag = (int)button.tag;
    
    NSString* audio_name = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%d", tag] ofType:@"mp3" inDirectory: @"Sound/piano"];
    mSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
    mSoundPlayer.currentTime = 0;
    mSoundPlayer.volume = 1.0;
    
    [mSoundPlayer stop];
    [mSoundPlayer play];

    if (mCurrentValue == tag) {
        mCorrectCount += 1;
        [mCorrectLabel setText:[NSString stringWithFormat:@"Correct: %d", mCorrectCount]];
    }
    else
    {
        mWrongCount += 1;
        [mWrongLabel setText:[NSString stringWithFormat:@"Wrong: %d", mWrongCount]];
    }
    
    mCurrentValue = arc4random() % 7 + 1;
    NSLog(@"%d", mCurrentValue);
}

@end
