//
//  AuthorDetailView.h
//  FirstTableProject
//
//  Created by Kevin Languedoc on 10/14/12.
//  Copyright (c) 2012 kCodebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@class Card;
@interface AuthorDetailView : UIViewController
@property(nonatomic, strong)id detailId;
@property(nonatomic, strong)Card *author;
@property (strong, nonatomic) IBOutlet UITextField *authorName;
@property (strong, nonatomic) IBOutlet UITextField *authorTitle;

@property (strong, nonatomic) IBOutlet UITextField *authorGenre;



@end
