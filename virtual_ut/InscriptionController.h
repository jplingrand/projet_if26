//
//  InscriptionController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InscriptionController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *boutonInscription;
@property (weak, nonatomic) IBOutlet UITextField *txtPrenom;
@property (weak, nonatomic) IBOutlet UITextField *txtNom;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end
