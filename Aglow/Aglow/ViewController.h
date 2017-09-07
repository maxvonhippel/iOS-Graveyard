//
//  ViewController.h
//  Aglow
//
//  Created by Max von Hippel on 4/18/14.
//  Copyright (c) 2014 Max von Hippel Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface ViewController : UIViewController {
    BOOL checkBoxBlue;
    BOOL checkBoxPurple;
    BOOL checkBoxOrange;
    BOOL checkBoxGreen;
    BOOL checkBoxFaded;
    BOOL checkBoxPink;
    BOOL checkBoxLightPink;
    BOOL checkBoxLightOrange;
    BOOL checkBoxBluePurple;
    BOOL SCREEN;
    
    NSTimer *blueTimer;
    NSTimer *bluePurpleTimer;
    NSTimer *fadedTimer;
    NSTimer *greenTimer;
    NSTimer *lightOrangeTimer;
    NSTimer *lightPinkTimer;
    NSTimer *orangeTimer;
    NSTimer *pinkTimer;
    NSTimer *purpleTimer;
    NSTimer *initialTimer;
}
- (IBAction)infoPlease:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *iButton;
@property (strong, nonatomic) IBOutlet UILabel *flashLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenLabel;
@property (nonatomic, retain) NSTimer *blueTimer;
@property (nonatomic, retain) NSTimer *bluePurpleTimer;
@property (nonatomic, retain) NSTimer *fadedTimer;
@property (nonatomic, retain) NSTimer *greenTimer;
@property (nonatomic, retain) NSTimer *lightOrangeTimer;
@property (nonatomic, retain) NSTimer *lightPinkTimer;
@property (nonatomic, retain) NSTimer *orangeTimer;
@property (nonatomic, retain) NSTimer *pinkTimer;
@property (nonatomic, retain) NSTimer *purpleTimer;
@property (nonatomic, retain) NSTimer *initialTimer;


@property (strong, nonatomic) IBOutlet UIButton *exitButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)exit:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *SCREENFLASH;
- (IBAction)start:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *warningCIRCLE;
@property (strong, nonatomic) IBOutlet UILabel *delayLabel;
@property (strong, nonatomic) IBOutlet UIImageView *colorImage;
- (IBAction)secondsSlider:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *secondsSlider;
@property (strong, nonatomic) IBOutlet UILabel *secondsLabel;
- (IBAction)sideSwitch:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *sideSwitch;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxBlueButton;
- (IBAction)checkBoxBlueAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxPurpleButton;
- (IBAction)checkBoxPurpleAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxOrangeButton;
- (IBAction)checkBoxOrangeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxGreenButton;
- (IBAction)checkBoxGreenAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxFadedButton;
- (IBAction)checkBoxFadedAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxPinkButton;
- (IBAction)checkBoxPinkAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxLightPinkButton;
- (IBAction)checkBoxLightPinkAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxLightOrangeButton;
- (IBAction)checkBoxLightOrangeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxBluePurpleButton;
- (IBAction)checkBoxBluePurpleAction:(id)sender;


/*- (void)goBlue:(id)sender;
- (void)goPurple:(id)sender;
- (void)goFaded:(id)sender;
- (void)goGreen:(id)sender;
- (void)goLightOrange:(id)sender;
- (void)goLightPink:(id)sender;
- (void)goOrange:(id)sender;
- (void)goPink:(id)sender;
- (void)goBluePurple:(id)sender;*/
@end
