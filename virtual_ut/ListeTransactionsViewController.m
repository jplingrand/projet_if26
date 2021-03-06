//
//  ListeTransactionsViewController.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 19/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "ListeTransactionsViewController.h"
#import "UIViewController+TabBar.h"
#import "Transaction.h"
#import "TransactionCell.h"
#import "TransactionController.h"
@interface ListeTransactionsViewController ()

@end

@implementation ListeTransactionsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.transactions = [[NSMutableArray alloc]init];
    [self loadInitialData];
}

-(void)loadInitialData
{
    // la var globale type indique le type d'infos à afficher
    // transactions vendeur ou acheteur
    NSString * type = self.tabBar.type;

    if([type isEqualToString:@"mesTransactionsVendeur"]||[type isEqualToString:@"mesTransactionsAcheteur"]){
        bool vendeur;
        if([type isEqualToString:@"mesTransactionsVendeur"]){
            vendeur = YES;
            self.title = @"transactions vendeur";
            self.transactions = self.tabBar.transactionsVendeur;
        }else{
            vendeur = NO;
            self.title = @"transactions acheteur";
            self.transactions = self.tabBar.transactionsAcheteur;
        }
    }
    [self.transactionsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.transactions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"transactionCell";
   TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Transaction * transaction = [self.transactions objectAtIndex:indexPath.row];
    cell.titre.text = transaction.titre;
    cell.prix.text = [ NSString stringWithFormat:@"%d",transaction.prix];
    cell.statut.text = transaction.statut;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"segueVersTransaction"]) {
        NSIndexPath * selectedIndexPathRow = [self.transactionsTableView indexPathForSelectedRow];
        TransactionController * view = [segue destinationViewController];
        view.transaction = [self.transactions objectAtIndex:selectedIndexPathRow.row];
    }
}
@end
