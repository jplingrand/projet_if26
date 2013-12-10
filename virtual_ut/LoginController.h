//
//  LoginController.h
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *boutonConnexion;
@property (weak, nonatomic) IBOutlet UIButton *boutonInscription;

@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
-(IBAction)textFieldReturn:(id)sender;
-(void) getResponseFromServeur;
@end
