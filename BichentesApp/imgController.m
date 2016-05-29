//
//  ViewController.m
//  BichentesApp
//
//  Created by Elizabeth Martínez Gómez on 07/05/16.
//  Copyright © 2016 Elizabeth Martínez Gómez. All rights reserved.
//

#import "imgController.h"

typedef enum {
    CurrentImageCategoryFondo = 0,
    CurrentImageCategoryPers
}CurrentImageCategory;


CGPoint firstTouchPoint;
float xd;
float yd;

@interface imgController ()

@end



@implementation imgController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _txtMessage.backgroundColor=[UIColor clearColor];
    _messageCont.backgroundColor=[UIColor clearColor];
    
   _imgPersonaje.backgroundColor = [UIColor clearColor];
   _imgPersonaje.opaque = NO;
    
    [[self imgPersonaje]setUserInteractionEnabled:YES];
    
 /*Rotate ImagePersonaje*/
    UIRotationGestureRecognizer *recognizerImg = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRatationImg:)];
    [self.imgPersonaje addGestureRecognizer:recognizerImg];
    
  
    /*Rotate text */
     
     UIRotationGestureRecognizer *recognizerRotTxt = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationTxt:)];
        [self.txtMessage addGestureRecognizer:recognizerRotTxt];
  
    UIPinchGestureRecognizer *recognizerPinchImg = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchImg:)];
    [self.imgPersonaje addGestureRecognizer:recognizerPinchImg];
    
    UIPinchGestureRecognizer *recognizerPinchTxt = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchTxt:)];
    [self.txtMessage addGestureRecognizer:recognizerPinchTxt];

    
    
  
}




- (IBAction)handlePinchImg:(UIPinchGestureRecognizer *)recognizerPinchImg {
    self.imgPersonaje.transform = CGAffineTransformScale(self.imgPersonaje.transform, recognizerPinchImg.scale, recognizerPinchImg.scale);
    recognizerPinchImg.scale = 1.0;
}



- (IBAction)handlePinchTxt:(UIPinchGestureRecognizer *)recognizerPinchTxt {
    self.txtMessage.transform = CGAffineTransformScale(self.txtMessage.transform, recognizerPinchTxt.scale, recognizerPinchTxt.scale);
    recognizerPinchTxt.scale = 1.0;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
     if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentImageCategory"] == CurrentImageCategoryFondo)
    {
        imageF= [info objectForKey:UIImagePickerControllerOriginalImage];
        [imgFondo setImage:imageF];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentImageCategory"] == CurrentImageCategoryPers)
    {
        imagePers= [info objectForKey:UIImagePickerControllerOriginalImage];
        [_imgPersonaje setImage:imagePers];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}






-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnGuardar:(UIButton *)sender {
    UIImageWriteToSavedPhotosAlbum([self captureView:self.view], nil, nil, nil);
}


- (UIImage*)captureView:(UIView *)viewContenedor
{
  //  CGRect rect = [[UIScreen mainScreen] bounds];
    CGRect rect = [[self viewContenedor] bounds];
   /* rect.origin.x += 0.0f;
    rect.origin.y += 0.0f;*/
    [[self viewContenedor] setBounds:rect];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [viewContenedor.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (IBAction)btnFondo:(UIButton *)sender {
    // Set current category to userDefaults
    [[NSUserDefaults standardUserDefaults] setInteger:CurrentImageCategoryFondo forKey:@"currentImageCategory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    picker2= [[UIImagePickerController alloc] init];
    picker2.delegate =self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: picker2 animated:YES completion:nil];
}

- (IBAction)btnPersonaje:(UIButton *)sender {
    
    // Set current category to userDefaults
    [[NSUserDefaults standardUserDefaults] setInteger:CurrentImageCategoryPers forKey:@"currentImageCategory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    pickerP2= [[UIImagePickerController alloc] init];
    pickerP2.delegate =self;
    [pickerP2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: pickerP2 animated:YES completion:nil];
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.viewContenedor endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
    UITouch* bTouch = [touches anyObject];
    if ([bTouch.view isEqual:[self imgPersonaje]]) {
        firstTouchPoint = [bTouch locationInView:[self viewContenedor]];
        xd = firstTouchPoint.x - [[bTouch view]center].x;
        yd = firstTouchPoint.y - [[bTouch view]center].y;
    }
    
    
    
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* mTouch = [touches anyObject];
    if (mTouch.view == [self imgPersonaje]) {
        CGPoint cp = [mTouch locationInView:[self viewContenedor]];
        [[mTouch view]setCenter:CGPointMake(cp.x-xd, cp.y-yd)];
    }
    
    
    
    
}




- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view]; recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y); [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
}



- (IBAction)handleRatationImg:(UIRotationGestureRecognizer *)recognizerImg {
    self.imgPersonaje.transform = CGAffineTransformRotate(self.imgPersonaje.transform, recognizerImg.rotation);
    
    recognizerImg.rotation = 0.0;

    
    
    
}


- (IBAction)handleRotationMsg:(UIRotationGestureRecognizer *)recognizerRotMsg{
    self.messageCont.transform = CGAffineTransformRotate(self.messageCont.transform, recognizerRotMsg.rotation);
    
    recognizerRotMsg.rotation = 0.0;
    
 
    
}

- (IBAction)handleRotationTxt:(UIRotationGestureRecognizer *)recognizerRotTxt{
    
    self.txtMessage.transform = CGAffineTransformRotate(self.txtMessage.transform, recognizerRotTxt.rotation);
    
    recognizerRotTxt.rotation = 0.0;
    
    
}



@end
