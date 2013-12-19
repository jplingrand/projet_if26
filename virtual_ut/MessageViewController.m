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

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if(sender==self.boutonPoster){
        if(self.textViewMessage.text.length == 0){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Votre message est vide", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
        }else{
            [[Interface_serveur alloc]initNouveauMessage:self withMessage:self.textViewMessage.text forAnnonce:self.idAnnonce];
        }
        return  NO;
    }else{
        return  YES;
    }
    return NO;
}
-(void)getResponseFromServeur : (BOOL) reponse;
{
    if(!reponse)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Votre message a bien été publié", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        self.message.texte = self.textViewMessage.text;
        self.message.date = [NSDate date];
        self.message.login = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.login;
       self.message.ecole = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.ecole;
        [self performSegueWithIdentifier:@"retourAnnonce" sender:self];
        
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur de connexion", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }
}

@end
