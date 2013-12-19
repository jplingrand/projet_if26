//
//  Transaction.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

-(id) init
{
    self = [super init];
    self.titre = [[NSString alloc]init];
    self.etudiant = [[Etudiant alloc]init];
    self.statut = [[NSString alloc]init];
    self.code = [[NSString alloc]init];
    return self;
}

@end
