//
//  ViewController.h
//  BackNote
//
//  Created by Max von Hippel on 11/10/13.
//  Copyright (c) 2013 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <Foundation/Foundation.h>
@interface ViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    IBOutlet UISlider *fontSizeSlider;
    IBOutlet UITextView *noteTextView;
    IBOutlet UIButton *backgroundButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UISlider *alphaSlider;
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIButton *backdropButton;
    IBOutlet UIButton *keyButton;
    //IBOutlet UIButton *iButton;
    
    
}
@property (nonatomic, retain) IBOutlet UISlider *fontSizeSlider;
@property (nonatomic, retain) IBOutlet UITextView *noteTextView;
@property (nonatomic, retain) IBOutlet UIButton *backgroundButton;
@property (nonatomic, retain) IBOutlet UIButton *backdropButton;
@property (nonatomic, retain) IBOutlet UISlider *alphaSlider;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) IBOutlet UIButton *keyButton;
//@property (nonatomic, retain) IBOutlet UIButton *iButton;
- (IBAction) alphaSliderValueChanged:(id)sender;
- (IBAction) fontSizeSliderValueChanged:(id)sender;
- (IBAction) startImageCapture:(id)sender;
- (IBAction) cancelBacknote:(id)sender;
- (IBAction) keyDown:(id)sender;
//- (UIColor *)newColor;
//- (UIColor *)mergedColor;

@end
