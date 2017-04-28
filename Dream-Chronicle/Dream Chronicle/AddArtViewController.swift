//
//  AddArtViewController.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/16/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

protocol DataEnteredDelegate: class {
    func userDidMakeArt(info: String)
}

class AddArtViewController: UIViewController {

    weak var delegate: DataEnteredDelegate? = nil
    var prepopulateArt = ""
    var artToSend = ""
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var TempDrawImage: UIImageView!
    
    @IBAction func pencilPressed(_ sender: UIButton) {
        let PressedButton = sender as UIButton
        
        switch(PressedButton.tag)
        {
        case 0:
            brush = 5.0
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            brush = 5.0
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            brush = 5.0
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            brush = 5.0
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4:
            brush = 5.0
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            brush = 5.0
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            brush = 5.0
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            brush = 5.0
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            brush = 5.0
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            brush = 5.0
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        default:
            break;
        }
    }
    @IBAction func eraserPressed(_ sender: UIButton) {
        brush = 20.0
        red = 255.0/255.0;
        green = 255.0/255.0;
        blue = 255.0/255.0;
    }
    @IBAction func reset(_ sender: UIButton) {
        TempDrawImage.image = nil
    }
    @IBAction func save(_ sender: UIButton) {
        
        let uploadImage = TempDrawImage.image //This is a UIImage
        let imageData = UIImagePNGRepresentation(uploadImage!)! //This is NSData
        var encodedData = imageData.base64EncodedString(options: .lineLength64Characters)
        delegate?.userDidMakeArt(info: encodedData as String!)
        
        dismiss(animated: true, completion: nil)
    }
    
    var lastPoint: CGPoint?
    var red: CGFloat?
    var green: CGFloat?
    var blue: CGFloat?
    var mouseSwiped: Bool?
    var brush: CGFloat?

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mouseSwiped = false
        let touch = touches.first!
        lastPoint = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        mouseSwiped = true
        let touch = touches.first!
        var currentPoint = touch.location(in: self.view)
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        TempDrawImage.image?.draw(in: view.bounds)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.move(to: lastPoint!)
        context?.addLine(to: currentPoint)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brush!)
        context?.setStrokeColor(red: red!, green: green!, blue: blue!, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        context?.restoreGState()
        TempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(!mouseSwiped!) {
            UIGraphicsBeginImageContext(self.view.frame.size)
            TempDrawImage.draw(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            let context = UIGraphicsGetCurrentContext()
            context?.setLineCap(CGLineCap.round)
            context?.setLineWidth(5.0)
            context?.setStrokeColor(red: red!, green: green!, blue: blue!, alpha: 1.0)
            context?.move(to: lastPoint!)
            context?.addLine(to: lastPoint!)
            context?.strokePath()
            context?.flush()
            TempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
    }
    
    
    override func viewDidLoad() {
        brush = 5.0
        red = 0.0/255.0;
        green = 0.0/255.0;
        blue = 0.0/255.0;
        
        super.viewDidLoad()
        if (prepopulateArt != "") {
            var decodedData: NSData = NSData(base64Encoded: prepopulateArt, options: .ignoreUnknownCharacters)!
            let dataImage = UIImage(data: decodedData as Data)
            TempDrawImage.image = dataImage
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    


}
