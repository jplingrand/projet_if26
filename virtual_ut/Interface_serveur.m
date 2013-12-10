//
//  Interface_serveur.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "Interface_serveur.h"
#import "AppDelegate.h"
#import "Etudiant.h"

@implementation Interface_serveur


-(id)initConnexion : (NSString *) login withPassword :(NSString*)password fromViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        self.viewController = [[UIViewController alloc]init];
        self.viewController = viewController;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:@"http://localhost:8888/Web%20Service/appliVUT/login.php?login=test&password=password"]];
        
        
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
            /*
            Etudiant * etudiant = [[Etudiant alloc]init];
            etudiant.prenom = @"jacky";
            etudiant.nom = @"josiane";
           
            ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant = etudiant;
             NSError *error;
             NSMutableDictionary *infosEtudiant = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             if( error )
             {
             NSLog(@"%@", [error localizedDescription]);
             }
             else {
             
             NSLog(@"Token: %@", infosEtudiant[@"token"] );
             }
       */
            
            [self.viewController performSegueWithIdentifier:@"unlock" sender:self.viewController];
           
           
            
        }];
        

        
    }
    return self;
}


@end
