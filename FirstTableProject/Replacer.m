//
//  Replacer.m
//  DominionDB
//
//  Created by Brandon Dusseau on 1/20/13.
//  Copyright (c) 2013 Malechite. All rights reserved.
//

#import "Replacer.h"

@interface Replacer ()

@end

@implementation Replacer

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)close_modal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
