//
//  NouvelleAnnonceController.h
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

// View controller responsable de la vue pour poster une nouvelle annonce

#import <UIKit/UIKit.h>

@interface NouvelleAnnonceController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate,UITextFieldDelegate>

// Elements graphiques
    @property (strong, nonatomic) IBOutlet UIPickerView * pickerCategories;
    @property (weak, nonatomic) IBOutlet UITextField * titre;
    @property (weak, nonatomic) IBOutlet UITextField * prix;
    @property (weak, nonatomic) IBOutlet UITextView * contenu;
    @property(strong,nonatomic) NSArray * categories;

    // scrollview pour afficher les messages
    @property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// Elements pour gérer le centrage de vue quand le clavier est sorti
@property  IBOutlet UITextField *activeField;
@property  IBOutlet UITextView *activeView;

// fonction appellée par l'instance serveur quand réponse (réponse = error)
-(void) getResponseFromServeur : (BOOL) reponse;

-(IBAction)textFieldReturn:(id)sender ;
-(IBAction)actionPoster:(id)sender;

@end
