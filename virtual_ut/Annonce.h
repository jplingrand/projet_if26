//
//  Annonce.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Annonce : NSObject
@property int id;
@property NSDate * date;
@property NSString * login;
@property NSString * ecole;
@property NSString * categorie;
@property NSString * titre;
@property NSString * texte;
@property int prix;
@property BOOL valide;
@property NSMutableArray * messages;
@end
