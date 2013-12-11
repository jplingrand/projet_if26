//
//  CompteController.m
//  virtual_ut
//
//  Created by if26 on 26/11/13.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "CompteController.h"
#import "TabBarController.h"
#import "UIViewController+TabBar.h"

@interface CompteController ()

@end

@implementation CompteController

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
    self.prenom.text = self.tabBar.etudiant.prenom;
    self.nom.text = self.tabBar.etudiant.nom;
    self.tel.text = self.tabBar.etudiant.tel;
    self.ecole.text = self.tabBar.etudiant.ecole;
    self.credits.text = [NSString stringWithFormat:@"%d", self.tabBar.etudiant.credits ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
