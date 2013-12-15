//
//  RechercheController.h
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechercheController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView * pickerCategories;
@property (weak, nonatomic) IBOutlet UITextField *prixMin;
@property (weak, nonatomic) IBOutlet UITextField *prixMax;
@property (weak, nonatomic) IBOutlet UITextField *champRecherche;
@property (weak, nonatomic) IBOutlet UIButton *boutonRechercher;
@property(strong,nonatomic) NSArray * categories;
-(IBAction)textFieldReturn:(id)sender;
@end
