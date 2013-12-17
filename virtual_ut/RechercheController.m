//
//  RechercheController.m
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "RechercheController.h"
#import "AppDelegate.h"
#import "Interface_serveur.h"

@interface RechercheController ()

@end

@implementation RechercheController 

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
    //self.pickerCategories = [[UIPickerView alloc]init];
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
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (sender == self.boutonRechercher)
    {
        NSLog(@"should perform segue result recherche");
        NSString * prixMin = [[NSString alloc]init];
        NSString * prixMax = [[NSString alloc]init];
        NSString * motsCles = [[NSString alloc]init];
        NSString * categorie = [[NSString alloc]init];
        
        if([self.prixMin.text length] > 0){
            prixMin = self.prixMin.text;
        }else{
            prixMin=[NSString stringWithFormat:@"%d",0];
        }
        
        if([self.prixMax.text length ]> 0){
            prixMax = self.prixMax.text;
        }else{
            prixMax = [NSString stringWithFormat:@"%d",1000];
        }

        if (self.champRecherche.text!=nil) {
            motsCles = self.champRecherche.text;
        }
        
        categorie = [self.categories objectAtIndex:[self.pickerCategories selectedRowInComponent:0]];

        if ([prixMin intValue]<[prixMax intValue])
        {
            [[Interface_serveur alloc]initRecherche:self withCategorie:categorie withPrixMin:prixMin withPrixMax:prixMax withMotsCles:motsCles];
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"le prix max est plus petit que le prix min", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alert show];
        }
    }
    return NO;
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void) getResponseFromServeur : (BOOL) reponse
{
    NSLog(@"serveur recherche annone getResponse avec error à: %@", reponse ? @"YES" : @"NO");
    if ([self.tabBar.listeAnnonces count]==0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"aucun resultat", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }else{
        [self performSegueWithIdentifier:@"segueVersResultats" sender:self];
    }
}

@end
