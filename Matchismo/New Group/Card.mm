// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "Card.h"


@implementation Card

-(int)match:(NSArray *)othercards {
    NSLog(@"inside card match");
    int score = 0;
    for (Card *card in othercards) {
        if ([card.contexts isEqualToAttributedString:self.contexts]) {
            score = 1;
        }
    }
    return score;
}

- (BOOL)checkMatch:(int)numCards {
  return false;
}

@end


