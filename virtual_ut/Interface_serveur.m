//
//  Interface_serveur.m
//  virtual_ut
//
//  Created by jean-philippe LINGRAND on 07/12/2013.
//  Copyright (c) 2013 jean-philippe LINGRAND. All rights reserved.
//

#import "Interface_serveur.h"

@implementation Interface_serveur
@synthesize responseData = _responseData;

  
- (id)initConnexion : (NSString *) type fromViewController:(UIViewController *)viewController
{
    NSLog(@"google");
    self = [super init];
    if (self) {
        self.viewController = [[UIViewController alloc]init];
        self.requetes = [[NSDictionary alloc]init];
        self.requetes = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"http://localhost:8888/web_service/authmobile.php?login=john&password=doe", @"inscription"
                         , nil];
        
        self.responseData = [NSMutableData data];
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:[self.requetes objectForKey:type]]];
        
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    return self;
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
        [self.viewController performSegueWithIdentifier:@"unlock" sender:self.viewController];
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
    
}

@end
