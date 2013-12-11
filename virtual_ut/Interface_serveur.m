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

@interface Interface_serveur()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation Interface_serveur

@synthesize responseData = _responseData;

-(void)initConnexion : (NSString *)login withPassword :(NSString*)password fromViewController:(LoginController *)viewController
{
    self.view = [[LoginController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * myURL = (NSString *)[NSString stringWithFormat:@"http://localhost:8888/Web\uFF05Service/appliVUT/login.php?login=%@&password=%@", login, password];
    NSLog(myURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString: myURL]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    [self.view getResponseFromServeur : YES];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];

    Etudiant * etudiant = [[Etudiant alloc]init];
    etudiant.prenom = [res objectForKey:@"prenom"];
    etudiant.nom = [res objectForKey:@"nom"];
    etudiant.ecole = [res objectForKey:@"UT"];
    etudiant.tel = [res objectForKey:@"telephone"];
    etudiant.credits = [[res objectForKey:@"creditVUTs"]intValue];
    etudiant.token = [[res objectForKey:@"token"]intValue];
    
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant = etudiant;

    [self.view getResponseFromServeur : [[res objectForKey:@"error"]boolValue]];
    //[self.view getResponseFromServeur : NO];

    
}

@end
