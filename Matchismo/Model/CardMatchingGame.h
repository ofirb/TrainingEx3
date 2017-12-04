// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype) initUsingDeck:(Deck *)deck;
- (void)touchCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)resetGame;
- (Card *)addCard;
- (NSUInteger)cardsInDeckNum;


@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) BOOL gameRuns;
@property (nonatomic) NSUInteger activeCardsNum;

@end
