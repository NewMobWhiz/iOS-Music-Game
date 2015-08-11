//
//  MGStartViewController.m
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGStartViewController.h"

@interface MGStartViewController ()

@end

@implementation MGStartViewController

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
    
//    adBanner.frame.size = CGSizeMake(self.view.frame.size.width, 32) ;
    [[NSUserDefaults standardUserDefaults] setValue:@"normal" forKey:@"game_mode"];
    
    NSString* audio_name = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%02d", arc4random() % 3 + 1] ofType:@"mp3" inDirectory: @"Sound"];
    backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
    backgroundMusicPlayer.delegate = self;
    backgroundMusicPlayer.currentTime = 0;
    backgroundMusicPlayer.volume = 0.5;
    [backgroundMusicPlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFacebookPost:) name:@"FaceBookPost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTwitterPost:) name:@"TwitterPost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PauseBackgroundMusic:) name:@"PauseBackgroundMusic" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlayBackgroundMusic:) name:@"PlayBackgroundMusic" object:nil];
    
    adBanner.delegate = self;
    adBanner.frame = CGRectMake(0, self.view.bounds.size.height - 32, self.view.bounds.size.width, 32);
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSString* audio_name = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%02d", arc4random() % 3 + 1] ofType:@"mp3" inDirectory: @"Sound"];
    backgroundMusicPlayer = nil;
    backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audio_name] error:nil];
    backgroundMusicPlayer.delegate = self;
    backgroundMusicPlayer.currentTime = 0;
    backgroundMusicPlayer.volume = 0.5;
    [backgroundMusicPlayer play];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onPlayButton:(id)sender
{
    
}

- (IBAction)onOptionsButton:(id)sender
{
    
}

- (IBAction)onHelpButton:(id)sender
{
    
}

- (void) PauseBackgroundMusic : (NSNotification*) not
{
    [backgroundMusicPlayer pause];
}

- (void) PlayBackgroundMusic : (NSNotification*) not
{
    
    [backgroundMusicPlayer setEnableRate:true];
    [backgroundMusicPlayer prepareToPlay];
    backgroundMusicPlayer.rate = 1.0;
    backgroundMusicPlayer.volume = [[[NSUserDefaults standardUserDefaults] objectForKey:@"volumeValue"]floatValue];
    [backgroundMusicPlayer play];
}

- (void) onFacebookPost : (NSNotification*) not
{
    mySocialSheet = [[SLComposeViewController alloc] init];
    mySocialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [mySocialSheet setInitialText:[NSString stringWithFormat:@"Music Whiz Game \n\nShared my today score:"]];
    
    [self presentViewController:mySocialSheet animated:YES completion:nil];
    
    [mySocialSheet setCompletionHandler:^(SLComposeViewControllerResult result){
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successful";
                break;
            default:
                break;
        }
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

- (void) onTwitterPost : (NSNotification*) not
{
    mySocialSheet = [[SLComposeViewController alloc] init];
    mySocialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [mySocialSheet setInitialText:[NSString stringWithFormat:@"Music Whiz Game \n\nShared my today score:"]];
    
    [self presentViewController:mySocialSheet animated:YES completion:nil];
    
    [mySocialSheet setCompletionHandler:^(SLComposeViewControllerResult result){
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successful";
                break;
            default:
                break;
        }
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

#pragma mark ADBannerViewDelegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    banner.frame = CGRectMake(0, self.view.bounds.size.height - 32, self.view.bounds.size.width, 32);
    [UIView animateWithDuration:0.5 animations:^{ adBanner.alpha = 1.0;}];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView animateWithDuration:0.5 animations:^{ adBanner.alpha = 0.0;}];
}
@end
