//
//  MGLevelUpPanel.h
//  MusicGame
//
//  Created by Faustino L on 9/8/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGLevelUpPanelDelegate <NSObject>

@optional

-(void)onSucessPanelOkButtonPressed;
-(void)onSucessPanelOkButtonPressed2;

@end

@interface MGLevelUpPanel : UIView
{
    IBOutlet UIImageView *bgImg;
    IBOutlet UIImageView* mStar1;
    IBOutlet UIImageView* mStar2;
    IBOutlet UIImageView* mStar3;
    IBOutlet UILabel* mScoreLabel;
    IBOutlet UILabel* mHightScoreLabel;
}

- (void) setupViewWithScore : (int) score StarCount : (int) starCount HighScore : (int) highscore;

- (IBAction)onOkButton:(id)sender;

@property (nonatomic, strong) id<MGLevelUpPanelDelegate> delegate;

@end
