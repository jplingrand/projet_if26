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

@interface AnnonceController ()

@end

@implementation AnnonceController

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
	// Do any additional setup after loading the view.
    self.listeMessages.dataSource = self;
    self.listeMessages.delegate = self;
    self.annonce = [[Annonce alloc]init];
    [self loadInitialData];
    self.titre.text = self.annonce.titre;
    self.texte.text = self.annonce.texte;
    self.prix.text = [NSString stringWithFormat:@"%d",self.annonce.prix];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadInitialData {
    Message *item1 = [[Message alloc] init];
    item1.login = @"jacky";
    item1.texte = @"trop cher";
    [self.annonce.messages addObject:item1];
    
    Message *item2 = [[Message alloc] init];
    item2.login = @"jacky";
    item2.texte = @"je like";
    [self.annonce.messages addObject:item2];
    
    Message *item3 = [[Message alloc] init];
    item3.login = @"jacky";
    item3.texte = @"c bueno";
    [self.annonce.messages addObject:item3];
    
    self.annonce.titre = @"cours anglais";
    self.annonce.texte = @"pas cher je suis bilingue";
    self.annonce.prix = 11;
    
}

- (IBAction)boutonAcheter:(id)sender {
}

- (IBAction)boutonNouveauMessage:(id)sender {
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
    Message *message = [self.annonce.messages objectAtIndex:indexPath.row];
    cell.texte.text = message.texte;
    cell.login.text = message.login;
    return cell;
}
@end
