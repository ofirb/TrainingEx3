// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "Deck.h"

@interface Deck()
@property (strong,nonatomic) NSMutableArray *cards;
@end


@implementation Deck

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self resetCards];
  }
  return self;
}

- (NSMutableArray *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void)addCard:(Card *)card {
  [self addCard:card atTop:NO];
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  } else {
    [self.cards addObject:card];
  }
}

- (Card *)drawRandomCard {
  Card *randomCard = nil;
  if ([self.cards count]) {
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  return randomCard;
}

- (NSInteger)countCards {
  return [self.cards count];
}

- (void)resetCards {}

- (void)clearDeck {
  [self.cards removeAllObjects];
}

@end


