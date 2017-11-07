// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "PlayingCardsViewController.h"
#import "PlayingCardDeck.h"


@implementation PlayingCardsViewController

- (Deck *)createDeck{
  return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card {
  
  return card.chosen ? card.contexts : [[NSAttributedString alloc] initWithString:@""];
}

- (NSAttributedString *)attributedContextOfCard:(Card *)card {
  return card.contexts;
}

-(UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.chosen? @"cardfront" : @"cardback"];
}

@end


