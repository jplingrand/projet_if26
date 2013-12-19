//
//  Transaction.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etudiant.h"
@interface Transaction : NSObject

@property int id;
@property int idAcheteur;
@property int idVendeur;
@property int noteAcheteur;
@property int noteVendeur;
@property NSString * statut;
@property NSString * titre;
@property int prix;
@property NSString * code;
@property Etudiant*etudiant;

@end
