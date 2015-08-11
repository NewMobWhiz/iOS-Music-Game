//
//  MGPlayViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGPlayViewController.h"
#import "MGSettingViewController.h"
#import "MGPlayBoardCell.h"

@interface MGPlayViewController ()

@end

@implementation MGPlayViewController

@synthesize gameSpeed,gameSpeed1;
@synthesize gameTime;
@synthesize taskArray;
@synthesize currentLevel;

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
    hasToShowNotes = YES;
    mPauseButton.hidden = YES;
    mPlayBoard.hidden = YES;
    mCollectionDataSourceArray = [NSMutableArray array];
    for (int i = 0; i <=9999; i ++)
    {
        int r = arc4random() % 4;
        int rand = 1;
        if (r == 0) {
            int index = arc4random() % taskArray.count;////Anto_level1 to level2 error
            rand = [taskArray[index] intValue];
        }
        else {
            rand = arc4random() % 13 + 1;//
        }
        [mCollectionDataSourceArray addObject:[NSNumber numberWithInt:rand]];
    }
    mCurrentGameTime = gameTime;
    [mGameTimerLabel setText:[NSString stringWithFormat:@"%02d", gameTime]];

    NSString* taskString = @"For 60 seconds collect every: ";
    for (int i = 0; i < taskArray.count; i ++)
    {
        int task = [taskArray[i] intValue];
        taskString = [NSString stringWithFormat:@"%@%@, ",taskString, [self intToStringForTask:task]];
    }
    taskString = [taskString substringWithRange:NSMakeRange(0, taskString.length - 2)];
    [mTaskLabel setText:taskString];
    
//    SET AUDIOS
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    volumnValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"volumeValue"]floatValue];
    gameSpeed1 = gameSpeed * [[[NSUserDefaults standardUserDefaults] objectForKey:@"speedValue"]floatValue] * 2;
    NSLog(@"gameSpeed = %f", gameSpeed1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)onPrevButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPauseButton:(id)sender
{
    mPauseButton.hidden = YES;
    mPlayButton.hidden = NO;
    mPrevButton.hidden = NO;
    [mCountDownTimer invalidate];
    [mPlayBoardAnimationTimer invalidate];
    mCountDownTimer = nil;
    mPlayBoardAnimationTimer = nil;
}

- (IBAction)onPlayButton:(id)sender
{
    mPauseButton.hidden = NO;
    mPlayBoard.hidden = NO;
    mPlayButton.hidden = YES;
    mMusicContainerView.hidden = YES;
    mPrevButton.hidden = YES;
    mTaskLabel.hidden = YES;
    
    
    mCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountDownAnimation) userInfo:nil repeats:YES];
    mPlayBoardAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f / gameSpeed1 target:self selector:@selector(PlayBoardScrollingAnimation) userInfo:nil repeats:YES];
}

- (IBAction)onSettingButton:(id)sender
{
    [self onPauseButton:nil];
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

#pragma mark - Timer Selector

- (void) CountDownAnimation
{
    if (mCurrentGameTime == 0) // SUCCESSED
    {
        if (currentLevel == 10) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"CompletedLevelForStage2"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", currentLevel + 1] forKey:@"CompletedLevelForStage1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [mCountDownTimer invalidate];
        [mPlayBoardAnimationTimer invalidate];
        mCountDownTimer = nil;
        mPlayBoardAnimationTimer = nil;
        
        int current_hight_score = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Stage1HighScore"];
        if (current_hight_score < mCurrentLevelScore )
        {
            current_hight_score = mCurrentLevelScore;
            [[NSUserDefaults standardUserDefaults] setInteger:current_hight_score forKey:@"Stage1HighScore"];
        }
        MGLevelUpPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelUpPanel" owner:self options:nil] objectAtIndex:0];
        [panel setupViewWithScore:mCurrentLevelScore StarCount:3 - mMissedCount HighScore:current_hight_score];
        panel.center = self.view.center;
        panel.delegate = self;
        [self.view addSubview:panel];
        
        return;
    }
    mCurrentGameTime --;
    [mGameTimerLabel setText:[NSString stringWithFormat:@"%02d", mCurrentGameTime]];
    
}

- (void) PlayBoardScrollingAnimation
{
    mCurrentTime ++;
    if (mCurrentTime / gameSpeed > 30 && currentLevel > 3 ) {
        hasToShowNotes = NO;
    }
    [mPlayBoard setContentOffset:CGPointMake(mPlayBoard.contentOffset.x + 1, 0) animated:NO];
}

#pragma mark - UICollectionView DataSource & Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mCollectionDataSourceArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGPlayBoardCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGPlayBoardCell" forIndexPath:indexPath];
    if (currentLevel < 4)
        cell.hasToShowLabel = hasToShowNotes;
    else
        cell.hasToShowLabel = hasToShowNotes;
    [cell SetCellValue:[mCollectionDataSourceArray[indexPath.row] intValue]];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"End Display - Row: %ld Value: %d", (long)indexPath.row, [mCollectionDataSourceArray[indexPath.row] intValue]);

    MGPlayBoardCell* cell1 = (MGPlayBoardCell*) cell;
    
    if ( [self isValueInTask:[mCollectionDataSourceArray[indexPath.row] intValue]] && cell1.isShowing)
    {
        mMissedCount ++;
        if (mMissedCount == 3) // FAILED
        {
            [mCountDownTimer invalidate];
            [mPlayBoardAnimationTimer invalidate];
            mCountDownTimer = nil;
            mPlayBoardAnimationTimer = nil;
            
            MGLevelFailedPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelFailedPanel" owner:self options:nil] objectAtIndex:0];
            panel.center = self.view.center;
            panel.delegate = self;
            [self.view addSubview:panel];
        }
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did Select - Row: %ld Value: %d", (long)indexPath.row, [mCollectionDataSourceArray[indexPath.row] intValue]);
    MGPlayBoardCell* cell = (MGPlayBoardCell*) [collectionView cellForItemAtIndexPath:indexPath];

    if ( [self isValueInTask:[mCollectionDataSourceArray[indexPath.row] intValue]] && cell.isShowing)
    {
        [cell SetCellValue:100];
        NSString * audio_name = [[NSBundle mainBundle] pathForResource: @"success" ofType:@"wav" inDirectory: @"Sound"];
        mSuccessPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
        mSuccessPlayer.currentTime = 0;
        mSuccessPlayer.volume = volumnValue;
        [mSuccessPlayer stop];
        [mSuccessPlayer play];
        
        mCurrentLevelScore = mCurrentLevelScore + ( 5 + currentLevel * 5);
        [mScoreLabel setText:[NSString stringWithFormat:@"%04d", mCurrentLevelScore]];
    }
    else
    {
        NSString *audio_name = [[NSBundle mainBundle] pathForResource: @"fail" ofType:@"wav" inDirectory: @"Sound"];
        mFailedPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
        mFailedPlayer.currentTime = 0;
        mFailedPlayer.volume = volumnValue;
        [mFailedPlayer stop];
        [mFailedPlayer play];
        
        mCurrentLevelScore = mCurrentLevelScore - 15;
        [mScoreLabel setText:[NSString stringWithFormat:@"%04d", mCurrentLevelScore]];
        mMissedCount ++;
        if (mMissedCount == 3) // FAILED//////Faustino L3
        {
            [mCountDownTimer invalidate];
            [mPlayBoardAnimationTimer invalidate];
            mCountDownTimer = nil;
            mPlayBoardAnimationTimer = nil;
            
            MGLevelFailedPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelFailedPanel" owner:self options:nil] objectAtIndex:0];
            panel.center = self.view.center;
            panel.delegate = self;
            [self.view addSubview:panel];
            
        }
    }
}


- (BOOL) isValueInTask : (int) value
{
    if (value > 7) {
        value = value - 7;
    }
    for (int i = 0; i < taskArray.count; i ++)
    {
        if (value == [taskArray[i] intValue])
            return YES;
    }
    return NO;
}

#pragma mark - LevelUp & Failed Panel Delegate

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
