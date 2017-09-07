//
//  ViewController.m
//  BackNote
//
//  Created by Max von Hippel on 11/10/13.
//  Copyright (c) 2013 Max von Hippel. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController
@synthesize fontSizeSlider, noteTextView, backgroundButton, backgroundImage, alphaSlider, cancelButton, backdropButton, keyButton;// iButton;

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
    
    UIColor *dominantColor = [self getDominantColor:image];
    NSLog(@"%@ dominant", dominantColor);
    
    
    if (dominantColor == [UIColor colorWithWhite:1 alpha:1]) {
        UIColor *newColor = [UIColor blackColor];
        NSLog(@"%@ newColor", newColor);
        [noteTextView setTextColor:newColor];
    }
    else {
    const CGFloat *componentColors = CGColorGetComponents(dominantColor.CGColor);
    UIColor *newColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                               green:(1.0 - componentColors[1])
                                                blue:(1.0 - componentColors[2])
                                               alpha:componentColors[3]];
        NSLog(@"%@ newColor", newColor);
        [noteTextView setTextColor:newColor];
    }
    
    
}
- (IBAction) cancelBacknote:(UIButton *)sender {
    [noteTextView resignFirstResponder];
    
    noteTextView.font = [noteTextView.font fontWithSize:15];
    
    noteTextView.text = @"";
}
- (IBAction) startImageCapture:(UIButton *)sender {
    [noteTextView resignFirstResponder];
    fontSizeSlider.alpha = 0;
    backgroundButton.alpha = 0;
    alphaSlider.alpha = 0;
    backdropButton.alpha = 0;
    cancelButton.alpha = 0;
    keyButton.alpha = 0;
    //iButton.alpha = 0;
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
    //iButton.alpha = 1;
}
struct pixel {
    unsigned char r, g, b, a;
};

- (UIColor*) getDominantColor:(UIImage*)image
{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    
    
    // Allocate a buffer big enough to hold all the pixels
    
    struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
    if (pixels != nil)
    {
        
        CGContextRef context = CGBitmapContextCreate(
                                                     (void*) pixels,
                                                     image.size.width,
                                                     image.size.height,
                                                     8,
                                                     image.size.width * 4,
                                                     CGImageGetColorSpace(image.CGImage),
                                                     (CGBitmapInfo)kCGImageAlphaPremultipliedLast
                                                     );
        //CGBitmapInfo bitmapInfo = (CGBitmapInfo) kCGImageAlphaPremultipliedLast;
        
        if (context != NULL)
        {
            // Draw the image in the bitmap
            
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
            
            // Now that we have the image drawn in our own buffer, we can loop over the pixels to
            // process it. This simple case simply counts all pixels that have a pure red component.
            
            // There are probably more efficient and interesting ways to do this. But the important
            // part is that the pixels buffer can be read directly.
            
            NSUInteger numberOfPixels = image.size.width * image.size.height;
            for (int i=0; i<numberOfPixels; i++) {
                red += pixels[i].r;
                green += pixels[i].g;
                blue += pixels[i].b;
            }
            
            
            red /= numberOfPixels;
            green /= numberOfPixels;
            blue/= numberOfPixels;
            
            
            CGContextRelease(context);
        }
        
        free(pixels);
    }
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

