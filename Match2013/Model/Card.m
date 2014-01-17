//
//  Card.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/5/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSUInteger)numberOfMatchingCards
{
    if (!_numberOfMatchingCards) _numberOfMatchingCards = 2;
    return _numberOfMatchingCards;
}

- (int)oldMatch:(Card *)card
{
    int score = 0;
    
    if([card.contents isEqualToString:self.contents])
    {
        score = 1;
    }
    
    return score;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for(Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents])
        {
            score = 1;
        } 
    }
    
    return score;
}

@end
