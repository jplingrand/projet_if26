//
//  LoginController.m
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "LoginController.h"
#import "Interface_serveur.h"

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
    else
    {
        if ([self.txtLogin.text  isEqual: @""] || [self.txtPassword.text  isEqual: @""] ) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Veuillez remplir tous les champs", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        NSLog(@"c bon");
        Interface_serveur * serveur = [[Interface_serveur alloc]init : @"inscription"];
        return YES;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

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



@end
