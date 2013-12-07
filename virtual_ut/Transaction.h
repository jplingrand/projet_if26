//
//  Transaction.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject
@property int * id;
@property int * acheteur;
@property int * vendeur;
@property int * noteAcheteur;
@property int * noteVendeur;
@property NSString * status;
@property int * prix;
@property NSString * titre;
@end
