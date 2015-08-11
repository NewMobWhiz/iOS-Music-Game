//
//  MGSettingViewController.h
//  MusicGame
//
//  Created by Faustino L on 9/5/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGSettingViewController : UIViewController
{
    IBOutlet UISlider* mSoundSlider;
    IBOutlet UISlider* mSpeedSlider;
}

- (IBAction)onSoundSlider:(id)sender;
- (IBAction)onSpeedSlider:(id)sender;
- (IBAction)onReturnButton:(id)sender;
- (IBAction)onResetButton:(id)sender;
@end
