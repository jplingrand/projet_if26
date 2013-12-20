//
//  TransactionController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
@interface TransactionController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titre;
@property (weak, nonatomic) IBOutlet UILabel *infoEtudiant;
@property (weak, nonatomic) IBOutlet UILabel *nom;
@property (weak, nonatomic) IBOutlet UILabel *prenom;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UITextField *champCode;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property Transaction * transaction;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *prix;
@property (weak, nonatomic) IBOutlet UIView *confirmationAnnulationView;
@property (weak, nonatomic) IBOutlet UILabel *consigne;
@property (weak, nonatomic) IBOutlet UIButton *boutonValider;
- (IBAction)actionAnnuler:(id)sender;
- (IBAction)actionValider:(id)sender;
-(void)annuleeWithError :(BOOL) response;
-(void)valideeWithError : (BOOL) response;
@end
