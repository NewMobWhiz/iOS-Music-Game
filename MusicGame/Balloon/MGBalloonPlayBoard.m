//
//  MGBalloonPlayBoard.m
//  MusicGame
//
//  Created by Faustino L on 9/24/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "MGBalloonPlayBoard.h"
#import "MGBalloonButton.h"

#define GAME_INTERVAL 0.1f

@implementation MGBalloonPlayBoard

@synthesize delegate;

- (void)awakeFromNib
{
//    self.balloonCount = 10;
//    [self setupBalloons];
}

- (void)setupBalloons
{
    self.balloons = [NSMutableArray array];
    for (int i = 0; i < self.balloonCount; i ++) {
        [self.balloons addObject:[self newBalloon]];
    }
}

- (void)resetBalloons : (int)value
{
    self.balloons = [NSMutableArray array];
    for (int i = 0; i < self.balloonCount; i ++) {
        MGBalloonButton *button = [self.balloons objectAtIndex:i];
        button.mVelocity += value;
    }
}

- (MGBalloonButton *)newBalloon
{
    MGBalloonButton *button = [MGBalloonButton buttonWithType:UIButtonTypeCustom];
    
    button.mVelocity = (self.gameSpeed + arc4random() % 11);
    NSLog(@"ballongamespeed2= %d", button.mVelocity );
    button.frame = CGRectMake(0, 0, 70, 70);
    
    int value = arc4random() % 7 + 1;///
    int ballonType = arc4random() % 5 + 1;
    NSString* imageName = [NSString stringWithFormat:@"balloon%d_%02d",ballonType,value];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
//    if (value > 7 && value < 14) {///
//        value  = value - 7;
//    }
    button.mValue = value;
    
    int index = (int)self.balloons.count;
    
    button.frame = CGRectMake(10 + button.frame.size.width * (index % 3), self.frame.size.height + 100 * (index / 3), button.frame.size.width, button.frame.size.height);

    [self addSubview:button];
    [button addTarget:self action:@selector(onPressBalloon:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (void)onPressBalloon:(MGBalloonButton *)button
{
    [button removeFromSuperview];
    [self.balloons removeObject:button];
    [self.delegate onBalloonPressed:button.mValue];
}

- (void)update
{
    BOOL ended = YES;
    for (MGBalloonButton *button in self.balloons) {

        float vel = button.mVelocity;
        float dy = vel * GAME_INTERVAL;

        button.center = CGPointMake(button.center.x, button.center.y - dy);

        if (button.frame.origin.y > -button.frame.size.height) {

            ended = NO;
        }
        else {
            [self.delegate balloonDisappeared:button.mValue];
            [button removeFromSuperview];
//            [self.balloons removeObject:button];
        }
    }

    if (ended == YES) {

        [self.delegate balloonPlayBoardEnded];
        [self pause];
    }
}

- (void) play
{
    if (gameTimer == nil) {

        gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_INTERVAL target:self selector:@selector(update) userInfo:nil repeats:YES];
    }
}

- (void) pause
{
    [gameTimer invalidate];
    gameTimer = nil;
}

@end
