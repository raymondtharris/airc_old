//
//  Segue.swift
//  AIrc
//
//  Created by Tim Harris on 8/2/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation
import UIKit

class AIPushSegue: UIStoryboardSegue {
    override func perform() {
        let sourceViewControllerView = self.sourceViewController.view as UIView!
        let destinationViewControllerView = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHieght = UIScreen.mainScreen().bounds.size.height
        
        destinationViewControllerView.frame = CGRectMake(0.0, screenHieght, screenWidth, screenHieght)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(destinationViewControllerView, aboveSubview: sourceViewControllerView)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            sourceViewControllerView.frame = CGRectOffset(sourceViewControllerView.frame, 0.0, -screenHieght)
            destinationViewControllerView.frame  = CGRectOffset(destinationViewControllerView.frame, 0.0, -screenHieght)
            
            }) {(Finished) ->Void in
                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
        }
        
    }
}
