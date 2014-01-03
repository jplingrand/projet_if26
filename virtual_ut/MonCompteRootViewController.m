//
//  MonCompteRootViewController.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 19/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "MonCompteRootViewController.h"
#import "Interface_serveur.h"
#import "AppDelegate.h"
@interface MonCompteRootViewController ()

@end

@implementation MonCompteRootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Fonction appellée pour tout lancement de segue.
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    ((AppDelegate *)[UIApplication sharedApplication].delegate).type = identifier;
    
    // Si segue va vers infos perso il est réalisé
    if ([identifier isEqualToString:@"monCompte"])
    {
        return YES;
    }
    
    // Si segue va vers annonces et transactions, on crée une instance serveur pour réaliser la requete et le segue n'est pas réalisé
    else if ([identifier isEqualToString:@"mesAnnoncesEnCours"]||[identifier isEqualToString:@"mesAnnoncesArchivees"])
    {
        [[Interface_serveur alloc]initMesAnnonces:self];
        self.segueIdentifier = identifier;
    }
    else if ([identifier isEqualToString:@"mesTransactionsVendeur"]||[identifier isEqualToString:@"mesTransactionsAcheteur"])
    {
        [[Interface_serveur alloc]initMesTransactions:self];
        self.segueIdentifier = identifier;
    }

    return NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
}

-(void)getResponseWithError:(BOOL)error
{
    [self performSegueWithIdentifier:self.segueIdentifier sender:self];
}

-(IBAction)unwindToRoot:(id)sender
{
    
}

@end
