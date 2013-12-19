//
//  TransactionController.m
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "TransactionController.h"
#import "Interface_serveur.h"
#import "UIViewController+TabBar.h"
@interface TransactionController ()

@end

@implementation TransactionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.transaction = [[Transaction alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titre.text = self.transaction.titre;
    self.prix.text = [NSString stringWithFormat:@"%d VUTs",self.transaction.prix];
    self.prenom.text = self.transaction.etudiant.prenom;
    self.nom.text = self.transaction.etudiant.nom;
    self.email.text = self.transaction.etudiant.email;
    self.tel.text = self.transaction.etudiant.tel;
    if([self.transaction.statut isEqualToString:@"En cours"]){
        if(self.transaction.code!=nil&&![self.transaction.code isEqualToString:@""]){
            self.boutonValider.hidden = YES;
            self.champCode.text = self.transaction.code;
            self.champCode.enabled = NO;
            self.consigne.text = @"communiquez ce code au vendeur une fois la transaction opérée";
        }else{
            self.champCode.enabled = YES;
            self.consigne.text = @"Une fois la transaction opérée, entrez le code fourni par l'acheteur";
        }
    }else{
        self.confirmationAnnulationView.hidden = YES;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionAnnuler:(id)sender {
    [self showConfirmAlertWithText:@"Confirmez-vous l'annulation de la transaction?" andWithTitle:@"t'es sûr?"];
}
- (void)showConfirmAlertWithText : (NSString * )message andWithTitle:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:message];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[Interface_serveur alloc]annulerTransaction:self withIdTransaction:self.transaction.id];
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"no");
    }
}
- (IBAction)actionValider:(id)sender {
    if(self.champCode.text.length > 0){
        [[Interface_serveur alloc] validerTransaction:self withIdTransaction:self.transaction.id withCode:self.champCode.text];
    }
}

-(void)annuleeWithError:(BOOL)response
{
    if(response){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur de connexion", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"confirmation", @"") message:NSLocalizedString(@"la transaction a bien été annulée", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"transactionToRoot" sender:self];
    }
    
    
}

-(void)valideeWithError:(BOOL)response
{
    if(response){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur de validation", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }else{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"confirmation", @"") message:NSLocalizedString(@"la transaction a bien été validée", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
    [alert show];
        [self performSegueWithIdentifier:@"transactionToRoot" sender:self];

    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
