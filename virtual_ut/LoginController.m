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
        
        return YES;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for seg in login");
    NSLog([segue identifier] );
    if([[segue identifier] isEqualToString:@"unlock"]){
        NSLog(@"goof");
        Interface_serveur * serveur = [[Interface_serveur alloc]init];
        [serveur initConnexion: @"inscription"];
        
        TabBarController *navController = [[TabBarController alloc]init];
        navController = (TabBarController *)segue.destinationViewController;
        //CompteController *controller = (CompteController *)navController.topViewController;
        //controller.isSomethingEnabled = YES; }
        navController.toto = @"cocoal";
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



@end
