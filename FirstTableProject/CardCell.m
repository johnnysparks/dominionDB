//
//  CardCell.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "CardCell.h"
#import "DominionVars.h"

@implementation CardCell

@synthesize id;
@synthesize card_index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)replace:(id)sender {
    DominionVars *dominion = [DominionVars sharedVars];
    dominion.replace_index = self.card_index;
    NSLog(@"%@", dominion.replace_index);
}


@end
