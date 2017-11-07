// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "HistoryViewContoller.h"
@interface HistoryViewContoller ()
@property (weak, nonatomic) IBOutlet UITextView *historyText;
@end

@implementation HistoryViewContoller

- (void)viewWillAppear:(BOOL)animated{
  [self updateUI];
}

- (void)updateUI {
  NSMutableAttributedString *textViewString = [[NSMutableAttributedString alloc] init];
  NSAttributedString *lastMoveString = [self.historyArray lastObject];
  for (NSAttributedString *moveString in self.historyArray) {
    [textViewString appendAttributedString:moveString];
    if (lastMoveString != moveString) {
      [textViewString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
  }
  self.historyText.attributedText = textViewString;
}

@end
