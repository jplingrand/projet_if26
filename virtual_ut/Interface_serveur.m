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
#import "Transaction.h"

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
    categorie = [categorie stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    titre = [titre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    texte = [texte stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/posterAnnonce.php?categorie=%@&titre=%@&texte=%@&type=offre&prix=%@&token=%@",categorie,titre,texte,prix,token];
    
   NSURL * myURL = [NSURL URLWithString:stringURL];
    
   NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
   [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)initRecherche : (RechercheController * ) viewController withCategorie : (NSString * )categorie withPrixMin : (NSString *) prixMin withPrixMax : (NSString*)prixMax withMotsCles : (NSString*)motsCles
{
    ((AppDelegate *)[UIApplication sharedApplication].delegate).type = @"recherche";
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
        motsCles = [motsCles stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    NSLog(@"recherche par categorie avant encoding : %@",categorie);
    categorie = [categorie stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",categorie);
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/recherche.php?token=%@&categorie=%@&prixMin=%@&prixMax=%@&mot-cles=%@",token,categorie,prixMin,prixMax,motsCles];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)initNouveauMessage : (MessageViewController*)viewController withMessage :(NSString *) message forAnnonce: (int) idAnnonce
{
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    message = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/posterMessage.php?token=%@&texte=%@&idAnnonce=%@",token,message,[NSString stringWithFormat:@"%d",idAnnonce]];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void) initAchat : (AnnonceController * )viewController withAnnonce : (int) idAnnonce
{
    self.requete = [[NSString alloc]init];
    self.requete = @"achat";
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    
    NSLog(@"achat avec token : %@ et idAnnonce : %d",token,idAnnonce);
    
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/demarrerTransaction.php?token=%@&idAnnonce=%d",token,idAnnonce];
 
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
-(void) initMesAnnonces : (MonCompteRootViewController*) viewController
{
    self.requete = [[NSString alloc]init];
    self.requete = @"mes annonces";
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    NSLog(@"token : %@",token);
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/mesAnnonces.php?token=%@",token];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)initMesTransactions:(MonCompteRootViewController *)viewController
{
    self.requete = [[NSString alloc]init];
    self.requete = @"mes transactions";
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    NSLog(@"token : %@",token);
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/mesTransactions.php?token=%@",token];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
   
}

-(void) annulerAnnonce : (AnnonceController *) viewController withIdAnnonce : (int) id
{
    self.requete = [[NSString alloc]init];
    self.requete = @"annulation";
    self.view = [[NouvelleAnnonceController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    NSLog(@"token : %@",token);
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/annulerAnnonce.php?token=%@&idAnnonce=%d",token,id];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void) annulerTransaction :(TransactionController *)viewController withIdTransaction : (int) id
{
    self.requete = [[NSString alloc]init];
    self.requete = @"annulation";
    self.view = [[TransactionController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    NSLog(@"token : %@",token);
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/annulerTransaction.php?token=%@&idTransaction=%d",token,id];
    
    NSURL * myURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];

}

-(void) validerTransaction :(TransactionController *)viewController withIdTransaction : (int) id withCode : (NSString *) code
{
    self.requete = [[NSString alloc]init];
    self.requete = @"validation";
    self.view = [[TransactionController alloc]init];
    self.view = viewController;
    self.responseData = [NSMutableData data];
    NSString * token = ((AppDelegate *)[UIApplication sharedApplication].delegate).etudiant.token;
    NSLog(@"token : %@",token);
    NSString * stringURL = [NSString stringWithFormat: @"http://localhost:8888/Web%%20Service/appliVUT/validerTransaction.php?token=%@&idTransaction=%d&codeValidation=%@",token,id,code];
    
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
    NSLog(@"Connection failed: %@", [error description]);
    [(LoginController *)self.view getResponseFromServeur : YES];
}

-(NSMutableArray*)jsonAnnoncesToAnnonces : (NSMutableArray *) listeJsonAnnonces
{
    NSMutableArray * listeAnnonces = [[NSMutableArray alloc]init];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    for (int i = 0; i<[listeJsonAnnonces count]; i++) {
        
        Annonce * annonce= [[Annonce alloc]init];
        
        annonce.titre = [listeJsonAnnonces[i] objectForKey:@"titre"];
        
        annonce.id = [[listeJsonAnnonces[i] objectForKey:@"idAnnonce"]intValue];
        annonce.date = [formatter dateFromString:[listeJsonAnnonces[i] objectForKey:@"date"]];
        annonce.prix = [[listeJsonAnnonces[i] objectForKey:@"prix"]intValue];
        annonce.texte = [listeJsonAnnonces[i] objectForKey:@"texte"];
        annonce.categorie = [listeJsonAnnonces[i] objectForKey:@"categorie"];
        annonce.valide = [[listeJsonAnnonces[i] objectForKey:@"valide"] boolValue];
        annonce.idVendeur=[[listeJsonAnnonces[i] objectForKey:@"refEtudiant"]intValue];

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
    
    return listeAnnonces;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if([self.view isKindOfClass:[LoginController class]]){
        NSLog(@"%@",res);
        Etudiant * etudiant = [[Etudiant alloc]init];
        
        etudiant.prenom = [res objectForKey:@"prenom"];
        etudiant.nom = [res objectForKey:@"nom"];
        etudiant.ecole = [res objectForKey:@"UT"];
        etudiant.tel = [res objectForKey:@"telephone"];
        etudiant.credits = [[res objectForKey:@"creditVUTs"]intValue];
        etudiant.token = [res objectForKey:@"token"];
        etudiant.id =[[res objectForKey:@"idEtudiant"]intValue];
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
     
        NSMutableArray * listeAnnonces = [[NSMutableArray alloc] init];

        listeAnnonces = [self jsonAnnoncesToAnnonces:[res objectForKey:@"annonces"]];
        
        ((AppDelegate *)[UIApplication sharedApplication].delegate).listeAnnonces = listeAnnonces;
        
        [(RechercheController *) self.view getResponseFromServeur : [[res objectForKey:@"error"]boolValue]];
        
    }else if ([self.view isKindOfClass:[MessageViewController class]])
    {
        [(MessageViewController *) self.view getResponseFromServeur : [[res objectForKey:@"error"]boolValue]];
    }else if ([self.view isKindOfClass:[AnnonceController class]])
    {
        if([self.requete isEqualToString:@"achat"]){
            [(AnnonceController *) self.view achatWithError : [[res objectForKey:@"error"]boolValue]];
        }else if([self.requete isEqualToString:@"annulation"]){
            [(AnnonceController *) self.view annulationWithError : [[res objectForKey:@"error"]boolValue]];
        }
    }
    else if ([self.view isKindOfClass:[MonCompteRootViewController class]])
    {
        NSLog(@"%@",res);
        if([self.requete isEqualToString:@"mes annonces"])
        {
            NSMutableArray * listeJsonAnnonces = [[NSMutableArray alloc] init];
            NSMutableArray * listeAnnonces = [[NSMutableArray alloc] init];
            listeJsonAnnonces = [res objectForKey:@"annonces"];
            listeAnnonces = [self jsonAnnoncesToAnnonces:listeJsonAnnonces];
            ((AppDelegate *)[UIApplication sharedApplication].delegate).listeAnnonces = listeAnnonces;
           [(MonCompteRootViewController *) self.view getResponseWithError : [[res objectForKey:@"error"]boolValue]];
        }else if([self.requete isEqualToString:@"mes transactions"])
        {
            NSMutableArray * listeJsonTransactionsAcheteur = [[NSMutableArray alloc] init];
          
            
            listeJsonTransactionsAcheteur = [res objectForKey:@"transactionsAcheteur"];
            NSMutableArray * listeTransactionsAcheteur = [[NSMutableArray alloc]init];
            
            for (int i=0; i< [listeJsonTransactionsAcheteur count]; i++) {
                Transaction * transaction = [[Transaction alloc]init];
                transaction.id = [[listeJsonTransactionsAcheteur[i] objectForKey:@"idTransaction"]intValue];
                transaction.titre = [listeJsonTransactionsAcheteur[i] objectForKey:@"titre"];
                transaction.idAcheteur =[[listeJsonTransactionsAcheteur[i] objectForKey:@"refAcheteur"]intValue];
                transaction.idVendeur =[[listeJsonTransactionsAcheteur[i] objectForKey:@"refVendeur"]intValue];
                transaction.statut =[listeJsonTransactionsAcheteur[i] objectForKey:@"statut"];
                transaction.etudiant = [self jsonEtudiantToEtudiant:[listeJsonTransactionsAcheteur[i] objectForKey:@"infosVendeur"][0]];
                transaction.prix = [[listeJsonTransactionsAcheteur[i] objectForKey:@"prix"]intValue];
                transaction.code = [listeJsonTransactionsAcheteur[i] objectForKey:@"codeValidation"];
                [listeTransactionsAcheteur addObject:transaction];
            }
            ((AppDelegate *)[UIApplication sharedApplication].delegate).transactionsAcheteur = listeTransactionsAcheteur;
            NSMutableArray * listeJsonTransactionsVendeur = [[NSMutableArray alloc] init];
            listeJsonTransactionsVendeur = [res objectForKey:@"transactionsVendeur"];
            NSMutableArray * listeTransactionsVendeur = [[NSMutableArray alloc]init];
            
            for (int i=0; i< [listeJsonTransactionsVendeur count]; i++) {
                Transaction * transaction = [[Transaction alloc]init];
                transaction.id = [[listeJsonTransactionsVendeur[i] objectForKey:@"idTransaction"]intValue];
                transaction.titre = [listeJsonTransactionsVendeur[i] objectForKey:@"titre"];
                transaction.idAcheteur =[[listeJsonTransactionsVendeur[i] objectForKey:@"refAcheteur"]intValue];
                transaction.idVendeur =[[listeJsonTransactionsVendeur[i] objectForKey:@"refVendeur"]intValue];
                transaction.statut =[listeJsonTransactionsVendeur[i] objectForKey:@"statut"];
                transaction.etudiant = [self jsonEtudiantToEtudiant:[listeJsonTransactionsVendeur[i] objectForKey:@"infosAcheteur"][0]];
                                transaction.prix = [[listeJsonTransactionsVendeur[i] objectForKey:@"prix"]intValue];
                [listeTransactionsVendeur addObject:transaction];
            }
            ((AppDelegate *)[UIApplication sharedApplication].delegate).transactionsVendeur = listeTransactionsVendeur;
            [(MonCompteRootViewController *) self.view getResponseWithError : [[res objectForKey:@"error"]boolValue]];
        }
    }else if ([self.view isKindOfClass:[TransactionController class]])
    {
        if([self.requete isEqualToString:@"annulation"]){
            [(TransactionController *) self.view annuleeWithError : [[res objectForKey:@"error"]boolValue]];
        }else if ([self.requete isEqualToString:@"validation"]){
            [(TransactionController *) self.view valideeWithError : [[res objectForKey:@"error"]boolValue]];
        }
    }

}

-(Etudiant *) jsonEtudiantToEtudiant : (NSDictionary *) jsonEtudiant
{
    Etudiant * etudiant = [[Etudiant alloc]init];
    etudiant.login = [jsonEtudiant objectForKey:@"login"];
    etudiant.nom = [jsonEtudiant objectForKey:@"nom"];
    etudiant.prenom = [jsonEtudiant objectForKey:@"prenom"];
    etudiant.tel  = [jsonEtudiant objectForKey:@"telephone"];
    etudiant.email  = [jsonEtudiant objectForKey:@"email"];
    etudiant.ecole = [jsonEtudiant objectForKey:@"UT"];
    return etudiant;
}

@end
