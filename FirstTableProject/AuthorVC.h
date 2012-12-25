//
//  AuthorVC.h
//  FirstTableProject
//
//  Created by Kevin Languedoc on 12/5/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AuthorDetailView.h"


@interface AuthorVC : UITableViewController{
    NSMutableArray *theauthors;
    sqlite3 * db;

}
@property(nonatomic,retain) NSMutableArray *theauthors;
@property(nonatomic, strong)AuthorDetailView *details;

-(NSMutableArray *) authorList;
@end
