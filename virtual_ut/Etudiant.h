//
//  User.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Etudiant : NSObject
@property int token ;
@property int id;
@property NSString * prenom;
@property NSString * nom;
@property NSString * ecole;
@property NSString * email;
@property NSString * tel;
@property int credits;
@property long note;
@end
