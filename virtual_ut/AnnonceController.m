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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
