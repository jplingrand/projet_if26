//
//  NouvelleAnnonceController.m
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "NouvelleAnnonceController.h"
#import "AppDelegate.h"
#import "Interface_serveur.h"

@interface NouvelleAnnonceController ()

@end

@implementation NouvelleAnnonceController

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
    self.pickerCategories.dataSource = self;
    self.pickerCategories.delegate = self;
    self.categories = [[NSArray alloc]init];
    self.categories = ((AppDelegate *)[UIApplication sharedApplication].delegate).listeCategories;
    [self.pickerCategories reloadAllComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToConnexion:(UIStoryboardSegue *)segue
{
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.categories objectAtIndex:row];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.categories count];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)actionPoster:(id)sender {
    NSString * type = [[NSString alloc]init];
    if([self.boutonOffreDemande selectedSegmentIndex]==0){
        NSString * type = @"offre";
    }else{
        NSString * type = @"demande";
    }
    NSString * categorie = [self.categories objectAtIndex:[self.pickerCategories selectedRowInComponent:0]];
    NSString * titre = self.titre.text;
    NSString * texte = self.contenu.text;
    NSString * prix = self.prix.text;
    NSLog(type);
    [[Interface_serveur alloc]initAnnonce:self withType:type withTitle:titre withTexte:texte withCategorie:categorie withPrix:prix];
}

-(void) getResponseFromServeur : (BOOL) reponse
{
    NSLog(@"serveur ok: %@", reponse ? @"YES" : @"NO");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
