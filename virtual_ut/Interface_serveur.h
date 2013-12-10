//
//  Interface_serveur.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+TabBar.h"

@interface Interface_serveur : NSObject
@property (nonatomic,strong) UIViewController * viewController;
-(id)initConnexion : (NSString *) login withPassword :(NSString*)password fromViewController:(UIViewController *)viewController;
@end
