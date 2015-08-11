//
//  MGBalloonPlayBoard.h
//  MusicGame
//
//  Created by Faustino L on 9/24/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGBalloonPlayBoardDelegate <NSObject>

@optional
- (void) onBalloonPressed : (int) value;
- (void) balloonPlayBoardEnded;
- (void) balloonDisappeared : (int) value;

@end

@interface MGBalloonPlayBoard : UIView
{
    NSTimer* gameTimer;
}

@property (nonatomic) float gameSpeed;
@property (nonatomic) int balloonCount;

@property (nonatomic, strong) NSMutableArray *balloons;

- (void) play;
- (void) pause;
- (void)setupBalloons;
- (void)resetBalloons : (int)value;
@property (nonatomic,strong) id<MGBalloonPlayBoardDelegate> delegate;

@end
