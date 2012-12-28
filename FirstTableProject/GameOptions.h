//
//  GameOptions.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/27/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameOptions : NSObject{
    //options
    NSString *type;
    //sets
    NSMutableArray *sets;
}

@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSMutableArray *sets;

@end
