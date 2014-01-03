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
#import "ListeAnnoncesController.h"

@interface RechercheController ()
@property IBOutlet UITextField * activeField;
@end

@implementation RechercheController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // on indique que c'est le view controller qui va gérer le comportement et les données du scrollview
    self.pickerCategories.dataSource = self;
    self.pickerCategories.delegate = self;
    
    // initialisation de la liste des catégories depuis la var globale listeCategorie dans le appDelegate
    self.categories = [[NSArray alloc]init];
    self.categories = ((AppDelegate *)[UIApplication sharedApplication].delegate).listeCategories;
    
    // on rafraichi le scrollview
    [self.pickerCategories reloadAllComponents];

    [self registerForKeyboardNotifications];

}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
-(void) viewDidAppear:(BOOL)animated
{
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 910)];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
            CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y+kbSize.height/2);
            [self.scrollView setContentOffset:scrollPoint animated:YES];
        }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)unwindToConnexion:(UIStoryboardSegue *)segue
{
    
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (sender == self.boutonRechercher)
    {
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
    // si aucun resultat on averti
    if ([self.tabBar.listeAnnonces count]==0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"aucun resultat", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    // Sinon on va vers la page des résultats
    }else{
        [self performSegueWithIdentifier:@"segueVersResultats" sender:self];
    }
}

@end
