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
#import "Annonce.h"
#import "Message.h"
#import "AnnonceController.h"

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
    NSString * stringURL = [NSString stringWithFormat:@"http://localhost:8888/Web%%20Service/appliVUT/login.php?login=%@&password=%@",login,password];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];

    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)initInscription : (InscriptionController *) viewController withNom : (NSString *) nom withPrenom : (NSString *) prenom withEmail : (NSString* ) email withTel : (NSString *) tel withEcole :(NSString *) ecole withLogin : (NSString*) login withPassword : (NSString *) password
{
    self.view = [[InscriptionController alloc]init];
    self.view = viewController;
    
    self.responseData = [NSMutableData data];
    
   NSString * stringURL = [NSString stringWithFormat:@"http://localhost:8888/Web%%20Service/appliVUT/inscription.php?login=%@&password=%@&nom=%@&prenom=%@&UT=%@&telephone=%@&email=%@", login, password,nom,prenom,ecole,tel,email];
 
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void) initAnnonce : (NouvelleAnnonceController * ) viewController withType :(NSString*)type withTitle : (NSString * )titre withTexte:(NSString*)texte withCategorie : (NSString *)categorie withPrix:(NSString*) prix
{
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    
    self.responseData = [NSMutableData data];
    
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    
    titre = [titre stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    texte = [texte stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/posterAnnonce.php?categorie=%@&titre=%@&texte=%@&type=offre&prix=%@&token=%@",categorie,titre,texte,prix,token];
    
   NSURL * myURL = [NSURL URLWithString:stringURL];
    
   NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
   [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)initRecherche : (RechercheController * ) viewController withCategorie : (NSString * )categorie withPrixMin : (NSString *) prixMin withPrixMax : (NSString*)prixMax withMotsCles : (NSString*)motsCles
{
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;

    if(!prixMin){
        prixMin=[NSString stringWithFormat:@"%d",0];
    }
    if(!prixMax) {
        prixMax=[NSString stringWithFormat:@"%d",1000];
    }
    
    if(!motsCles){
        motsCles = @"";
    }else{
        motsCles = [motsCles stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    }
    
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/recherche.php?token=%@&categorie=%@&prixMin=%@&prixMax=%@&mot-cles=%@",token,categorie,prixMin,prixMax,motsCles];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)initNouveauMessage : (AnnonceController*)viewController withMessage :(NSString *) message forAnnonce: (int) idAnnonce
{
    self.requete = [[NSString alloc]init];
    self.requete = @"nouveauMessage";
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    message = [message stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/posterMessage.php?token=%@&texte=%@&idAnnonce=%@",token,message,[NSString stringWithFormat:@"%d",idAnnonce]];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
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
    [(LoginController *)self.view getResponseFromServeur : YES];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];

    if([self.view isKindOfClass:[LoginController class]]){
        
        Etudiant * etudiant = [[Etudiant alloc]init];
        
        etudiant.prenom = [res objectForKey:@"prenom"];
        etudiant.nom = [res objectForKey:@"nom"];
        etudiant.ecole = [res objectForKey:@"UT"];
        etudiant.tel = [res objectForKey:@"telephone"];
        etudiant.credits = [[res objectForKey:@"creditVUTs"]intValue];
        etudiant.token = [res objectForKey:@"token"];

        ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant = etudiant;
    
        [(LoginController *) self.view getResponseFromServeur : [[res objectForKey:@"error"]boolValue]];
        
    }else if([self.view isKindOfClass:[InscriptionController class]])
    {
        [(InscriptionController *) self.view getResponseFromServeur : [[res objectForKey:@"error"]boolValue]];

    }else if ([self.view isKindOfClass:[NouvelleAnnonceController class]])
    {
        [(NouvelleAnnonceController *) self.view getResponseFromServeur : [[res objectForKey:@"error"]boolValue]];
    }else if ([self.view isKindOfClass:[RechercheController class]])
    {
        NSMutableArray * listeJsonAnnonces = [[NSMutableArray alloc] init];
        NSMutableArray * listeAnnonces = [[NSMutableArray alloc] init];
        listeJsonAnnonces = [res objectForKey:@"annonces"];
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSLog(@"%@",listeJsonAnnonces);
        
        for (int i = 0; i<[listeJsonAnnonces count]; i++) {
            
            Annonce * annonce= [[Annonce alloc]init];
            
            annonce.titre = [listeJsonAnnonces[i] objectForKey:@"titre"];
            annonce.id = [[listeJsonAnnonces[i] objectForKey:@"idAnnonce"]intValue];
            annonce.date = [formatter dateFromString:[listeJsonAnnonces[i] objectForKey:@"date"]];
            annonce.prix = [[listeJsonAnnonces[i] objectForKey:@"prix"]intValue];
            annonce.texte = [listeJsonAnnonces[i] objectForKey:@"texte"];
            annonce.categorie = [listeJsonAnnonces[i] objectForKey:@"categorie"];
            annonce.login = [[listeJsonAnnonces[i] objectForKey:@"infosAnnonceur"][0] objectForKey:@"login"];
            annonce.ecole = [[listeJsonAnnonces[i] objectForKey:@"infosAnnonceur"][0] objectForKey:@"UT"];
            
            
            NSMutableArray * listeJsonMessages = [[NSMutableArray alloc] init];
            listeJsonMessages = [listeJsonAnnonces[i] objectForKey:@"messages"];
            for (int j = 0; j<[listeJsonMessages count]; j++) {
                Message * message = [[Message alloc]init];
                message.texte = [listeJsonMessages[j] objectForKey:@"texte"];
                message.login = [[listeJsonMessages[j] objectForKey:@"infosEmetteur"][0] objectForKey:@"login"];
                message.ecole = [[listeJsonMessages[j] objectForKey:@"infosEmetteur"][0] objectForKey:@"UT"];
                message.date = [formatter dateFromString:[listeJsonMessages[j] objectForKey:@"date"]];
                [annonce.messages addObject:message];
            }
            
            [listeAnnonces addObject:annonce];
        }
        ((AppDelegate *)[UIApplication sharedApplication].delegate).listeAnnonces = listeAnnonces;
        [(RechercheController *) self.view getResponseFromServeur : [[res objectForKey:@"error"]boolValue]];
    }
}

@end
