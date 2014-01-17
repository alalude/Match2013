//
//  GameResult.h
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 12/3/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

// a class method which returns an array of all available game scores
+ (NSArray *)allGameResults; // of GameResults

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *gameType;

// helper methods used to sort the game results by score and duration
- (NSComparisonResult)compareScore:(GameResult *)result;
- (NSComparisonResult)compareDuration:(GameResult *)result;
- (NSComparisonResult)compareDate:(GameResult *)result;

@end
