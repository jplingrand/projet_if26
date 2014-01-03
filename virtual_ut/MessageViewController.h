//
//  MessageViewController.h
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 19/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//
// Affiche une un champ de texte avec boutons poster/annuler pour le postage de message sur annonce
#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textViewMessage;
@property int idAnnonce;
@property (weak, nonatomic) IBOutlet UIButton *boutonPoster;
@property Message * message;
-(void)getResponseFromServeur : (BOOL) reponse;

@end
