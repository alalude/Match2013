//
//  GameSettings.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 12/4/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

#define GAME_SETTINGS_KEY @"Game_Settings_Key"
#define MATCHBONUS_KEY @"MatchBonus_Key"
#define MISMATCHPENALTY_KEY @"MismatchPenalty_Key"
#define FLIPCOST_KEY @"FlipCost_Key"
#define NUMBERPLAYINGCARDS_KEY @"NumberPlayingCards_Key"

 
/* - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - */
/* These getters access a helper method which accesses the user defaults and if no valid setting is there returns a default value */
/* - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - */


- (int)intValueForKey:(NSString *)key withDefault:(int)defaultValue
{
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY];
    
    if (!settings) return defaultValue;
    
    if (![[settings allKeys] containsObject:key]) return defaultValue;
    
    return [settings[key] intValue];
}

- (int)matchBonus
{
    return [self intValueForKey:MATCHBONUS_KEY withDefault:4];
}

- (int)mismatchPenalty
{
    return [self intValueForKey:MISMATCHPENALTY_KEY withDefault:2];
}

- (int)flipCost
{
    return [self intValueForKey:FLIPCOST_KEY withDefault:1];
}


/* - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - */
/* These setters use another helper method to save their values to the user defaults */
/* The helper method creates a new property list (dictionary) if it has not been initialized, yet */
/* - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - */

- (void)setIntValue:(int)value forKey:(NSString *)key
{
    NSMutableDictionary *settings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY] mutableCopy];
    
    if (!settings)
    {
        settings = [[NSMutableDictionary alloc] init];
    }
    
    settings[key] = @(value);
    
    [[NSUserDefaults standardUserDefaults] setObject:settings
                                              forKey:GAME_SETTINGS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setMatchBonus:(int)matchBonus
{
    [self setIntValue:matchBonus forKey:MATCHBONUS_KEY];
}

- (void)setMismatchPenalty:(int)mismatchPenalty
{
    [self setIntValue:mismatchPenalty forKey:MISMATCHPENALTY_KEY];
}

- (void)setFlipCost:(int)flipCost
{
    [self setIntValue:flipCost forKey:FLIPCOST_KEY];
}

@end
