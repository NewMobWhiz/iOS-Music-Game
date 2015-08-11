//
//  MGBalloonViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/24/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGBalloonViewController.h"
#import "MGSettingViewController.h"

@interface MGBalloonViewController ()

@end

@implementation MGBalloonViewController

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
    panel = [[[NSBundle mainBundle] loadNibNamed:@"BalloonPlayBoard" owner:self options:nil] objectAtIndex:0];
    panel.center = CGPointMake(mPlayView.frame.size.width / 2, mPlayView.frame.size.height / 2);
    panel.delegate = self;
    
    float speedRate = [[[NSUserDefaults standardUserDefaults] objectForKey:@"speedValue"]floatValue] * 2;
    panel.gameSpeed = 20 * speedRate;
    panel.balloonCount = 30;
    [panel setupBalloons];
    
    [mPlayView addSubview:panel];
    [mPlayView sendSubviewToBack:panel];
    
    mCurrentTask = arc4random() % 7 + 1;
    mTaskLabel.text = [NSString stringWithFormat:@"Collect Every: %@", [self intToStringForTask:mCurrentTask]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    volumnValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"volumeValue"]floatValue];
//    float changedSpeed = [[[NSUserDefaults standardUserDefaults] objectForKey:@"speedValue"]floatValue] * 2;
//    int newSpeed = (int)(panel.gameSpeed - changedSpeed);
//    if (newSpeed != 0) {
//         [panel resetBalloons:newSpeed];
//    }   
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

- (IBAction)onBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPlayButton:(id)sender
{
    [panel play];
    mPlayButton.hidden = YES;
    mPauseButton.hidden = NO;
    mBackButton.hidden = YES;
}

- (IBAction)onPauseButton:(id)sender
{
    [panel pause];
    mPlayButton.hidden = NO;
    mPauseButton.hidden = YES;
    mBackButton.hidden = NO;
}

- (void)onBalloonPressed:(int)value
{
    NSLog(@"value = %d", value);
    if (value == mCurrentTask) {
        mCorrectCount += 1;
        mCurrentScore += 15;
        
        NSString * audio_name = [[NSBundle mainBundle] pathForResource: @"success" ofType:@"wav" inDirectory: @"Sound"];
        mSuccessPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
        mSuccessPlayer.currentTime = 0;
        mSuccessPlayer.volume = volumnValue;
        [mSuccessPlayer stop];
        [mSuccessPlayer play];
    }
    else {
        mWrongCount += 1;
        mCurrentScore -= 10;
        
        NSString *audio_name = [[NSBundle mainBundle] pathForResource: @"fail" ofType:@"wav" inDirectory: @"Sound"];
        mFailedPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
        mFailedPlayer.currentTime = 0;
        mFailedPlayer.volume = volumnValue;
        [mFailedPlayer stop];
        [mFailedPlayer play];
    }
    
    [mCorrectLabel setText:[NSString stringWithFormat:@"Correct: %d", mCorrectCount]];
    [mWrongLabel setText:[NSString stringWithFormat:@"Wrong: %d", mWrongCount]];
    [mScoreLabel setText:[NSString stringWithFormat:@"Score: %d", mCurrentScore]];
}

- (void) balloonDisappeared:(int)value
{
//    if (value == mCurrentTask)
//    {
//        mWrongCount += 1;
//        mCurrentScore -= 10;
//        [mFailedPlayer stop];
//        [mFailedPlayer play];
//        [mWrongLabel setText:[NSString stringWithFormat:@"Wrong: %d", mWrongCount]];
//        [mScoreLabel setText:[NSString stringWithFormat:@"Score: %d", mCurrentScore]];
//    }
}
- (void)balloonPlayBoardEnded
{
    NSLog(@"Ended");
    [[NSUserDefaults standardUserDefaults] setValue:@"ballon" forKey:@"game_mode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    int starCount;
    if (mWrongCount >= 3){        //failed
        MGLevelFailedPanel* failedPanel = [[[NSBundle mainBundle] loadNibNamed:@"LevelFailedPanel" owner:self options:nil] objectAtIndex:0];
        failedPanel.center = self.view.center;
        failedPanel.delegate = self;
        [self.view addSubview:failedPanel];
        
    }else {
        if (mWrongCount == 0 && mCurrentScore >= 100) {
            //star3
            starCount = 3;
        }else if (mWrongCount == 0 && mCurrentScore >= 45 && mCurrentScore <100){
            //star2
            starCount = 2;
        }else{
            //star1
            starCount = 1;
        }
        int current_hight_score = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"ballonHighScore"];
        if (current_hight_score < mCurrentScore )
        {
            current_hight_score = mCurrentScore;
            [[NSUserDefaults standardUserDefaults] setInteger:current_hight_score forKey:@"ballonHighScore"];
        }
        MGLevelUpPanel* successPanel = [[[NSBundle mainBundle] loadNibNamed:@"LevelUpPanel" owner:self options:nil] objectAtIndex:0];
        [successPanel setupViewWithScore:mCurrentScore StarCount:starCount HighScore:current_hight_score];
        successPanel.center = self.view.center;
        successPanel.delegate = self;
        [self.view addSubview:successPanel];
    }
}

- (NSString*) intToStringForTask : (int) task
{
    switch (task) {
        case 1:
        {
            return @"C";
        }
            break;
        case 2:
        {
            return @"D";
        }
            break;
        case 3:
        {
            return @"E";
        }
            break;
        case 4:
        {
            return @"F";
        }
            break;
        case 5:
        {
            return @"G";
        }
            break;
        case 6:
        {
            return @"A";
        }
            break;
        case 7:
        {
            return @"B";
        }
            break;
        default:
            return @"C";
            break;
    }
}
////
#pragma mark - complete & Failed Panel Delegate

- (void)onSucessPanelOkButtonPressed2
{
    [[NSUserDefaults standardUserDefaults] setValue:@"normal" forKey:@"game_mode"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onFailedPanelMenuButtonPressed2
{
    [[NSUserDefaults standardUserDefaults] setValue:@"normal" forKey:@"game_mode"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onFailedPanelOkButtonPressed2
{
    [[NSUserDefaults standardUserDefaults] setValue:@"normal" forKey:@"game_mode"];
    [self viewDidLoad];
}
@end
