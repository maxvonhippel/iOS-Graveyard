//
//  ResultViewController.h
//  GDORK
//
//  Created by Max von Hippel on 8/17/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView* resultWebView;

@property (nonatomic) NSURL* webURl;

@end
