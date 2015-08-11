//
//  MGPlayBoardCell.h
//  MusicGame
//
//  Created by Faustino L on 9/5/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGStage2PlayCell : UICollectionViewCell
{
    IBOutlet UILabel* mLabel;
    IBOutlet UIImageView* mImageView;
}

- (void) SetCellValue: (int) value;

@property (nonatomic) BOOL hasToShowLabel;
@property (nonatomic) BOOL isShowing;
@end
