//
//  AnnonceController.m
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "AnnonceController.h"
#import "Message.h"
#import "MessageCell.h"
#import "Etudiant.h"
#import "Interface_serveur.h"
#import "UIViewController+TabBar.h"
#import "AppDelegate.h"

@interface AnnonceController ()

@end

@implementation AnnonceController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.annonce = [[Annonce alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Permet de gérer la scroll view des messages
    self.listeMessages.dataSource = self;
    self.listeMessages.delegate = self;

    self.titre.text = self.annonce.titre;
    self.texte.text = self.annonce.texte;
    self.prix.text = [NSString stringWithFormat:@"%d",self.annonce.prix];
    self.ecole.text = self.annonce.ecole;
    self.login.text = self.annonce.login;
    self.categorie.text = self.annonce.categorie;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.date.text = [formatter stringFromDate:self.annonce.date];
    
    // Si annonce valide on affiche le bouton de nouveau message
    if(self.annonce.valide){
        self.boutonNouveauMessage.hidden = NO;
        
        // Si le user = vendeur on affiche le bouton annuler et on cache le bouton acheter
        if (self.annonce.idVendeur  == self.tabBar.etudiant.id) {
            self.login.text = @"toi";
            self.ecole.text = self.tabBar.etudiant.ecole;
            
            self.boutonAnuller.hidden = NO;
            [self.boutonAnuller setEnabled:YES];
            
            self.boutonAcheter.hidden = YES;
            [self.boutonAcheter setEnabled:YES];
        
        // Sinon on cache le bouton Annuler et on affiche le bouton acheter
        }else{
            self.boutonAnuller.hidden = YES;
            [self.boutonAnuller setEnabled:NO];

            self.boutonAcheter.hidden = NO;
            [self.boutonAcheter setEnabled:YES];
        }
    
    // Si annonce non valide, on cache le bouton nouveau message, le bouton annuler et le bouton acheter
    }else{
        self.boutonNouveauMessage.hidden = YES;
        [self.boutonNouveauMessage setEnabled:NO];

        self.boutonAcheter.hidden = YES;
        [self.boutonAcheter setEnabled:NO];

        self.boutonAnuller.hidden = YES;
        [self.boutonAnuller setEnabled:NO];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)boutonAcheter:(id)sender {
    int prix = self.annonce.prix;

    [self showConfirmAlertWithText:[NSString stringWithFormat:@"confirmez vous le credit de %d VUTs de votre compte?",prix] andWithTitle:@"confirmer votre achat"];
}

- (IBAction)boutonAnnuler:(id)sender {
        [self showConfirmAlertWithText:@"confirmez vous l'annulation de votre annonce?" andWithTitle:@"confirmer votre annulation"];
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
        // Si le user = vendeur alors requete annuler
        if(self.annonce.idVendeur == self.tabBar.etudiant.id){
            [[Interface_serveur alloc]annulerAnnonce:self withIdAnnonce:self.annonce.id];
       
        // sinon on test le solde et si suffisant on fait la requete acheter
        }else{
            if(self.annonce.prix>self.tabBar.etudiant.credits){
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Votre solde est insuffisant", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
                [alert show];
            }else{
                [[Interface_serveur alloc]initAchat:self withAnnonce:self.annonce.id];
            }
        }
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender == self.boutonNouveauMessage) {
        MessageViewController * viewController = [segue destinationViewController]
        ;
        viewController.idAnnonce = self.annonce.id;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [self.annonce.messages count];
}


// Permet le chargement des messages
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *MyIdentifier = @"cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] init];
    }
    
    Message *message = [[Message alloc]init];
    message = [self.annonce.messages objectAtIndex:indexPath.row];
    
    cell.texte.text = message.texte;
    cell.ecole.text = message.ecole;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    cell.date.text = [formatter stringFromDate : message.date];
    cell.login.text = message.login;
    return cell;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// Fonction de retour depuis la vue de nouveau message
-(void)unwindToAnnonce : (UIStoryboardSegue*)segue
{
    MessageViewController * source = [segue sourceViewController];
    Message * message = source.message;
    
    // Si bouton poster alors message != nil
    if (message!=nil) {
        [self.annonce.messages addObject:message];
        [self.listeMessages reloadData];
    }
}

// réponse serveur de la requete d'achat
-(void)achatWithError:(BOOL)reponse
{
        // Response = erreur, on averti le user. Si pas d'erreur on repart au menu principal (de mon compte)
        if(!reponse)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"C'est tout bon", @"") message:NSLocalizedString(@"Votre achat est confirmé, retrouvez le dans 'mes transactions / en cours' ", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
            [self performSegueWithIdentifier:@"unwindToRoot" sender:self];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
        }
}

// Fonction réponse serveur pour la requete d'annulation
-(void)annulationWithError:(BOOL)reponse
{
    // On averti le user et on repart au menu principal si erreur == NO;
    if(!reponse)
    {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"C'est tout bon", @"") message:NSLocalizedString(@"Votre a bien été retirée des annonces dispos, retrouvez là dans 'mes annonces / archivées ", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"unwindToRoot" sender:self];
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
