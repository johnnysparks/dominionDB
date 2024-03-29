//
//  KingdomView.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDetailView.h"
#import "CardCell.h"

@interface KingdomView : UIViewController <UICollectionViewDataSource>

@property NSInteger selected_index;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end
