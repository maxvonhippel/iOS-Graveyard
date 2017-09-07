//
//  ViewController.h
//  BackNote HD
//
//  Created by Max von Hippel on 12/3/13.
//  Copyright (c) 2013 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    IBOutlet UISlider *fontSizeSlider;
    IBOutlet UITextView *noteTextView;
    IBOutlet UIButton *backgroundButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UISlider *alphaSlider;
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIButton *backdropButton;
    IBOutlet UIButton *keyButton;
    
    
    IBOutlet UILabel *fontLabel;
    IBOutlet UIButton *fontButton1;
    IBOutlet UIButton *fontButton2;
    IBOutlet UIButton *fontButton3;
    
        
    
}
@property (nonatomic, retain) IBOutlet UISlider *fontSizeSlider;
@property (nonatomic, retain) IBOutlet UITextView *noteTextView;
@property (nonatomic, retain) IBOutlet UIButton *backgroundButton;
@property (nonatomic, retain) IBOutlet UIButton *backdropButton;
@property (nonatomic, retain) IBOutlet UISlider *alphaSlider;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) IBOutlet UIButton *keyButton;


@property (nonatomic, retain) IBOutlet UILabel *fontLabel;
@property (nonatomic, retain) IBOutlet UIButton *fontButton1;
@property (nonatomic, retain) IBOutlet UIButton *fontButton2;
@property (nonatomic, retain) IBOutlet UIButton *fontButton3;



- (IBAction) alphaSliderValueChanged:(id)sender;
- (IBAction) fontSizeSliderValueChanged:(id)sender;
- (IBAction) startImageCapture:(id)sender;
- (IBAction) cancelBacknote:(id)sender;
- (IBAction) keyDown:(id)sender;

- (IBAction) font1:(id)sender;
- (IBAction) font2:(id)sender;
- (IBAction) font3:(id)sender;




@end
