//
//  MessageViewController.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 19/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "MessageViewController.h"
#import "Interface_serveur.h"
#import "AppDelegate.h"
#import "UIViewController+TabBar.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.message = [[Message alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Fonction appellée avant de réaliser les segues de postage de messagne ou d'annulation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // Si segue pour poster et que message n'est pas vide on fait la requete serveur et on annule le segue
    if(sender==self.boutonPoster){
        if(self.textViewMessage.text.length == 0){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Votre message est vide", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
        }else{
            [[Interface_serveur alloc]initNouveauMessage:self withMessage:self.textViewMessage.text forAnnonce:self.idAnnonce];
        }
        return  NO;
        
    // Si segue est annuler, on réalise le segue
    }else{
        return  YES;
    }
    return NO;
}

// Fonction de réponse serveur, response = error
-(void)getResponseFromServeur : (BOOL) reponse;
{
    // Si pas d'erreur
    if(!reponse)
    {
        // on averti l'utilisateur
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Votre message a bien été publié", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        
        // On initialise le message
        self.message.texte = self.textViewMessage.text;
        self.message.date = [NSDate date];
        self.message.login = self.tabBar.etudiant.login;
        self.message.ecole = self.tabBar.etudiant.ecole;
        
        // On revient à l'annonce
        [self performSegueWithIdentifier:@"retourAnnonce" sender:self];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur de connexion", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }
}

@end
