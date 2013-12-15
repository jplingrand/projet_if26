//
//  LoginController.m
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "LoginController.h"
#import "Interface_serveur.h"
#import "TabBarController.h"
#import "CompteController.h"
#import "UIViewController+TabBar.h"

@implementation LoginController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (sender == self.boutonInscription)
    {
        return YES;
    }
    else if (sender == self.boutonConnexion)
    {
        if ([self.txtLogin.text  isEqual: @""] || [self.txtPassword.text  isEqual: @""] ) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Veuillez remplir tous les champs", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
        }else{
            [[Interface_serveur alloc]initConnexion: self.txtLogin.text withPassword:self.txtPassword.text fromViewController:self];
            return NO;
        }
    }
    return NO;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for seg in login");
    if([[segue identifier] isEqualToString:@"unlock"]){
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewdidload");
}

-(IBAction)unwindToConnexion:(UIStoryboardSegue *)segue
{
    
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)getResponseFromServeur : (BOOL) reponse
{
    NSLog(@"%@",self.tabBar.etudiant);
   if(!reponse)
   {
       [self performSegueWithIdentifier:@"unlock" sender:self];
   }else{
       UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur de connexion", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
       [alert show];
   }
}



@end
