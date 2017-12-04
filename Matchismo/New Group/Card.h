// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import <Foundation/Foundation.h>

/// Object represnting ...
///
@interface Card : NSObject

///
@property (strong, nonatomic) NSAttributedString *contexts;

///
@property (nonatomic) BOOL chosen;

///
@property (nonatomic) BOOL matched;

///
- (int)scoreForMatchingWithCards:(NSArray *)othercards;

///
- (BOOL)shouldCheckMatch:(NSUInteger)numCards;
///

@end

