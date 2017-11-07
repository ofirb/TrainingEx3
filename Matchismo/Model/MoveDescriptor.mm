// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "MoveDescriptor.h"


@implementation MoveDescriptor

- (NSMutableArray *) cards{
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void)resetMe {
  self.matching = NO;
  self.success = NO;
  self.matchScore = 0;
  [self.cards removeAllObjects];
}


@end


