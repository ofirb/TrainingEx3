// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "PlayingCard.h"



@implementation PlayingCard

- (NSAttributedString *) contexts {
  NSArray *rankStrings = [PlayingCard rankStrings];
  return [[NSAttributedString alloc] initWithString:[rankStrings[self.rank] stringByAppendingString:self.suit]];
}

- (int)match:(NSArray *)otherCards {
  assert([otherCards count] == 1);
  int score = 0;
  for (PlayingCard* otherCard in otherCards) {
    if (self.rank == otherCard.rank)                score +=4;
    if ([self.suit isEqualToString:otherCard.suit]) score +=1;
  }
  
  return score;
}

@synthesize suit = _suit;

+(NSArray *) validSuits {
  return @[@"♣︎",@"♠︎",@"♥️",@"♦️"];
}

-(void)setSuit:(NSString *)suit {
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *) suit {
  return _suit ? _suit : @"?";
}

- (NSString*) description {
  return [NSString stringWithFormat:@"%lu %@ chosen:%d matched:%d",
          (unsigned long)self.rank, self.suit,
          self.chosen, self.matched];
}

+ (NSArray *) rankStrings {
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",
           @"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger) maxRank {
  return [[self rankStrings] count] -1;
}

- (void) setRank:(NSUInteger)rank {
  if (rank <= [PlayingCard maxRank]) {
    _rank = rank;
  }
}

- (BOOL)checkMatch:(int)numCards {
  return numCards == 2;
}


@end

