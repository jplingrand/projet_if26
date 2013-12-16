//
//  AnnonceController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Annonce.h"

@interface AnnonceController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titre;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *texte;
@property (weak, nonatomic) IBOutlet UILabel *prix;
@property (weak, nonatomic) IBOutlet UILabel *login;
- (IBAction)boutonAcheter:(id)sender;
- (IBAction)boutonNouveauMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *listeMessages;
@property Annonce * annonce;
@end
