//
//  AddArtViewController.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/16/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit

class AddArtViewController: UIViewController {
    
    @IBOutlet weak var MainDrawImage: UIImageView!
    @IBOutlet weak var TempDrawImage: UIImageView!
    @IBAction func pencilPressed(_ sender: UIButton) {
        let PressedButton = sender as UIButton
        
        switch(PressedButton.tag)
        {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        default:
            break;
        }
    }
    @IBAction func eraserPressed(_ sender: UIButton) {
        red = 255.0/255.0;
        green = 255.0/255.0;
        blue = 255.0/255.0;
        opacity = 1.0;
    }
    @IBAction func reset(_ sender: UIButton) {
        MainDrawImage.image = nil
    }
    @IBAction func settings(_ sender: UIButton) {
    }
    @IBAction func save(_ sender: UIButton) {
    }
    
    var lastPoint: CGPoint?
    var red: CGFloat?
    var green: CGFloat?
    var blue: CGFloat?
    var brush: CGFloat?
    var opacity: CGFloat?
    var mouseSwiped: Bool?

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mouseSwiped = nil
        let touch = touches.first!
        lastPoint = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        mouseSwiped = true
        let touch = touches.first!
        var currentPoint = touch.location(in: self.view)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        TempDrawImage.draw(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: lastPoint!)
        context?.addLine(to: currentPoint)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brush!)
        context?.setStrokeColor(red: red!, green: green!, blue: blue!, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        TempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        TempDrawImage.alpha = opacity!
        UIGraphicsEndImageContext()
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(!mouseSwiped!) {
            UIGraphicsBeginImageContext(self.view.frame.size)
            TempDrawImage.draw(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            let context = UIGraphicsGetCurrentContext()
            context?.setLineCap(CGLineCap.round)
            context?.setLineWidth(brush!)
            context?.setStrokeColor(red: red!, green: green!, blue: blue!, alpha: 1.0)
            context?.move(to: lastPoint!)
            context?.addLine(to: lastPoint!)
            context?.strokePath()
            context?.flush()
            TempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContext(self.MainDrawImage.frame.size)
        MainDrawImage.draw(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        TempDrawImage.draw(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        MainDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        TempDrawImage.image = nil
        UIGraphicsEndImageContext()
        
            //    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
            //    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    }
    
//    - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    mouseSwiped = NO;
//    UITouch *touch = [touches anyObject];
//    lastPoint = [touch locationInView:self.view];
//    }
//    
//    - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    mouseSwiped = YES;
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:self.view];
//    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
//    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
//    
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
//    [self.tempDrawImage setAlpha:opacity];
//    UIGraphicsEndImageContext();
//    
//    lastPoint = currentPoint;
//    }
//    
//    - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    if(!mouseSwiped) {
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    CGContextFlush(UIGraphicsGetCurrentContext());
//    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    }
//    
//    UIGraphicsBeginImageContext(self.mainImage.frame.size);
//    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
//    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
//    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
//    self.tempDrawImage.image = nil;
//    UIGraphicsEndImageContext();
//    }
    
    override func viewDidLoad() {
        red = 0.0/255.0;
        green = 0.0/255.0;
        blue = 0.0/255.0;
        brush = 10.0;
        opacity = 1.0;
        
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
