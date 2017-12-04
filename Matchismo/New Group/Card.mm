// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "Card.h"


@implementation Card

-(int)scoreForMatchingWithCards:(NSArray *)othercards {
  NSLog(@"inside card match");
  int score = 0;
  for (Card *card in othercards) {
    if ([card.contexts isEqualToAttributedString:self.contexts]) {
      score = 1;
    }
  }
  return score;
}

- (BOOL)shouldCheckMatch:(NSUInteger)numCards {
  return false;
}

@end


