//
//  MGLevelFailedPanel.m
//  MusicGame
//
//  Created by Faustino L on 9/8/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGLevelFailedPanel.h"
#import "MGBalloonViewController.h"

@implementation MGLevelFailedPanel

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)onMenuButton:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"game_mode"] isEqualToString:@"ballon"]) {
        [delegate onFailedPanelMenuButtonPressed2];
    } else {
        [delegate onFailedPanelMenuButtonPressed];
    }
    
}

- (IBAction)onOkButton:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"game_mode"] isEqualToString:@"ballon"]) {
        [delegate onFailedPanelMenuButtonPressed2];
    } else {
        [delegate onFailedPanelOkButtonPressed];
    }
}

@end
