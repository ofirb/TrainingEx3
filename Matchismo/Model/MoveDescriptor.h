// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import <Foundation/Foundation.h>

@interface MoveDescriptor : NSObject

- (void)resetMe;

@property (nonatomic) BOOL matching;
@property (nonatomic) BOOL success;
@property (nonatomic) NSInteger matchScore;
@property (strong, nonatomic) NSMutableArray *cards;

@end


