//
//  ViewController.h
//  BichentesApp
//
//  Created by Elizabeth Martínez Gómez on 07/05/16.
//  Copyright © 2016 Elizabeth Martínez Gómez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imgController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *imageF;
    
    UIImagePickerController *pickerP2;
    UIImage *imagePers;
    
   
    IBOutlet UIImageView *imgFondo;
    
   // IBOutlet UIImageView *imgPersonaje;
  
}



@property(nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;


@property (strong, nonatomic) IBOutlet UIView *messageCont;

@property (strong, nonatomic) IBOutlet UITextView *txtMessage;

@property (strong, nonatomic) IBOutlet UIImageView *imgPersonaje;


@property (strong, nonatomic) IBOutlet UITextView *txtFrase;

@property (strong, nonatomic) IBOutlet UIView *viewContenedor;

- (IBAction)btnGuardar:(UIButton *)sender;

- (IBAction)btnFondo:(id)sender;

- (IBAction)btnPersonaje:(UIButton *)sender;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

- (IBAction)handleRatationImg:(UIRotationGestureRecognizer *)recognizerImg;


- (IBAction)handleRotationMsg:(UIRotationGestureRecognizer *)recognizerRotMsg;

- (IBAction)handleRotationTxt:(UIRotationGestureRecognizer *)recognizerRotTxt;

- (IBAction)handlePinchImg:(UIPinchGestureRecognizer *)recognizerPinchImg;

- (IBAction)handlePinchTxt:(UIPinchGestureRecognizer *)recognizerPinchTxt;


@end

