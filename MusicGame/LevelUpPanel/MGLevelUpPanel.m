//
//  MGLevelUpPanel.m
//  MusicGame
//
//  Created by Faustino L on 9/8/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGLevelUpPanel.h"

@implementation MGLevelUpPanel

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    
    return self;
}


- (void) setupViewWithScore : (int) score
                  StarCount : (int) starCount
                  HighScore : (int) highscore
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"game_mode"] isEqualToString:@"ballon"]){
        bgImg.image = [UIImage imageNamed:@"success_bg.png"];
    }
    
    if (starCount < 3)
        mStar3.hidden = YES;
    if (starCount < 2)
        mStar2.hidden = YES;
    [mScoreLabel setText:[NSString stringWithFormat:@"%04d", score]];
    [mHightScoreLabel setText:[NSString stringWithFormat:@"%04d", highscore]];
}

- (IBAction)onOkButton:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"game_mode"] isEqualToString:@"ballon"]) {
        [delegate onSucessPanelOkButtonPressed2];
    } else {
        [delegate onSucessPanelOkButtonPressed];
    }
    
}

@end
