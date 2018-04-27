//
//  ViewController.m
//  PixelApp
//
//  Created by Ivan Kozaderov on 24.04.2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import "ViewController.h"
#import "DrawImageView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet DrawImageView *drawImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

- (IBAction)pensilButton:(id)sender;
- (IBAction)eraserButton:(id)sender;
- (IBAction)resetButton:(id)sender;
- (IBAction)settingsButton:(id)sender;
- (IBAction)shareButton:(id)sender;

@property(assign,nonatomic)BOOL  mouseSwiped;
@property(assign,nonatomic)CGPoint lastPoint;
@property(strong,nonatomic)UIColor* brushColor;
@property(assign,nonatomic)CGFloat brushThickness;
@property(assign,nonatomic)CGFloat opacity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.brushThickness = 10.f;
    self.brushColor = [UIColor blackColor];
    self.opacity = 1.f;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)pensilButton:(id)sender {
  
    UIButton* button = (UIButton*) sender;
    self.brushThickness = 10.f;
    switch (button.tag) {
            
        case 0:
            self.brushColor = [UIColor colorWithRed:0.0/255.
                                              green:0.0/255.
                                               blue:0.0/255.
                                              alpha:1.0f];
            break;
            
        case 1:
            self.brushColor = [UIColor colorWithRed:105.0/255.
                                              green:105.0/255.
                                               blue:105.0/255.
                                              alpha:1.0f];
            break;
            
        case 2:
            self.brushColor = [UIColor colorWithRed:255.0/255.
                                              green:0.0/255.
                                               blue:0.0/255.
                                              alpha:1.0f];
            break;
            
        case 3:
            self.brushColor = [UIColor colorWithRed:0.0/255.
                                              green:0.0/255.
                                               blue:255.0/255.
                                              alpha:1.0f];
            break;
            
        case 4:
            self.brushColor = [UIColor colorWithRed:102.0/255.
                                              green:204.0/255.
                                               blue:0.0/255.
                                              alpha:1.0f];
            break;
            
        case 5:
            self.brushColor = [UIColor colorWithRed:102.0/255.
                                              green:255.0/255.
                                               blue:105.0/255.
                                              alpha:1.0f];
            break;
            
        case 6:
            self.brushColor = [UIColor colorWithRed:51.0/255.
                                              green:204.0/255.
                                               blue:255.0/255.
                                              alpha:1.0f];
            break;
            
        case 7:
            self.brushColor = [UIColor colorWithRed:160.0/255.
                                              green:82.0/255.
                                               blue:45.0/255.
                                              alpha:1.0f];
            break;
            
        case 8:
            self.brushColor = [UIColor colorWithRed:255.0/255.
                                              green:102.0/255.
                                               blue:0.0/255.
                                              alpha:1.0f];
            break;
            
        case 9:
            self.brushColor = [UIColor colorWithRed:255.0/255.
                                              green:255.0/255.
                                               blue:0.0/255.
                                              alpha:1.0f];
            break;
    }
    
}
- (IBAction)eraserButton:(id)sender{
    
    self.brushColor = [UIColor colorWithRed:255.0/255.
                                      green:255.0/255.
                                       blue:255.0/255.
                                      alpha:1.0f];
     self.opacity = 1.f;
}
- (IBAction)settingsButton:(id)sender{
        
}
- (IBAction)shareButton:(id)sender{
    
}
- (IBAction)resetButton:(id)sender{
    
    self.mainImageView.image = nil;
}
#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.mouseSwiped = NO;
    
    UITouch* touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch     = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    self.mouseSwiped = YES;
    
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxt, self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(ctxt, currentPoint.x, currentPoint.y);
    CGContextSetLineCap(ctxt, kCGLineCapRound);
    CGContextSetLineWidth(ctxt, self.brushThickness);
    CGContextSetStrokeColorWithColor(ctxt, self.brushColor.CGColor);
    CGContextSetBlendMode(ctxt, kCGBlendModeNormal);
    CGContextStrokePath(ctxt);
    self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.drawImage setAlpha:self.opacity];
    self.lastPoint = currentPoint;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UIGraphicsEndImageContext();
    if (!self.mouseSwiped ) {
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.drawImage.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushThickness);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.brushColor.CGColor);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [self.mainImageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.drawImage.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) blendMode:kCGBlendModeNormal alpha:self.opacity];
    self.mainImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    self.drawImage.image = nil;
    UIGraphicsEndImageContext();
    
    
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}

@end
