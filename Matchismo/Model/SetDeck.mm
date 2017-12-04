// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (void)resetCards {
  [self clearDeck];  
  for (NSUInteger number = 1; number <=3 ; number ++) {
    for (NSString *symbol in [SetCard validSymbols]) {
      for (NSString* color in [SetCard validColors]) {
        for (NSString* shade in [SetCard validShadings]) {
          SetCard *card = [[SetCard alloc] init];
          card.number = number;
          card.symbol = symbol;
          card.shade = shade;
          card.color = color;
          [self addCard:card];
        }
      }
    }
  }
}

@end


