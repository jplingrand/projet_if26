//
//  ListeAnnoncesController.m
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "ListeAnnoncesController.h"
#import "Annonce.h"
#import "AnnonceCell.h"
#import "UIViewController+TabBar.h"
#import "AnnonceController.h"
#import "AppDelegate.h"

@implementation ListeAnnoncesController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.annonces = [[NSMutableArray alloc]init];
    [self loadInitialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Fonction qui charge la liste d'annonces
- (void)loadInitialData {
    NSString * type =  self.tabBar.type;
    
    // Si liste d'annonces personnelles, on doit trier en fonction de valide ou non
    if ([type isEqualToString: @"mesAnnoncesEnCours"]||[type isEqualToString:@"mesAnnoncesArchivees"]) {
        bool valide;
        if ([type isEqualToString: @"mesAnnoncesEnCours"]) {
            self.title = @"mes annonces en cours";
            valide  = YES;
        }else{
            valide  = NO;
              self.title = @"mes annonces archivées";
        }
        for (int i=0; i<[self.tabBar.listeAnnonces count]; i++) {
            Annonce * annonce = self.tabBar.listeAnnonces[i];
            if (annonce.valide & valide) {
                [self.annonces addObject:annonce];
            }else if (!annonce.valide&!valide){
                [self.annonces addObject:annonce];
            }
        }
        
    // Sinon si c'est le resultat d'une recherche, aucun tri
    }else{
        self.annonces = self.tabBar.listeAnnonces;
    }
    
    // On rafraichi la liste
    [self.annoncesTableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.annonces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"annonceCell";
    
    AnnonceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Annonce * annonce = [self.annonces objectAtIndex:indexPath.row];
    cell.titre.text = annonce.titre;
    cell.prix.text = [NSString stringWithFormat:@"%d",annonce.prix];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    cell.date.text = [formatter stringFromDate:annonce.date];
    cell.ecole.text = annonce.ecole;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueVersAnnonce"]) {
        NSIndexPath * selectedRowIndex = [self.tableView indexPathForSelectedRow];
        AnnonceController * annonceController = [segue destinationViewController];
        annonceController.annonce = [self.annonces objectAtIndex : selectedRowIndex.row];
    }
}


@end
