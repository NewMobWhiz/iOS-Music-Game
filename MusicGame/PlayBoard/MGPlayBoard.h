//
//  MGPlayBoard.h
//  MusicGame
//
//  Created by Faustino L on 9/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGPlayBoardDelegate <NSObject>

@optional
-(void)onMarkPressed:(int)markID;
-(void)onMarkMissed:(int)markID;
@end

@interface MGPlayBoard : UIView

@property (nonatomic) float gameSpeed;
@property (nonatomic, strong) id<MGPlayBoardDelegate> delegate;
@end
