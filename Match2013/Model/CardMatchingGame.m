//
//  CardMatchingGame.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/7/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "CardMatchingGame.h"

// class extension... home of private properties
@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card

@property (strong, nonatomic) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;

@end

@implementation CardMatchingGame

/* Active code only uses these to set defaults */
static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;
static const int DUMMY_SETTING = 11;

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self =[super init];
    
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            
            if (card) // not nil no crash
            {
                [self.cards addObject:card];
            }
            
            else
            {
                self = nil;
                break;
            }
            
        }
    }
    
    // Settings set to the defaults upon initialization
    _matchBonus = MATCH_BONUS;
    _mismatchPenalty = MISMATCH_PENALTY;
    _flipCost = COST_TO_CHOOSE;
    _dummySetting = DUMMY_SETTING;
    
    NSLog(@"CMG _matchBonus = %d", _matchBonus);
    NSLog(@"CMG _mismatchPenalty = %d", _mismatchPenalty);
    NSLog(@"CMG _flipCost = %d\n", _flipCost);
    
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    // me
    //Card *card = self.cards[index];
    //return card;
    
    // basic
    // return self.cards[index];
    
    // check bounds
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched)
    {
        // To turn down a face up card
        if (card.isChosen)
        {
            card.chosen = NO;
        }
        
        // To attempt a match
        else
        {
            NSMutableArray *otherCards = [NSMutableArray array];
            
            for (Card *otherCard in self.cards)
            {
                // An array of all cards chosen after the first
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    [otherCards addObject:otherCard];
                }
            }
            
            self.lastScore = 0;
            // For displaying chosen cards in UI
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            
            // Check for match when max numbers of cards has been chosen
            if ([otherCards count] + 1 == self.maxMatchingCards)
            {
                int matchScore = [card match:otherCards];
                
                if (matchScore)
                {
                    self.lastScore = matchScore * self.matchBonus;
                    card.matched = YES;
                    
                    for (Card *otherCard in otherCards)
                    {
                        otherCard.matched = YES;
                    }
                }
                
                else
                {
                    self.lastScore = - self.mismatchPenalty;
                    
                    for (Card *otherCard in otherCards)
                    {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            self.score += self.lastScore - self.flipCost;
            card.chosen = YES;
        }
    }
}

/* THREE CARD MATCHING
 - (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched)
    {
        if (card.isChosen)
        {
            card.chosen = NO;
        }
        
        else
        {
            NSMutableArray *otherCards = [NSMutableArray array];
            
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    [otherCards addObject:otherCard];
                }
            }
            
            if ([otherCards count] + 1 == self.maxMatchingCards)
            {
                int matchScore = [card match:otherCards];
                
                if (matchScore)
                {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    
                    for (Card *otherCard in otherCards)
                    {
                        otherCard.matched = YES;
                    }
                }
                
                else
                {
                    self.score -= MISMATCH_PENALTY;
                    
                    for (Card *otherCard in otherCards)
                    {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}
*/

/* TWO CARD MATCHING
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched) // only unmatched are playable
    {
        if (card.isChosen) // toggle its state
        {
            card.chosen = NO;
        }
        else
        {
            // match against other chosen cards
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore)
                    {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break; // can only choose two cards now
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}
*/

// It makes no sense for this value to be less than two, use lazy instantiation to validate and set its initial value
/* - (NSUInteger)maxMatchingCards
{
    if (_maxMatchingCards < 2)
    {
        _maxMatchingCards = 2;
    }
    
    return _maxMatchingCards;
} */

- (NSUInteger)maxMatchingCards
{
    Card *card = [self.cards firstObject];
    
    if (_maxMatchingCards < card.numberOfMatchingCards)
    {
        _maxMatchingCards = card.numberOfMatchingCards;
    }
    
    return _maxMatchingCards;
}

@end
