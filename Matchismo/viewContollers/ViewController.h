//
//  ViewController.h
//  Matchismo
//
//  Created by Ofir Ben Yashar on 24/10/2017.
//  Copyright © 2017 Ofir Ben Yashar Corporations. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Deck.h"

@interface ViewController : UIViewController

- (Deck *)createDeck;
- (NSAttributedString *)attributedContextOfCard:(Card *)card;

@end

