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
@synthesize loaded;

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
    if(!loaded) {
        NSLog(@"loaded");
        [self get_cards];
        loaded = true;
    }

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
    card_cell.set.text = card.set;
    card_cell.coins.text = [NSString stringWithFormat:@"%d", card.cost_coins];
    card_cell.id = card.id;
    
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
    if(kingdom_cards.count > 0) {
        Card *card = kingdom_cards[0];
        NSLog(@"%@", card.name);
    }    
    return kingdom_cards;
}

- (IBAction)replace:(id)sender {
    NSLog(@"%@", sender);
    for(int i = 0; i < kingdom_cards.count; i++) {
        Card *card = kingdom_cards[i];
        NSLog(@"%d", card.id);
        NSLog(@"%@", card.name);
    }
    NSLog(@"%@", self);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CardCell *cell = (CardCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    int i = indexPath.row%10;
    
    CardDetailView *detailViewController = [segue destinationViewController];
    detailViewController.card = [kingdom_cards objectAtIndex:i];
 
}

@end
