//
//  Annonce.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "Annonce.h"

@implementation Annonce
-(id)init
{
    self = [super init];
    self.messages = [[NSMutableArray alloc] init];
    self.texte = [[NSString alloc]init];
    self.titre = [[NSString alloc]init];
    self.date = [[NSDate alloc]init];
    self.categorie = [[NSString alloc]init];
    return self;
}
@end
