// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "MoveDescriptor.h"


@interface CardMatchingGame : NSObject
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;


- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)resetGame;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) BOOL gameRuns;
@property (nonatomic, strong) NSMutableArray *movesDescriptorsHistory;




@end


