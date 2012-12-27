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
@synthesize custom;
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
    custom = false;
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

- (IBAction)refresh_cards:(id)sender {
    [self get_cards];
    [self collectionView];
}

-(NSMutableArray *) get_cards{
    Query *query = [[Query alloc] init];
    query.options = "SELECT * FROM kingdom_cards ORDER BY RANDOM() LIMIT 10";
    [query get_cards];
    kingdom_cards = query.cards;
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
