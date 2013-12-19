//
//  ListeTransactionsViewController.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 19/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListeTransactionsViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *transactionsTableView;
@property NSMutableArray * transactions;
@end
