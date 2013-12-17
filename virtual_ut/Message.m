//
//  Message.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "Message.h"

@implementation Message

-(id) init
{
    self = [super init];
    self.login = [[NSString alloc]init];
    self.texte = [[NSString alloc]init];
    self.date = [[NSDate alloc]init];
    self.ecole = [[NSString alloc]init];
    
    return self;
}
@end
