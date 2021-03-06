//
//  GameResult.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 12/3/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;

@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_KEY @"Game"

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

// Whenever a score changes, the result is saved to user defaults (which in user-defaults terminology is called synchronize)
- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

// When generating "start" a new result the timer
- (id)init
{
    self = [super init];
    
    if (self)
    {
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
}

- (void)synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults
                                              forKey:ALL_RESULTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList
{
    return @{ START_KEY : self.start,
                END_KEY : self.end,
              SCORE_KEY : @(self.score),
               GAME_KEY : self.gameType };
}

// When reading back all results, another initialization method is used to create each single result, based on the stored property list/dictionary
+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues])
    {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}

// This convenience initialization method takes every entry of the property list and fills the result properties
- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    
    if (self)
    {
        if ([plist isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
           
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            _gameType = resultDictionary[GAME_KEY];
            
            if (!_start || !_end) self = nil;
        }
    }
    
    return self;
}

- (NSComparisonResult)compareScore:(GameResult *)result
{
    return [@(self.score) compare:@(result.score)];
}

- (NSComparisonResult)compareDuration:(GameResult *)result
{
    return [@(self.duration) compare:@(result.duration)];
}

- (NSComparisonResult)compareDate:(GameResult *)result
{
    return [self.end compare:result.end];
}

@end
