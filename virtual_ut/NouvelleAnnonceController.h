//
//  NouvelleAnnonceController.h
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NouvelleAnnonceController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView * pickerCategories;
@property (weak, nonatomic) IBOutlet UITextField * titre;
@property (weak, nonatomic) IBOutlet UITextField * prix;
@property (weak, nonatomic) IBOutlet UITextView * contenu;
@property(strong,nonatomic) NSArray * categories;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property  IBOutlet UITextField *activeField;
@property  IBOutlet UITextView *activeView;

-(void) getResponseFromServeur : (BOOL) reponse;

-(IBAction)textFieldReturn:(id)sender ;
- (IBAction)actionPoster:(id)sender;

@end
