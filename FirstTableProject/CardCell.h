//
//  CardCell.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CardCell : UICollectionViewCell{
    int id;
}

@property (nonatomic) int id;
@property (weak, nonatomic) NSIndexPath *card_index;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *set;
@property (weak, nonatomic) IBOutlet UILabel *coins;

@end
