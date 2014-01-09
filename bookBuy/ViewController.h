//
//  ViewController.h
//  bookBuy
//
//  Created by Joe437 on 2013/12/29.
//  Copyright (c) 2013年 Joe437. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>{
    NSString *nowTagStr;
    NSString *txtBuffer;
}



- (IBAction)searchButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end
