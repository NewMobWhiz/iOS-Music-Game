//
//  MGStage3ViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/22/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGStage3ViewController.h"
#import "MGSettingViewController.h"

@interface MGStage3ViewController ()

@end

@implementation MGStage3ViewController

@synthesize gameSpeed, gameSpeed1;
@synthesize currentLevel;
@synthesize gamePointCount;

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
    mPauseButton.hidden = YES;
    mPianoPointImage.hidden = YES;    
    
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
    
}

- (IBAction)onBottomButtonPressed:(id)sender
{
    UIButton* button = (UIButton*) sender;
    int tag = (int)button.tag;
    currentCount += 1;
    NSLog(@"%d:%d", mCurrentValueForPiano, tag);
    if (currentCount == gamePointCount)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", currentLevel + 1] forKey:@"CompletedLevelForStage3"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [gamePlayTimer invalidate];
        gamePlayTimer = nil;
        
        int current_hight_score = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Stage3HighScore"];
        if (current_hight_score < totalScore )
        {
            current_hight_score = totalScore;
            [[NSUserDefaults standardUserDefaults] setInteger:current_hight_score forKey:@"Stage1HighScore"];
        }
        MGLevelUpPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelUpPanel" owner:self options:nil] objectAtIndex:0];
        [panel setupViewWithScore:totalScore StarCount:3 - wrongCount HighScore:current_hight_score];
        
//        MGLevelUpPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelUpPanel" owner:self options:nil] objectAtIndex:0];
//        [panel setupViewWithScore:totalScore StarCount:3 - wrongCount];
        panel.center = self.view.center;
        panel.delegate = self;
        [self.view addSubview:panel];
        return;
    }
    [gamePlayTimer invalidate];
    gamePlayTimer = nil;
    gamePlayTimer = [NSTimer scheduledTimerWithTimeInterval: gameSpeed target:self selector:@selector(PlayBoardAnimationForTimer) userInfo:nil repeats:YES];
    if (mCurrentValueForPiano == tag)
    {
        correctCount += 1;
        [mCorrectLabel setText:[NSString stringWithFormat:@"Correct: %d", correctCount]];
        
        NSString * audio_name = [[NSBundle mainBundle] pathForResource: @"success" ofType:@"wav" inDirectory: @"Sound"];
        mSuccessPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
        mSuccessPlayer.currentTime = 0;
        mSuccessPlayer.volume = volumnValue;
        [mSuccessPlayer stop];
        [mSuccessPlayer play];
        
        totalScore += 15;
        [mScoreLabel setText:[NSString stringWithFormat:@"Score: %d", totalScore]];
    }
    else
    {
        wrongCount += 1;
        [mWrongLabel setText:[NSString stringWithFormat:@"Wrong: %d", wrongCount]];
        
        NSString *audio_name = [[NSBundle mainBundle] pathForResource: @"fail" ofType:@"wav" inDirectory: @"Sound"];
        mFailedPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
        mFailedPlayer.currentTime = 0;
        mFailedPlayer.volume = volumnValue;
        [mFailedPlayer stop];
        [mFailedPlayer play];
        
        totalScore -= 10;
        [mScoreLabel setText:[NSString stringWithFormat:@"Score: %d", totalScore]];
        if (wrongCount == 3)
        {
            [gamePlayTimer invalidate];
            gamePlayTimer = nil;
            
            MGLevelFailedPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelFailedPanel" owner:self options:nil] objectAtIndex:0];
            panel.center = self.view.center;
            panel.delegate = self;
            [self.view addSubview:panel];
        }
    }
    [self PlayBoardAnimation];
}

- (IBAction)onPlayButtonPressed:(id)sender
{
    [self PlayBoardAnimation];
    gamePlayTimer = [NSTimer scheduledTimerWithTimeInterval: gameSpeed target:self selector:@selector(PlayBoardAnimationForTimer) userInfo:nil repeats:YES];
    mPlayButton.hidden = YES;
    mBackButton.hidden = YES;
    mPauseButton.hidden = NO;
    mPianoPointImage.hidden = NO;
}

- (IBAction)onPauseButtonPressed:(id)sender
{
    [gamePlayTimer invalidate];
    gamePlayTimer = nil;
    mPlayButton.hidden = NO;
    mBackButton.hidden = NO;
    mPauseButton.hidden = YES;
    mPianoPointImage.hidden = YES;
}

- (IBAction)onSettingButtonPressed:(id)sender
{
    [self onPauseButtonPressed:nil];
    MGSettingViewController* settingViewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGSettingViewController"];
    [self.navigationController pushViewController:settingViewCon animated:YES];
}

- (IBAction)onFacebookButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FaceBookPost" object:nil];
}

- (IBAction)onTwitterButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TwitterPost" object:nil];
}

- (IBAction)onBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)PlayBoardAnimationForTimer
{
    wrongCount += 1;
    [mWrongLabel setText:[NSString stringWithFormat:@"Wrong: %d", wrongCount]];
    
    NSString * audio_name = [[NSBundle mainBundle] pathForResource: @"success" ofType:@"wav" inDirectory: @"Sound"];
    mSuccessPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
    mSuccessPlayer.currentTime = 0;
    mSuccessPlayer.volume = volumnValue;
    [mSuccessPlayer stop];
    [mSuccessPlayer play];
    
    if (wrongCount == 3)
    {
        [gamePlayTimer invalidate];
        gamePlayTimer = nil;
        
        MGLevelFailedPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelFailedPanel" owner:self options:nil] objectAtIndex:0];
        panel.center = self.view.center;
        panel.delegate = self;
        [self.view addSubview:panel];
        return;
    }
    [self PlayBoardAnimation];
    
}

- (void)PlayBoardAnimation
{
    mCurrentValueForPiano = arc4random() % 12 + 1;
    [self showPointWith:mCurrentValueForPiano];
}

- (void) showPointWith: (int) value
{
    if (value < 8)
    {
        mPianoPointImage.frame = CGRectMake(86 + (value - 1) * 25, 54, 28, 29);
    }
    else if (value < 10)
    {
        mPianoPointImage.frame = CGRectMake(99 + (value - 8) * 25, 36, 28, 29);
    }
    else
    {
        mPianoPointImage.frame = CGRectMake(171 + (value - 10) * 25, 36, 28, 29);
    }
}
- (void)onFailedPanelMenuButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onFailedPanelOkButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSucessPanelOkButtonPressed
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"show_Ads"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
