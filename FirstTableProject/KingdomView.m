//
//  KingdomView.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "KingdomView.h"
#import "Card.h"
#import "Query.h"

@interface KingdomView ()

@end

@implementation KingdomView
@synthesize kingdom_cards;
@synthesize selected_index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self get_cards];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selected_index = indexPath.row;
    NSLog(@"Selected index %d", selected_index);
    Card *card = [kingdom_cards objectAtIndex:selected_index];
    NSLog(@"Card Name %@", card.name);
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return kingdom_cards.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell *card_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    int row = [indexPath row];
    Card *card = kingdom_cards[row];
    card_cell.name.text = card.name;    
    return card_cell;
}

- (void)refresh_cards {
    NSLog(@"Refresh Cards");
    [self get_cards];
    [self.collectionView reloadData];
}

-(NSMutableArray *) get_cards{
    GameOptions *options = [[GameOptions alloc] init];
    Query *query = [[Query alloc] init];
    if(kingdom_cards == nil) {
        options.type = @"random";
        query.options = options;
        [query get_cards];
        kingdom_cards = query.cards;
    }
    Card *card = kingdom_cards[0];
    NSLog(@"%@", card.name);
    return kingdom_cards;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CardCell *cell = (CardCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    int i = indexPath.row%10;
    
    CardDetailView *detailViewController = [segue destinationViewController];
    detailViewController.card = [kingdom_cards objectAtIndex:i];
 
}

@end
