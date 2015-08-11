//
//  MGPlayBoardCell.m
//  MusicGame
//
//  Created by Faustino L on 9/5/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGStage2PlayCell.h"

@implementation MGStage2PlayCell

@synthesize hasToShowLabel;
@synthesize isShowing;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void) SetCellValue: (int) value
{
    mLabel.hidden = !hasToShowLabel;
    isShowing = YES;

    switch (value) {
        case 1:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_3_c"]];
            [mImageView setFrame:CGRectMake(0, 49, 54, 60)];
            [mLabel setText:@"C"];
        }
            break;
        case 2:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp_c"]];
            [mImageView setFrame:CGRectMake(0, 49, 54, 60)];
            [mLabel setText:@"C#"];
        }
            break;
        case 3:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_1"]];
            [mImageView setFrame:CGRectMake(0, 44, 54, 60)];
            [mLabel setText:@"D"];
        }
            break;
        case 4:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp"]];
            [mImageView setFrame:CGRectMake(0, 44, 54, 60)];
            [mLabel setText:@"D#"];
        }
            break;
        case 5:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_4"]];
            [mImageView setFrame:CGRectMake(0, 37, 54, 60)];
            [mLabel setText:@"E"];
        }
            break;
        case 6:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_3"]];
            [mImageView setFrame:CGRectMake(0, 30, 54, 60)];
            [mLabel setText:@"F"];
        }
            break;
        case 7:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp"]];
            [mImageView setFrame:CGRectMake(0, 30, 54, 60)];
            [mLabel setText:@"F#"];
        }
            break;
        case 8:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_3"]];
            [mImageView setFrame:CGRectMake(0, 23, 54, 60)];
            [mLabel setText:@"G"];
        }
            break;
        case 9:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp"]];
            [mImageView setFrame:CGRectMake(0, 23, 54, 60)];
            [mLabel setText:@"G#"];
        }
            break;
        case 10:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_3"]];
            [mImageView setFrame:CGRectMake(0, 18, 54, 60)];
            [mLabel setText:@"A"];
        }
            break;
        case 11:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp"]];
            [mImageView setFrame:CGRectMake(0, 18, 54, 60)];
            [mLabel setText:@"A#"];
        }
            break;
        case 12:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_4"]];
            [mImageView setFrame:CGRectMake(0, 12, 54, 60)];
            [mLabel setText:@"B"];
        }
            break;
        case 13:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_2_2"]];
            [mImageView setFrame:CGRectMake(0, 51, 54, 60)];
            [mLabel setText:@"C"];
        }
            break;
        case 14:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp_2"]];
            [mImageView setFrame:CGRectMake(0, 51, 54, 60)];
            [mLabel setText:@"C#"];
        }
            break;
        case 15:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_3_2"]];
            [mImageView setFrame:CGRectMake(0, 46, 54, 60)];
            [mLabel setText:@"D"];
        }
            break;
        case 16:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp_2"]];
            [mImageView setFrame:CGRectMake(0, 46, 54, 60)];
            [mLabel setText:@"D#"];
        }
            break;
        case 17:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_1_2"]];
            [mImageView setFrame:CGRectMake(0, 41, 54, 60)];
            [mLabel setText:@"E"];
        }
            break;
        case 18:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_2_2"]];
            [mImageView setFrame:CGRectMake(0, 36, 54, 60)];
            [mLabel setText:@"F"];
        }
            break;
        case 19:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp_2"]];
            [mImageView setFrame:CGRectMake(0, 36, 54, 60)];
            [mLabel setText:@"F#"];
        }
            break;
        case 20:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_3_2"]];
            [mImageView setFrame:CGRectMake(0, 30, 54, 60)];
            [mLabel setText:@"G"];
        }
            break;
        case 21:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_sharp_2"]];
            [mImageView setFrame:CGRectMake(0, 30, 54, 60)];
            [mLabel setText:@"G#"];
        }
            break;
        case 22:
        {
            [mImageView setImage:[UIImage imageNamed:@"music_mark_1_c_2"]];
            [mImageView setFrame:CGRectMake(0, 25, 54, 60)];
            [mLabel setText:@"A"];
        }
            break;
        case 100:
        {
            [mImageView setImage:nil];
            [mLabel setText:@""];
            isShowing = NO;
        }
            break;
        default:
            break;
    }
    [mLabel setFrame:CGRectMake(0, mImageView.frame.origin.y - 20, 54, 20)];
}

@end
