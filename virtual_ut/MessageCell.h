//
//  MessageCell.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 16/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *texte;
@property (weak, nonatomic) IBOutlet UILabel *login;

@end
