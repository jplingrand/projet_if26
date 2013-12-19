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
    if (self) {
        // custom init
    }
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
    // Dispose of any resources that can be recreated.
}
- (void)loadInitialData {
    NSString * type =  self.tabBar.type;
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
    }else{
        self.annonces = self.tabBar.listeAnnonces;
    }
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
/*
     AnnonceController *detailViewController = [[AnnonceController alloc] init];
     detailViewController.annonce = self.annonces[indexPath.row];
    // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
  */
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueVersAnnonce"]) {
        NSLog(@"prepare segue vers annonce");
        NSIndexPath * selectedRowIndex = [self.tableView indexPathForSelectedRow];
        AnnonceController * annonceController = [segue destinationViewController];
        annonceController.annonce = [self.annonces objectAtIndex : selectedRowIndex.row];
    }
}


@end
