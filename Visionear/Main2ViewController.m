//
//  Main2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main2ViewController.h"

@interface Main2ViewController ()

@end

@implementation Main2ViewController

UIAlertView *alert2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIAlertView
    alert2 = [[UIAlertView alloc] initWithTitle:@"Envoi de la commande en cours.\nVeuillez patienter..."message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert2 show];
    
    NSError *error = nil;
    NSData *json;
    NSURL *url = [NSURL URLWithString:@"http://10.35.23.1"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIRectEdge)edgesForExtendedLayout
{
    return [super edgesForExtendedLayout] ^ UIRectEdgeBottom;
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Erreur ===>  %@  <====== Fin Erreur", error);
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response{
    NSLog(@"Reponse Serveur ===> %@", response);
    [alert2 dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView * responseAlert;
    
    if ([response statusCode] == 201) {
        responseAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Commande envoyée avec succès." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    else{
        responseAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Envoi de la commande échouée." delegate:self cancelButtonTitle:@"Réessayer" otherButtonTitles: nil];
    }
    [responseAlert show];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"DATA RECEIVED : ");
    NSString *myResponseReadable = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myResponseReadable);
    
}
// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Fini de transmettre les données");
    [alert2 dismissWithClickedButtonIndex:0 animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
