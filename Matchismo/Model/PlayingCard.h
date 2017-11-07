// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end

