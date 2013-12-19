//
//  MessageViewController.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 19/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textViewMessage;
@property int idAnnonce;
-(void)getResponseFromServeur : (BOOL) reponse;
@property (weak, nonatomic) IBOutlet UIButton *boutonPoster;
@property Message * message;

@end
