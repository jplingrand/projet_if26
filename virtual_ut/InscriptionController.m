//
//  InscriptionController.m
//  virtual_ut
//
//  Created by if26 on 03/12/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "InscriptionController.h"

@interface InscriptionController ()

@end

@implementation InscriptionController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (sender == self.boutonInscription)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Succès", @"") message:NSLocalizedString(@"Inscription réussie", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for segue");
}

@end
