//
//  SetCard.h
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/21/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

+ (NSArray *)cardsFromText:(NSString *)text;

@end
