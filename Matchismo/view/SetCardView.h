// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "CardView.h"

/// This class is Set game Card view represents the symbols according to the properties,
/// Symbols supported are the legacy ones, described below

@interface SetCardView : CardView
///The number of objects on card
@property (nonatomic) NSUInteger number;
///The symbol of objects on card available values: "diamond"/"squiggle"/"oval"
@property (nonatomic, strong) NSString *symbol;
///The color of objects on card available values: "red"/"green"/"purpule"
@property (nonatomic, strong) NSString *color;
///The pattern of objects on card available values: "solid"/"open"/"striped"
@property (nonatomic, strong) NSString *shade;

@end


