//
//  ViewController.m
//  BackNote HD
//
//  Created by Max von Hippel on 12/3/13.
//  Copyright (c) 2013 Max von Hippel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize fontSizeSlider, noteTextView, backgroundButton, backgroundImage, alphaSlider, cancelButton, backdropButton, keyButton, fontButton1,fontButton2,fontButton3, fontLabel;

- (void)viewDidLoad
{
    UIButton *button = backdropButton;
    [button setTag:1234];
    
    [button addTarget:self action:@selector(makeUIImagePickerControllerForCamera:) forControlEvents:UIControlEventTouchUpInside];
    noteTextView.delegate = self;
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction) fontSizeSliderValueChanged:(UISlider *)sender {
    noteTextView.font = [noteTextView.font fontWithSize:sender.value];
}
- (IBAction) alphaSliderValueChanged:(UISlider *)sender {
    backgroundImage.alpha = sender.value;
}
- (IBAction) keyDown:(UIButton *)sender {
    [noteTextView resignFirstResponder];
}

- (void) makeUIImagePickerControllerForCamera:(BOOL)camera {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [picker setMediaTypes:[NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil]];
    
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Dismiss the picker
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Get the image from the result
    UIImage* image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    
    backgroundImage.image = image;
}
- (IBAction) cancelBacknote:(UIButton *)sender {
    [noteTextView resignFirstResponder];
    
    noteTextView.font = [noteTextView.font fontWithSize:15];
    
    noteTextView.text = @"";
}
- (IBAction) font1:(UIButton *)sender {
    noteTextView.font = [UIFont fontWithName:@"Courier" size:16.0];
}
- (IBAction) font2:(UIButton *)sender{
    noteTextView.font = [UIFont fontWithName:@"Optima" size:16.0];
}
- (IBAction) font3:(UIButton *)sender{
    noteTextView.font = [UIFont fontWithName:@"Arial" size:16.0];
}
- (IBAction) startImageCapture:(UIButton *)sender {
    [noteTextView resignFirstResponder];
    fontSizeSlider.alpha = 0;
    backgroundButton.alpha = 0;
    alphaSlider.alpha = 0;
    backdropButton.alpha = 0;
    cancelButton.alpha = 0;
    keyButton.alpha = 0;
    
    
    fontLabel.alpha = 0;
    fontButton3.alpha = 0;
    fontButton2.alpha = 0;
    fontButton1.alpha = 0;
    //overlaySlider.alpha = 0;
    //overlayImage.alpha = 0;
    //overlayButton.alpha = 0;
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                             target:self
                                           selector:@selector(handleTimer:)
                                           userInfo:nil
                                            repeats:NO];
}
-(void)handleTimer: (NSTimer *) timer
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(screenShotimage, nil, nil, nil);
    UIGraphicsEndImageContext();
    NSTimer *timer2;
    timer2 = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                              target:self
                                            selector:@selector(handleTimer2:)
                                            userInfo:nil
                                             repeats:NO];
}
-(void)handleTimer2: (NSTimer *) timer2 {
    fontSizeSlider.alpha = 1;
    backgroundButton.alpha = 1;
    alphaSlider.alpha = 1;
    backdropButton.alpha = 1;
    cancelButton.alpha = 1;
    keyButton.alpha = 1;
    fontButton1.alpha = 1;
    fontButton2.alpha = 1;
    fontButton3.alpha = 1;
    fontLabel.alpha = 1;
    //overlayButton.alpha = 1;
    //overlayImage.alpha = 1;
    //overlaySlider.alpha = 1;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end