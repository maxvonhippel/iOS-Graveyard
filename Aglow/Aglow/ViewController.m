//
//  ViewController.m
//  Aglow
//
//  Created by Max von Hippel on 4/18/14.
//  Copyright (c) 2014 Max von Hippel Development. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize checkBoxBlueButton, checkBoxBluePurpleButton, checkBoxFadedButton, checkBoxGreenButton, checkBoxLightOrangeButton, checkBoxLightPinkButton, checkBoxOrangeButton, checkBoxPinkButton, checkBoxPurpleButton, sideSwitch, secondsLabel, secondsSlider, warningCIRCLE, colorImage, delayLabel, SCREENFLASH, exitButton, bluePurpleTimer, blueTimer, fadedTimer, greenTimer, lightOrangeTimer, lightPinkTimer, orangeTimer, pinkTimer, purpleTimer, initialTimer, startButton, flashLabel, screenLabel;



- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    checkBoxBlue = NO;
    checkBoxBluePurple = NO;
    checkBoxFaded = NO;
    checkBoxGreen = NO;
    checkBoxLightOrange = NO;
    checkBoxLightPink = NO;
    checkBoxOrange = NO;
    checkBoxPink = NO;
    checkBoxPurple = NO;
    SCREEN = YES;
    warningCIRCLE.alpha = 0;
    
    [exitButton setEnabled:NO];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkBoxBlueAction:(id)sender {
    if (checkBoxBlue == NO) {
        [checkBoxBlueButton setImage:[UIImage imageNamed:@"1circle.png"] forState:UIControlStateNormal];
        checkBoxBlueButton.alpha = 1;
        checkBoxBlue = YES;
        
       
    }
    
    else {
        [checkBoxBlueButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxBlueButton.alpha = 0.1;
        checkBoxBlue = NO;
    }
}
- (IBAction)checkBoxPurpleAction:(id)sender {
    if (checkBoxPurple == NO) {
        [checkBoxPurpleButton setImage:[UIImage imageNamed:@"2circle.png"] forState:UIControlStateNormal];
        checkBoxPurpleButton.alpha = 1;
        checkBoxPurple = YES;
    }
    
    else {
        [checkBoxPurpleButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxPurpleButton.alpha = 0.1;
        checkBoxPurple = NO;
    }
}
- (IBAction)checkBoxOrangeAction:(id)sender {
    if (checkBoxOrange == NO) {
        [checkBoxOrangeButton setImage:[UIImage imageNamed:@"3circle.png"] forState:UIControlStateNormal];
        checkBoxOrangeButton.alpha = 1;
        checkBoxOrange = YES;
    }
    
    else {
        [checkBoxOrangeButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxOrangeButton.alpha = 0.1;
        checkBoxOrange = NO;
    }
}
- (IBAction)checkBoxGreenAction:(id)sender {
    if (checkBoxGreen == NO) {
        [checkBoxGreenButton setImage:[UIImage imageNamed:@"4circle.png"] forState:UIControlStateNormal];
        checkBoxGreenButton.alpha = 1;
        checkBoxGreen = YES;
    }
    
    else {
        [checkBoxGreenButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxGreenButton.alpha = 0.1;
        checkBoxGreen = NO;
    }
}
- (IBAction)checkBoxFadedAction:(id)sender {
    if (checkBoxFaded== NO) {
        [checkBoxFadedButton setImage:[UIImage imageNamed:@"5circle.png"] forState:UIControlStateNormal];
        checkBoxFadedButton.alpha = 1;
        checkBoxFaded = YES;
    }
    
    else {
        [checkBoxFadedButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxFadedButton.alpha = 0.1;
        checkBoxFaded = NO;
    }
}
- (IBAction)checkBoxPinkAction:(id)sender {
    if (checkBoxPink == NO) {
        [checkBoxPinkButton setImage:[UIImage imageNamed:@"6circle.png"] forState:UIControlStateNormal];
        checkBoxPinkButton.alpha = 1;
        checkBoxPink = YES;
    }
    
    else {
        [checkBoxPinkButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxPinkButton.alpha = 0.1;
        checkBoxPink = NO;
    }
}
- (IBAction)checkBoxLightPinkAction:(id)sender {
    if (checkBoxLightPink == NO) {
        [checkBoxLightPinkButton setImage:[UIImage imageNamed:@"3circle.png"] forState:UIControlStateNormal];
        checkBoxLightPinkButton.alpha = 1;
        checkBoxLightPink = YES;
    }
    
    else {
        [checkBoxLightPinkButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxLightPinkButton.alpha = 0.1;
        checkBoxLightPink = NO;
    }
}
- (IBAction)checkBoxLightOrangeAction:(id)sender {
    if (checkBoxLightOrange == NO) {
        [checkBoxLightOrangeButton setImage:[UIImage imageNamed:@"1circle.png"] forState:UIControlStateNormal];
        checkBoxLightOrangeButton.alpha = 1;
        checkBoxLightOrange = YES;
    }
    
    else {
        [checkBoxLightOrangeButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxLightOrangeButton.alpha = 0.1;
        checkBoxLightOrange = NO;
    }
}
- (IBAction)checkBoxBluePurpleAction:(id)sender {
    if (checkBoxBluePurple == NO) {
        [checkBoxBluePurpleButton setImage:[UIImage imageNamed:@"4circle.png"] forState:UIControlStateNormal];
        checkBoxBluePurpleButton.alpha = 1;
        checkBoxBluePurple = YES;
    }
    
    else {
        [checkBoxBluePurpleButton setImage:[UIImage imageNamed:@"nothing.png"] forState:UIControlStateNormal];
        checkBoxBluePurpleButton.alpha = 0.1;
        checkBoxBluePurple = NO;
    }
}
- (IBAction)sideSwitch:(id)sender {
    if (sideSwitch.on) {
        NSLog(@"ON");
        SCREEN = YES;
        warningCIRCLE.alpha = 0;
        
    }
    else {
        NSLog(@"OFF");
        SCREEN = NO;
        warningCIRCLE.alpha = 1;
    }
}
- (IBAction)secondsSlider:(id)sender {
    
    int progress = (int)(secondsSlider.value);
    NSNumber *number = [NSNumber numberWithInt:progress];
    [secondsLabel setText:[number stringValue]];
    //[myLabel setText:[NSString stringWithFormat@:"%d", myInt]];
    //[secondsLabel setText:[NSString stringWithFormat@:"%d", progress];
    //NSString *newText = [[NSString alloc] initWithFormat@"%d", progress];
    //sliderLabel.text = (NSString*) newText;
    //self.secondsLabel.text = [NSString stringWithFormat:@"%@ Sec.", newText];
    //self.secondsLabel.text = (NSString*) newText;
}
- (IBAction)start:(id)sender {
    if (checkBoxPurple == NO && checkBoxPink == NO && checkBoxOrange == NO && checkBoxLightPink == NO && checkBoxLightOrange == NO && checkBoxGreen == NO && checkBoxFaded == NO && checkBoxBluePurple == NO && checkBoxBlue == NO && warningCIRCLE.alpha == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"It's a Trap!"
                                                        message:@"You forgot to select any colors.  Please select one or more colors or switch to Flash mode and then try again."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else  {
        
        startButton.tag = 11;
        //[self goneButton];
        exitButton.hidden = false;
        SCREENFLASH.hidden = false;
        
      [exitButton setEnabled:YES];
        if (startButton.tag == 99) {
            return;
        }
        else {
        if (checkBoxBlue == YES) {
            UIImage *image = [UIImage imageNamed: @"BlueWall.png"];
            [SCREENFLASH setImage:image];
            initialTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                           selector:@selector(goPurple) userInfo:nil repeats:NO];
        }
        else {
            [self goPurple];
        }
        }
    }
    
   
}

-(void)goPurple
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxPurple == YES) {
        UIImage *image = [UIImage imageNamed: @"PurpleWall.png"];
        [SCREENFLASH setImage:image];
        purpleTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goOrange) userInfo:nil repeats:NO];
    }
    else {
        [self goOrange];
    }
    }
}
-(void)goOrange
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxOrange == YES) {
        UIImage *image = [UIImage imageNamed: @"OrangeWall.png"];
        [SCREENFLASH setImage:image];
        orangeTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goGreen) userInfo:nil repeats:NO];
    }
    else {
        [self goGreen];
    }
    }
}
-(void)goGreen
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxGreen == YES) {
        UIImage *image = [UIImage imageNamed: @"GreenWall.png"];
        [SCREENFLASH setImage:image];
        greenTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goFaded) userInfo:nil repeats:NO];
    }
    else {
        [self goFaded];
    }
    }
}
-(void)goFaded
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxFaded == YES) {
        UIImage *image = [UIImage imageNamed: @"FadedWall.png"];
        [SCREENFLASH setImage:image];
        fadedTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goPink) userInfo:nil repeats:NO];
    }
    else {
        [self goPink];
    }
    }
}
-(void)goPink
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxPink == YES) {
        UIImage *image = [UIImage imageNamed: @"PinkWall.png"];
        [SCREENFLASH setImage:image];
        pinkTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goLightPink) userInfo:nil repeats:NO];
    }
    else {
        [self goLightPink];
    }
    }
}
-(void)goLightPink
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxLightPink == YES) {
        UIImage *image = [UIImage imageNamed: @"LightPinkWall.png"];
        [SCREENFLASH setImage:image];
        lightPinkTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goLightOrange) userInfo:nil repeats:NO];
    }
    else {
        [self goLightOrange];
    }
    }
}
-(void)goLightOrange
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxLightOrange == YES) {
        UIImage *image = [UIImage imageNamed: @"LightOrangeWall.png"];
        [SCREENFLASH setImage:image];
        lightOrangeTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goBluePurple) userInfo:nil repeats:NO];
    }
    else {
        [self goBluePurple];
    }
    }
}
-(void)goBluePurple
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxBluePurple == YES) {
        UIImage *image = [UIImage imageNamed: @"BluePurpleWall.png"];
        [SCREENFLASH setImage:image];
        bluePurpleTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goBlue) userInfo:nil repeats:NO];
    }
    else {
        [self goBlue];
    }
    }
}
-(void)goBlue
{
    if (startButton.tag == 99) {
        return;
    }
    else {
    //[self goneButton];
    if (checkBoxBlue == YES) {
        UIImage *image = [UIImage imageNamed: @"BlueWall.png"];
        [SCREENFLASH setImage:image];
        blueTimer = [NSTimer scheduledTimerWithTimeInterval:secondsSlider.value target:self
                                       selector:@selector(goPurple) userInfo:nil repeats:NO];
    }
    else {
        [self goPurple];
    }
    }
}
/*  BOOL checkBoxBlue;
 BOOL checkBoxPurple;
 BOOL checkBoxOrange;
 BOOL checkBoxGreen;
 BOOL checkBoxFaded;
 BOOL checkBoxPink;
 BOOL checkBoxLightPink;
 BOOL checkBoxLightOrange;
 BOOL checkBoxBluePurple;*/
- (IBAction)exit:(id)sender {
    //[exitButton setEnabled:NO];
    startButton.tag = 99;
    [self goneButton];
    sideSwitch.tag = 33;
    
    
}
-(void)goneButton
{
    
    
    [exitButton setEnabled:NO];
    if (blueTimer) {
        [blueTimer invalidate];
        blueTimer = nil;
    }
    if (bluePurpleTimer) {
        [bluePurpleTimer invalidate];
        bluePurpleTimer = nil;
    }
    if (fadedTimer) {
        [fadedTimer invalidate];
        fadedTimer = nil;
    }
    if (greenTimer) {
        [greenTimer invalidate];
        greenTimer = nil;
    }
    if (lightOrangeTimer) {
        [lightOrangeTimer invalidate];
        lightOrangeTimer = nil;
    }
    if (lightPinkTimer) {
        [lightPinkTimer invalidate];
        lightPinkTimer = nil;
    }
    if (orangeTimer) {
        [orangeTimer invalidate];
        orangeTimer = nil;
    }
    if (pinkTimer) {
        [pinkTimer invalidate];
        pinkTimer = nil;
    }
    if (purpleTimer) {
        [purpleTimer invalidate];
        purpleTimer = nil;
    }
    if (initialTimer) {
        [initialTimer invalidate];
        initialTimer = nil;
    }
    UIImage *image = [UIImage imageNamed: @"nothing.png"];
    [SCREENFLASH setImage:image];
    [exitButton setEnabled:NO];
    exitButton.hidden = true;
    SCREENFLASH.hidden = true;
    return;
    
}

-(void)gorestart {
    startButton.tag = 11;
    sideSwitch.tag = 7;
    exitButton.hidden = true;
    [exitButton setEnabled:NO];
    exitButton.backgroundColor = [UIColor blackColor];
    [exitButton setTitle: @"" forState:UIControlStateNormal];
}
- (IBAction)infoPlease:(id)sender {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Tap the colorful dots.  Move the Slider.  Tap the START button.  Then tap the screen again to make it stop." delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil, nil] show];
}
@end
