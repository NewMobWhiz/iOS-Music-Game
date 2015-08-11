//
//  MGSettingViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/5/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGSettingViewController.h"

@interface MGSettingViewController ()

@end

@implementation MGSettingViewController

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
    [mSoundSlider setMinimumValue:0];
    [mSoundSlider setMaximumValue:1];
    [mSoundSlider setMinimumTrackImage:[UIImage imageNamed:@"transparent_image"] forState:UIControlStateNormal];
    [mSoundSlider setMaximumTrackImage:[UIImage imageNamed:@"transparent_image"] forState:UIControlStateNormal];
    [mSoundSlider setThumbImage:[UIImage imageNamed:@"setting_slider_thumb"] forState:UIControlStateNormal];

    [mSpeedSlider setMinimumValue:0];
    [mSpeedSlider setMaximumValue:1];
    [mSpeedSlider setMinimumTrackImage:[UIImage imageNamed:@"transparent_image"] forState:UIControlStateNormal];
    [mSpeedSlider setMaximumTrackImage:[UIImage imageNamed:@"transparent_image"] forState:UIControlStateNormal];
    [mSpeedSlider setThumbImage:[UIImage imageNamed:@"setting_slider_thumb"] forState:UIControlStateNormal];
    
    mSoundSlider.value = [[[NSUserDefaults standardUserDefaults] objectForKey:@"volumeValue"]floatValue];
    mSpeedSlider.value = [[[NSUserDefaults standardUserDefaults] objectForKey:@"speedValue"]floatValue];
    if (mSoundSlider.value == 0 && mSpeedSlider.value == 0) {
        [mSoundSlider setValue:0.5];
        [mSpeedSlider setValue:0.5];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onSoundSlider:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setFloat:mSoundSlider.value forKey:@"volumeValue"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayBackgroundMusic" object:nil];
}

- (IBAction)onSpeedSlider:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setFloat:mSpeedSlider.value forKey:@"speedValue"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)onReturnButton:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setFloat:mSoundSlider.value forKey:@"volumeValue"];
    [[NSUserDefaults standardUserDefaults] setFloat:mSpeedSlider.value forKey:@"speedValue"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"volume and speed = %@ %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"volumeValue"], [[NSUserDefaults standardUserDefaults] objectForKey:@"speedValue"]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onResetButton:(id)sender
{
    [mSoundSlider setValue:0.5 animated:YES];
    [mSpeedSlider setValue:0.5 animated:YES];
}
@end
