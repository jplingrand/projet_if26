//
//  AnnonceCell.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 16/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnonceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titre;
@property (weak, nonatomic) IBOutlet UILabel *prix;
@property (weak, nonatomic) IBOutlet UILabel *ecole;
@property (weak, nonatomic) IBOutlet UILabel *date;
@end
