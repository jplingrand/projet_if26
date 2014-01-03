//
//  RechercheController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//
// View controller responsable de la vue de recherche d'annonce

#import <UIKit/UIKit.h>

@interface RechercheController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>

// Les éléments graphiques
@property (strong, nonatomic) IBOutlet UIPickerView * pickerCategories;
@property (weak, nonatomic) IBOutlet UITextField *prixMin;
@property (weak, nonatomic) IBOutlet UITextField *prixMax;
@property (weak, nonatomic) IBOutlet UITextField *champRecherche;
@property (weak, nonatomic) IBOutlet UIButton *boutonRechercher;

// Le scroll view pour les catégories
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// La liste des catégories
@property(strong,nonatomic) NSArray * categories;

// Pour cacher le clavier
-(IBAction)textFieldReturn:(id)sender;

// Fonction appellée par l'instance serveur quand réponse, réponse = error
-(void) getResponseFromServeur : (BOOL) reponse;

@end
