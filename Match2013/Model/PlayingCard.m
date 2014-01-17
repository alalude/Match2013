//
//  PlayingCard.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/5/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// overriding Card's match method

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int numOtherCards = [otherCards count];
    
    if (numOtherCards)
    {
        for (Card *card in otherCards)
        {
            if ([card isKindOfClass:[PlayingCard class]])
            {
                PlayingCard *otherCard = (PlayingCard *)card;
                
                if ([self.suit isEqualToString:otherCard.suit])
                {
                    score += 1;
                }
                
                else if (self.rank == otherCard.rank)
                {
                    score += 4;
                }
            }
        }
    }
    
    if (numOtherCards > 1)
    {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]];
    }
    
    return score;
}

/*
 - (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards firstObject]; // first pbject won't crash array on nil
        if (otherCard.rank == self.rank)
        {
            score = 4;
        }
        else if ([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
    }
    
    return score;
}
*/

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

// overriding Card's getter to work with rank and suit and return an appropriate string
// decleration is simply inherited
- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    // return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
    
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit; // because both setter and getter implemented by hand

// class method for use within the class
// can't reference  properties inside because their per instance storage
+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

// override setter to limit possible suits to valid options
- (void)setSuit:(NSString *)suit
{
    // not self.validSuits its a class method
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

// override getter to have unset suit be "?"
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] - 1; }

// let's make sure rank is always set to an appropriate value
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end

