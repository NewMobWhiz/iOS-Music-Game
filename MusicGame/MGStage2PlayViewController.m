//
//  MGPlayViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGStage2PlayViewController.h"
#import "MGSettingViewController.h"
#import "MGStage2PlayCell.h"

@interface MGStage2PlayViewController ()

@end

@implementation MGStage2PlayViewController

@synthesize gameSpeed, gameSpeed1;
@synthesize gameMarkCount;
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
    hasToShowNotes = YES;
    // Do any additional setup after loading the view.
    mPauseButton.hidden = YES;
    mPlayBoard.hidden = YES;
    mCollectionDataSourceArray = [NSMutableArray array];
    for (int i = 0; i <=gameMarkCount; i ++)
    {
        int rand = arc4random() % 22 + 1;
        [mCollectionDataSourceArray addObject:[NSNumber numberWithInt:rand]];
    }
    
   
    [mPlayBoard setContentOffset:CGPointMake(-270, 0)];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    volumnValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"volumeValue"]floatValue];
    gameSpeed1 = gameSpeed * [[[NSUserDefaults standardUserDefaults] objectForKey:@"speedValue"]floatValue] * 2;
    NSLog(@"gameSpeed = %f", gameSpeed);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [mPlayBoardAnimationTimer invalidate];
    mPlayBoardAnimationTimer = nil;
}

- (IBAction)onPlayButton:(id)sender
{
    mPauseButton.hidden = NO;
    mPlayBoard.hidden = NO;
    mPlayButton.hidden = YES;
    mMusicContainerView.hidden = YES;
    mPrevButton.hidden = YES;
    
    
    
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

- (IBAction)onMusicButton:(id)sender
{
    UIButton* button = (UIButton*) sender;
    int tag = (int)button.tag;
    if ([self isCorrectMark:tag])
    {
        NSString * audio_name = [[NSBundle mainBundle] pathForResource: @"success" ofType:@"wav" inDirectory: @"Sound"];
        mSuccessPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
        mSuccessPlayer.currentTime = 0;
        mSuccessPlayer.volume = volumnValue;
        [mSuccessPlayer stop];
        [mSuccessPlayer play];
        
        MGStage2PlayCell* cell = (MGStage2PlayCell*) [mPlayBoard cellForItemAtIndexPath:mCurrentIndexPath];
        [cell SetCellValue:100];
        mCurrentLevelScore += 15;
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
        
        mCurrentLevelScore -= 15;
        [mScoreLabel setText:[NSString stringWithFormat:@"%04d", mCurrentLevelScore]];
        mMissedCount ++;
        if (mMissedCount == 3)
        {
            [mPlayBoardAnimationTimer invalidate];
            mPlayBoardAnimationTimer = nil;
            
            MGLevelFailedPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelFailedPanel" owner:self options:nil] objectAtIndex:0];
            panel.center = self.view.center;
            panel.delegate = self;
            [self.view addSubview:panel];
        }
    }
}

#pragma mark - Timer Selector

- (void) PlayBoardScrollingAnimation
{
    mCurrentTime ++;
    if (mCurrentTime / gameSpeed > 30 && currentLevel > 3) {
        hasToShowNotes = NO;
    }
    
    [mPlayBoard setContentOffset:CGPointMake(mPlayBoard.contentOffset.x + 1, 0) animated:NO];
    if (mPlayBoard.contentOffset.x > 54 * gameMarkCount + 270)
    {
        if (currentLevel == 10) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"CompletedLevelForStage2"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", currentLevel + 1] forKey:@"CompletedLevelForStage2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [mPlayBoardAnimationTimer invalidate];
        mPlayBoardAnimationTimer = nil;
        
        int current_hight_score = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Stage2HighScore"];
        if (current_hight_score < mCurrentLevelScore )
        {
            current_hight_score = mCurrentLevelScore;
            [[NSUserDefaults standardUserDefaults] setInteger:current_hight_score forKey:@"Stage2HighScore"];
        }
        MGLevelUpPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelUpPanel" owner:self options:nil] objectAtIndex:0];
        [panel setupViewWithScore:mCurrentLevelScore StarCount:3 - mMissedCount HighScore:current_hight_score];
        panel.center = self.view.center;
        panel.delegate = self;
        [self.view addSubview:panel];
        
    }
}

#pragma mark - UICollectionView DataSource & Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mCollectionDataSourceArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGStage2PlayCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGStage2PlayCell" forIndexPath:indexPath];
    if (currentLevel == 1)
        cell.hasToShowLabel = hasToShowNotes;
    else
        cell.hasToShowLabel = hasToShowNotes;
    [cell SetCellValue:[mCollectionDataSourceArray[indexPath.row] intValue]];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGStage2PlayCell* playCell = (MGStage2PlayCell*) cell;
    if (!playCell.isShowing)
        return;
    mMissedCount ++;
    mCurrentLevelScore -= 15;
    [mScoreLabel setText:[NSString stringWithFormat:@"%04d", mCurrentLevelScore]];
    if (mMissedCount == 3)
    {
        [mPlayBoardAnimationTimer invalidate];
        mPlayBoardAnimationTimer = nil;
        
        MGLevelFailedPanel* panel = [[[NSBundle mainBundle] loadNibNamed:@"LevelFailedPanel" owner:self options:nil] objectAtIndex:0];
        panel.center = self.view.center;
        panel.delegate = self;
        [self.view addSubview:panel];
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (BOOL) isCorrectMark : (int) tag
{
    NSMutableArray* array =[NSMutableArray arrayWithArray: mPlayBoard.indexPathsForVisibleItems];
    
    for ( int i = 0; i < array.count; i ++)
    {
        for ( int j = i + 1; j < array.count; j++)
        {
            NSIndexPath* index1 = array[i];
            NSIndexPath* index2 = array[j];
            if (index1.row > index2.row)
            {
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
    for ( int i = 0; i < array.count; i ++)
    {
        MGStage2PlayCell* cell = (MGStage2PlayCell*) [mPlayBoard cellForItemAtIndexPath:array[i]];
        if (!cell.isShowing)
            continue;
        NSIndexPath* indexPath = array[i];
        mCurrentIndexPath = indexPath;
        NSLog(@"%ld", (long)indexPath.row);
        int music_value = [mCollectionDataSourceArray[indexPath.row] intValue];
        if (music_value > 12) {
            music_value  = music_value - 12;
        }
        if (music_value == tag)
            return YES; 
        break;
        
//        NSIndexPath* ind = array[i];
//        NSLog(@"%d", ind.row);
    }
    return NO;
}

@end
