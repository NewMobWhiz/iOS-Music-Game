//
//  MGLevelSelectViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGLevelSelectViewController.h"
#import "MGSettingViewController.h"
#import "MGPlayViewController.h"
#import "MGStage2PlayViewController.h"
#import "MGStage3ViewController.h"

@interface MGLevelSelectViewController (){
    
}

@end

@implementation MGLevelSelectViewController

@synthesize currentStage;

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
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    int currentCompletedLevel = 1;
    
    if (currentStage == 1)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage1"])
            currentCompletedLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage1"] intValue];
    }
    if (currentStage == 2)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage2"])
            currentCompletedLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage2"] intValue];
    }
    if (currentStage == 3)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage3"])
            currentCompletedLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage3"] intValue];
    }
    
    mLevel10Button.enabled = YES;
    mLevel9Button.enabled = YES;
    mLevel8Button.enabled = YES;
    mLevel7Button.enabled = YES;
    mLevel6Button.enabled = YES;
    mLevel5Button.enabled = YES;
    mLevel4Button.enabled = YES;
    mLevel3Button.enabled = YES;
    mLevel2Button.enabled = YES;
    mLevel1Button.enabled = YES;
    
    if (currentCompletedLevel < 10)
        mLevel10Button.enabled = NO;
    if (currentCompletedLevel < 9)
        mLevel9Button.enabled = NO;
    if (currentCompletedLevel < 8)
        mLevel8Button.enabled = NO;
    if (currentCompletedLevel < 7)
        mLevel7Button.enabled = NO;
    if (currentCompletedLevel < 6)
        mLevel6Button.enabled = NO;
    if (currentCompletedLevel < 5)
        mLevel5Button.enabled = NO;
    if (currentCompletedLevel < 4)
        mLevel4Button.enabled = NO;
    if (currentCompletedLevel < 3)
        mLevel3Button.enabled = NO;
    if (currentCompletedLevel < 2)
        mLevel2Button.enabled = NO;
    
    //introduction other apps
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"show_Ads"]boolValue] ==YES) {
        [self showAds];
    }
}
-(void)showAds{
    NSLog(@"showAds");
    rand_app_num  = arc4random() % 2 + 1;
    int rand_img_num  = arc4random() % 4 + 1;
    
    float img_widht = 480;
    float img_height = 320;
    float screen_width = self.view.bounds.size.width;
    float screen_height = self.view.bounds.size.height;
    NSString *filename = [NSString stringWithFormat:@"intro%d_%d",rand_app_num, rand_img_num];
    appImage = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width - img_widht)/2, screen_height, img_widht, img_height)];
    [appImage setImage:[UIImage imageNamed:filename]];
    [appImage setUserInteractionEnabled:YES];
    [self.view addSubview:appImage];
    
    appImage.layer.cornerRadius = 12.0f;
    appImage.layer.masksToBounds = YES;
    appImage.layer.borderColor = [[UIColor redColor]CGColor];
    appImage.layer.borderWidth = 12.0f;
    
    goStoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goStoreBtn setFrame:CGRectMake(0, 0, img_widht, img_height)];
    goStoreBtn.backgroundColor = [UIColor clearColor];
    [goStoreBtn addTarget:self action:@selector(pressImg) forControlEvents:UIControlEventTouchUpInside];
    [appImage addSubview:goStoreBtn];
    
    returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"setting_return_button.png"] forState:UIControlStateNormal];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"setting_return_button.png"] forState:UIControlStateHighlighted];
    [returnBtn setFrame:CGRectMake(img_widht - 60, img_height - 60, 48, 48)];
    returnBtn.backgroundColor = [UIColor clearColor];
    [returnBtn addTarget:self action:@selector(pressReturnBtn) forControlEvents:UIControlEventTouchUpInside];
    [appImage addSubview:returnBtn];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    appImage.frame = CGRectMake((screen_width - img_widht)/2, (screen_height - img_height)/2, img_widht, img_height);
    [UIView commitAnimations];
//    [self.view addSubview:appImage];
}
-(void)pressReturnBtn{
    NSLog(@"click_returnBtn");
    float img_widht = 480;
    float img_height = 320;
    float screen_width = self.view.bounds.size.width;
    float screen_height = self.view.bounds.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    appImage.frame = CGRectMake((screen_width - img_widht)/2, screen_height, img_widht, img_height);
    [UIView commitAnimations];
    [self.view addSubview:appImage];
}
-(void)pressImg{
    NSLog(@"pressImg");
    [self pressReturnBtn];
    
    NSString *urlAddress;
    if (rand_app_num == 1) {
        urlAddress = @"http://itunes.apple.com/us/app/musicflashcards-game/id935830784?mt=8";
    }else{
        urlAddress = @"http://itunes.apple.com/us/app/worry-box/id933266001?mt=8";
    }
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlAddress]];
}
////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onPrevButton:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"show_Ads"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPlayButton:(id)sender
{
    int currentCompletedLevel = 1;
    if (currentStage == 1)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage1"])
            currentCompletedLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage1"] intValue];
        [self setLevelAndGotoPlayForStage1:currentCompletedLevel];
    }
    if (currentStage == 2)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage2"])
            currentCompletedLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage2"] intValue];
        [self setLevelAndGotoPlayForStage2:currentCompletedLevel];
    }
    if (currentStage == 3)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage3"])
            currentCompletedLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedLevelForStage3"] intValue];
        [self setLevelAndGotoPlayForStage3:currentCompletedLevel];
    }
    
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

- (IBAction)onLevelSelect:(id)sender
{
    UIButton* button = (UIButton*) sender;
    int tag = (int)button.tag;
    
    if (currentStage == 1)
        [self setLevelAndGotoPlayForStage1:tag];
    else if (currentStage == 2)
        [self setLevelAndGotoPlayForStage2:tag];
    else if (currentStage == 3)
        [self setLevelAndGotoPlayForStage3:tag];
}

- (void) setLevelAndGotoPlayForStage1 : (int) tag
{
    int gameSpeed = 10;
    int gameTime = 60;
    int level = 1;
    NSArray* taskArray;
    switch (tag) {
        case 1:
        {
            int rnd = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd]];
            gameSpeed = 30;
            gameTime = 60;
            level = 1;
        }
            break;
        case 2:
        {
            int rnd = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd]];
            gameSpeed = 40;
            gameTime = 60;
            level = 2;
        }
            break;
        case 3:
        {
            int rnd = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd]];
            gameSpeed = 60;
            gameTime = 60;
            level = 3;
        }
            break;
        case 4:
        {
            int rnd = arc4random() % 7 + 1;
            int rnd1 = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd], [NSNumber numberWithInt:rnd1]];
            gameSpeed = 60;
            gameTime = 60;
            level = 4;
        }
            break;
        case 5:
        {
            int rnd = arc4random() % 7 + 1;
            int rnd1 = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd], [NSNumber numberWithInt:rnd1]];
            gameSpeed = 70;
            gameTime = 60;
            level = 5;
        }
            break;
        case 6:
        {
            int rnd = arc4random() % 7 + 1;
            int rnd1 = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd], [NSNumber numberWithInt:rnd1]];
            gameSpeed = 80;
            gameTime = 60;
            level = 6;
        }
            break;
        case 7:
        {
            int rnd = arc4random() % 7 + 1;
            int rnd1 = arc4random() % 7 + 1;
            int rnd2 = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd], [NSNumber numberWithInt:rnd1], [NSNumber numberWithInt:rnd2]];
            gameSpeed = 80;
            gameTime = 60;
            level = 7;
        }
            break;
        case 8:
        {
            int rnd = arc4random() % 7 + 1;
            int rnd1 = arc4random() % 7 + 1;
            int rnd2 = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd], [NSNumber numberWithInt:rnd1], [NSNumber numberWithInt:rnd2]];
            gameSpeed = 90;
            gameTime = 60;
            level = 8;
        }
            break;
        case 9:
        {
            int rnd = arc4random() % 7 + 1;
            int rnd1 = arc4random() % 7 + 1;
            int rnd2 = arc4random() % 7 + 1;
            int rnd3 = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd], [NSNumber numberWithInt:rnd1], [NSNumber numberWithInt:rnd2], [NSNumber numberWithInt:rnd3]];
            gameSpeed = 100;
            gameTime = 60;
            level = 9;
        }
            break;
        case 10:
        {
            int rnd = arc4random() % 7 + 1;
            int rnd1 = arc4random() % 7 + 1;
            int rnd2 = arc4random() % 7 + 1;
            int rnd3 = arc4random() % 7 + 1;
            taskArray = @[[NSNumber numberWithInt:rnd], [NSNumber numberWithInt:rnd1], [NSNumber numberWithInt:rnd2], [NSNumber numberWithInt:rnd3]];
            gameSpeed = 100;
            gameTime = 60;
            level = 10;
        }
            break;
            
        default:
            break;
    }
    
    
    MGPlayViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGPlayViewController"];
    viewCon.gameTime = gameTime;
    viewCon.gameSpeed = gameSpeed;
    viewCon.taskArray = taskArray;
    viewCon.currentLevel = level;
    [self.navigationController pushViewController:viewCon animated:YES];
}

- (void) setLevelAndGotoPlayForStage2 : (int) tag
{
    int gameSpeed = 10;
    int gameMarkCount = 10;
    int level = 1;
    switch (tag) {
        case 1:
        {
            gameSpeed = 20;
            gameMarkCount = 10;
            level = 1;
        }
            break;
        case 2:
        {
            gameSpeed = 30;
            gameMarkCount = 15;
            level = 2;
        }
            break;
        case 3:
        {
            gameSpeed = 40;
            gameMarkCount = 20;
            level = 3;
        }
            break;
        case 4:
        {
            gameSpeed = 40;
            gameMarkCount = 25;
            level = 4;
        }
            break;
        case 5:
        {
            gameSpeed = 50;
            gameMarkCount = 30;
            level = 5;
        }
            break;
        case 6:
        {
            gameSpeed = 60;
            gameMarkCount = 35;
            level = 6;
        }
            break;
        case 7:
        {
            gameSpeed = 60;
            gameMarkCount = 40;
            level = 7;
        }
            break;
        case 8:
        {
            gameSpeed = 70;
            gameMarkCount = 45;
            level = 8;
        }
            break;
        case 9:
        {
            gameSpeed = 80;
            gameMarkCount = 50;
            level = 9;
        }
            break;
        case 10:
        {
            gameSpeed = 90;
            gameMarkCount = 55;
            level = 10;
        }
            break;
            
        default:
            break;
    }
    
    
    MGStage2PlayViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGStage2PlayViewController"];
    viewCon.gameMarkCount = gameMarkCount;
    viewCon.gameSpeed = gameSpeed;
    viewCon.currentLevel = level;
    [self.navigationController pushViewController:viewCon animated:YES];
}

- (void) setLevelAndGotoPlayForStage3 : (int) tag
{
    int gameSpeed = 3;
    int gameMarkCount = 10;
    int level = 1;
    switch (tag) {
        case 1:
        {
            gameSpeed = 7;
            gameMarkCount = 10;
            level = 1;
        }
            break;
        case 2:
        {
            gameSpeed = 5.5;
            gameMarkCount = 15;
            level = 2;
        }
            break;
        case 3:
        {
            gameSpeed = 5;
            gameMarkCount = 20;
            level = 3;
        }
            break;
        case 4:
        {
            gameSpeed = 4.5;
            gameMarkCount = 25;
            level = 4;
        }
            break;
        case 5:
        {
            gameSpeed = 4;
            gameMarkCount = 30;
            level = 5;
        }
            break;
        case 6:
        {
            gameSpeed = 3.5;
            gameMarkCount = 35;
            level = 6;
        }
            break;
        case 7:
        {
            gameSpeed = 3;
            gameMarkCount = 40;
            level = 7;
        }
            break;
        case 8:
        {
            gameSpeed = 2.5;
            gameMarkCount = 45;
            level = 8;
        }
            break;
        case 9:
        {
            gameSpeed = 2;
            gameMarkCount = 50;
            level = 9;
        }
            break;
        case 10:
        {
            gameSpeed = 1.5;
            gameMarkCount = 55;
            level = 10;
        }
            break;
            
        default:
            break;
    }
    
    
    MGStage3ViewController* viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MGStage3ViewController"];
    viewCon.gamePointCount = gameMarkCount;
    viewCon.gameSpeed = gameSpeed;
    viewCon.currentLevel = level;
    [self.navigationController pushViewController:viewCon animated:YES];
}


@end
