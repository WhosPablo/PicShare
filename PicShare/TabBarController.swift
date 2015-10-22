//
//  TabBarController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/17/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import Foundation

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        let selectedColor = UIColor(red: CGFloat(41)/255.0, green: CGFloat(128)/255.0, blue: CGFloat(185)/255.0, alpha: CGFloat(1))
        
        self.tabBar.tintColor = UIColor.whiteColor()
        
        for tbi:UITabBarItem in self.tabBar.items!{
            tbi.image = tbi.image?.imageWithColor(selectedColor).imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}