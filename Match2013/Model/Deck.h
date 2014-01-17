//
//  Deck.h
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/5/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

// define a method a second time if you want an option with more or fewer arguements
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
