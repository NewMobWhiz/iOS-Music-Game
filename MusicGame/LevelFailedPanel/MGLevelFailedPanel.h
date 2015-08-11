//
//  MGLevelFailedPanel.h
//  MusicGame
//
//  Created by Faustino L on 9/8/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGLevelFiledPanelDelegate <NSObject>

@optional

- (void) onFailedPanelMenuButtonPressed;
- (void) onFailedPanelOkButtonPressed;
- (void) onFailedPanelMenuButtonPressed2;
- (void) onFailedPanelOkButtonPressed2;

@end

@interface MGLevelFailedPanel : UIView

- (IBAction)onMenuButton:(id)sender;
- (IBAction)onOkButton:(id)sender;

@property (nonatomic, strong) id<MGLevelFiledPanelDelegate> delegate;

@end
