//
//  LevelCompletePanel.h
//  MusicGame
//
//  Created by Faustino L on 1/28/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelCompletePanel : UIViewController{

    IBOutlet UIImageView *star_1_img;
    IBOutlet UIImageView *star_2_img;
    IBOutlet UIImageView *star_3_img;
    IBOutlet UILabel *mScoreLabel;
    IBOutlet UILabel *mHighScoreLabel;
}
- (IBAction)clickOnBtn:(id)sender;

@end
