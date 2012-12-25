//
//  AuthorVC.h
//  FirstTableProject
//
//  Created by Kevin Languedoc on 12/5/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "CardDetailView.h"


@interface ListView : UITableViewController{
    NSMutableArray *kingdom_cards;
    sqlite3 * db;

}
@property(nonatomic,retain) NSMutableArray *kingdom_cards;
@property(nonatomic, strong)CardDetailView *details;

-(NSMutableArray *) card_list;
@end
 