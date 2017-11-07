// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "SetCard.h"

@implementation SetCard

- (NSAttributedString *) contexts {
  return nil;
}

- (NSString*) description {
  return [NSString stringWithFormat:@"%lu %@ %@ %@ chosen:%d matched:%d",
          (unsigned long)self.number, self.symbol, self.color,
          self.shade, self.chosen, self.matched];
}

- (int)match:(NSArray *)othercards {
  assert([othercards count] == 2);
  SetCard* firstCard = self;
  SetCard* secondCard = [othercards firstObject];
  SetCard* thirdCard = [othercards lastObject];
  int matches = (firstCard.number == secondCard.number) + (secondCard.number == thirdCard.number) + (firstCard.number == thirdCard.number);
  if (matches == 1) {NSLog(@"number fails"); return 0;}
  matches = ([firstCard.symbol  isEqualToString:secondCard.symbol]) +
            ([secondCard.symbol isEqualToString:thirdCard.symbol ]) +
            ([firstCard.symbol  isEqualToString:thirdCard.symbol ]);
  if (matches == 1) {NSLog(@"symbol fails"); return 0;}
  matches = ([firstCard.shade  isEqualToString:secondCard.shade]) +
            ([secondCard.shade isEqualToString:thirdCard.shade ]) +
            ([firstCard.shade  isEqualToString:thirdCard.shade ]);
  if (matches == 1) {NSLog(@"shading fails"); return 0;}
  matches = ([firstCard.color  isEqualToString:secondCard.color]) +
            ([secondCard.color isEqualToString:thirdCard.color ]) +
            ([firstCard.color  isEqualToString:thirdCard.color ]);
  if (matches == 1) {NSLog(@"color fails"); return 0;}
  NSLog(@"match!!");
  return 3;
}


+ (NSArray*)validSymbols{
  return @[@"◼︎", @"▲", @"●"];
}

+ (NSArray *)validColors {
  return @[@"red", @"purple", @"green"];
}

+ (NSArray *)validShadings {
  return @[@"solid", @"striped", @"open"];
}
- (BOOL)checkMatch:(int)numCards {
  return numCards == 3;
}



@end

