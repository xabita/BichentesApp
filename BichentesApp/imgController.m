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
    
    
    _txtFrase.backgroundColor = [UIColor clearColor];
   _imgPersonaje.backgroundColor = [UIColor clearColor];
   _imgPersonaje.opaque = NO;
    
    [[self imgPersonaje]setUserInteractionEnabled:YES];
  
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



@end
