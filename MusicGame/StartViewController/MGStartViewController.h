//
//  MGStartViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "iAd/ADBannerView.h"
#import "iAd/iAd.h"

@interface MGStartViewController : UIViewController < AVAudioPlayerDelegate, AVAudioSessionDelegate, ADBannerViewDelegate >
{
    AVAudioPlayer* backgroundMusicPlayer;
    AVQueuePlayer* player;
    SLComposeViewController *mySocialSheet;
    IBOutlet ADBannerView *adBanner;
    
}

- (IBAction)onPlayButton:(id)sender;
- (IBAction)onOptionsButton:(id)sender;
- (IBAction)onHelpButton:(id)sender;
@end
