//
//  Deck.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/5/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation Deck

// allocate memory for array of cards e.g. Deck
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
    
    else
    {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    // syntax for second definition
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    // protecting gainst empty array crash
    if ([self.cards count])
    {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
