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
    self.titre.delegate = self;
    self.contenu.delegate = self;
    self.prix.delegate = self;
    
    [self registerForKeyboardNotifications];
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
    type = @"offre";

    NSString * categorie = [self.categories objectAtIndex:[self.pickerCategories selectedRowInComponent:0]];
    NSString * titre = self.titre.text;
    NSString * texte = self.contenu.text;
    NSString * prix = self.prix.text;
    
    if([titre length]>0 && [texte length]>0 && [prix length]>0&&[prix intValue]!=0){
        [[Interface_serveur alloc]initAnnonce:self withType:type withTitle:titre withTexte:texte withCategorie:categorie withPrix:prix];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Completez les champs correctement", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }

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

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if(self.activeField){
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height/2);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    }else if(self.activeView){
        CGPoint scrollPoint = CGPointMake(0.0, self.activeView.frame.origin.y-kbSize.height/2);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeView = textView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.activeView = nil;
}

-(void) getResponseFromServeur : (BOOL) reponse
{
    if(!reponse)
    {

        self.titre.text = @"";
        self.contenu.text = @"";
        self.prix.text=@"";
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Votre annonce a bien été publiée, retrouvez la dans 'mes annonces'", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erreur", @"") message:NSLocalizedString(@"Erreur de connexion", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
