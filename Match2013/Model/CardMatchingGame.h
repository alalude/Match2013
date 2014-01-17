//
//  CardMatchingGame.h
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/7/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) NSUInteger maxMatchingCards;

@property (nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;

@property (nonatomic) int dummySetting;

@end
