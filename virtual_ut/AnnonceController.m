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
	// Do any additional setup after loading the view.
    self.listeMessages.dataSource = self;
    self.listeMessages.delegate = self;

    self.titre.text = self.annonce.titre;
    self.texte.text = self.annonce.texte;
    self.prix.text = [NSString stringWithFormat:@"%d",self.annonce.prix];
    self.ecole.text = self.annonce.ecole;
    self.login.text = self.annonce.login;

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.date.text = [formatter stringFromDate:self.annonce.date];
    
    NSLog(@"annonce avec valllide à : %hhd id vendeur : %d et id etu : %d", self.annonce.valide,self.annonce.idVendeur, self.tabBar.etudiant.id);

    if(self.annonce.valide){
        self.boutonNouveauMessage.hidden = NO;
        if (self.annonce.idVendeur  == self.tabBar.etudiant.id) {
            self.login.text = @"toi";
            self.ecole.text = self.tabBar.etudiant.ecole;
            
            self.boutonAnuller.hidden = NO;
            [self.boutonAnuller setEnabled:YES];
            
            self.boutonAcheter.hidden = YES;
            [self.boutonAcheter setEnabled:YES];
        }else{
            self.boutonAnuller.hidden = YES;
            [self.boutonAnuller setEnabled:NO];

            self.boutonAcheter.hidden = NO;
            [self.boutonAcheter setEnabled:YES];
        }
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
    // Dispose of any resources that can be recreated.
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
        if(self.annonce.idVendeur == self.tabBar.etudiant.id){
            [[Interface_serveur alloc]annulerAnnonce:self withIdAnnonce:self.annonce.id];
        }else{
            [[Interface_serveur alloc]initAchat:self withAnnonce:self.annonce.id];
        }
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"no");
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
-(void)unwindToAnnonce : (UIStoryboardSegue*)segue
{
    MessageViewController * source = [segue sourceViewController];
    Message * message = source.message;
    if (message!=nil) {
        [self.annonce.messages addObject:message];
        [self.listeMessages reloadData];
    }
}

-(void)achatWithError:(BOOL)reponse
{

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
-(void)annulationWithError:(BOOL)reponse
{
    
    if(!reponse)
    {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"C'est tout bon", @"") message:NSLocalizedString(@"Votre a bien été retirée des annonces dispos, retrouvez là dans 'mes annonces / archivées ", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
