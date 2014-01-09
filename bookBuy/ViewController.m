//
//  ViewController.m
//  bookBuy
//
//  Created by Joe437 on 2013/12/29.
//  Copyright (c) 2013年 Joe437. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTextView.text=@"";
    self.myTextView.editable=NO;
    
    NSURL *myURL=[NSURL URLWithString:@"http://10.211.55.7/find/"];
    NSXMLParser *myParser=[[NSXMLParser alloc]initWithContentsOfURL:myURL];
    
    myParser.delegate=self;
    
    [myParser parse];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    nowTagStr=[NSString stringWithString:@""];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"li"]) {
        nowTagStr=[NSString stringWithString:elementName];
        txtBuffer=[NSString stringWithString:@""];
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
   
    if ([nowTagStr isEqualToString:@"li"]) {
        txtBuffer=[txtBuffer stringByAppendingString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"li"]) {
        self.myTextView.text=[self.myTextView.text stringByAppendingFormat:@"\n 找到：%@ 書\n",txtBuffer];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(id)sender {
    [self.view endEditing:YES];
    
    NSString *searchInput =self.searchTextField.text;
    
    NSString *queryString =[NSString stringWithFormat:@"q=%@",searchInput];
    NSString *url = [@"http://10.211.55.7/find?" stringByAppendingString:queryString];
    NSMutableURLRequest *myURLReQ=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    myURLReQ.HTTPMethod=@"get";
    [NSURLConnection sendAsynchronousRequest:myURLReQ queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        NSLog(@"result %@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSXMLParser *myParser=[[NSXMLParser alloc]initWithData:data];
        myParser.delegate=self;
        
        [myParser parse];
    }];
    
    
}
@end
