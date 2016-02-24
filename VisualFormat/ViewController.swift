//
//  ViewController.swift
//  VisualFormat
//
//  Created by Daniel Bonates on 2/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var v1:UIView = UIView(frame: CGRectZero)
    var v2:UIView = UIView(frame: CGRectZero)
    var v3:UIView = UIView(frame: CGRectZero)
    var v4:UIView = UIView(frame: CGRectZero)
    
    var pad = 10.0 as CGFloat
    var stepChange = 10.0 as CGFloat
    var fullHeight:CGFloat = 0
    
    var addedContraints:[NSLayoutConstraint] = []
    
    let colors:[UIColor] = [
        UIColor(red:0.5134,  green:0.8424,  blue:0.9366, alpha:0.6),
        UIColor(red:0.969,  green:0.443,  blue:0.455, alpha:0.8),
        UIColor(red:0.220,  green:0.737,  blue:0.141, alpha:0.4),
        UIColor(red:0.310,  green:0.227,  blue:0.169, alpha:0.7)
    ]
    
    var myViews:[UIView] {
        return [self.v1, self.v2, self.v3, self.v4]
    }

    let swipeUpInfo:UILabel = UILabel(frame: CGRectZero)
    let swipeDownInfo:UILabel = UILabel(frame: CGRectZero)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fullHeight = self.view.bounds.height - pad*5.0
        
        buildBlocks()
        
        setupConstraints()
        
        setupSwipe()
        
        print(v1.bounds.size)
        print("views created")
    }
    
    
    func buildBlocks() {
        
        v1 = UIView(frame: CGRectMake(0,0,self.view.bounds.width,fullHeight/4))
        v1.backgroundColor = colors[0]
        v1.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(v1)
        
        addInfo(swipeUpInfo, onView:v1)
        
        v2 = UIView(frame: CGRectMake(0,fullHeight/4,self.view.bounds.width,fullHeight/4))
        v2.backgroundColor = colors[1]
        v2.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(v2)
        
        
        v3 = UIView(frame: CGRectMake(0,fullHeight/4*2,self.view.bounds.width,fullHeight/4))
        v3.backgroundColor = colors[2]
        v3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(v3)
        
        
        v4 = UIView(frame: CGRectMake(0,fullHeight/4*3,self.view.bounds.width,fullHeight/4))
        v4.backgroundColor = colors[3]
        v4.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(v4)
        addInfo(swipeDownInfo, onView:v4)

    }
    
    func addInfo(infoLabel:UILabel, onView:UIView) {
        
        infoLabel.frame = v4.bounds
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = infoLabel == swipeDownInfo ? "swipe Down" : "SwipeUp"
        infoLabel.textAlignment = NSTextAlignment.Center
        infoLabel.textColor = UIColor.lightGrayColor()
        onView.addSubview(infoLabel)
    }
    
    func setupConstraints() {
    
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(pad)-[v1]-\(pad)-|", options: [], metrics: nil, views: ["v1":self.v1]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(pad)-[v1(==v2)]-\(pad)-[v2]", options: [], metrics: nil, views: ["v1":self.v1,"v2":self.v2]))
        v1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[swipeUpInfo]-|", options: [], metrics: nil, views: ["swipeUpInfo" : swipeUpInfo]))
        v1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[swipeUpInfo]-|", options: [], metrics: nil, views: ["swipeUpInfo" : swipeUpInfo]))

        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(pad)-[v2]-\(pad)-|", options: [], metrics: nil, views: ["v2":self.v2]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v1]-\(pad)-[v2(==v3)]-\(pad)-[v3]", options: [], metrics: nil, views: ["v1":self.v1,"v2":self.v2,"v3":self.v3]))

        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(pad)-[v3]-\(pad)-|", options: [], metrics: nil, views: ["v3":self.v3]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v2]-\(pad)-[v3(==v4)]-\(pad)-[v4]", options: [], metrics: nil, views: ["v2":self.v2,"v3":self.v3,"v4":self.v4]))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(pad)-[v4]-\(pad)-|", options: [], metrics: nil, views: ["v4":self.v4]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v3]-\(pad)-[v4(==v3)]-\(pad)-|", options: [], metrics: nil, views: ["v3":self.v3,"v4":self.v4]))
        
        v4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[swipeDownInfo]-|", options: [], metrics: nil, views: ["swipeDownInfo" : swipeDownInfo]))
        v4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[swipeDownInfo]-|", options: [], metrics: nil, views: ["swipeDownInfo" : swipeDownInfo]))
    }
    
    func setupSwipe() {
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func swiped(sender:UIGestureRecognizer) {
        
        if let swipe = sender as? UISwipeGestureRecognizer {
            switch swipe.direction {
            case UISwipeGestureRecognizerDirection.Up:
                pad -= stepChange
                if pad < 0 { pad = 0 }
            case UISwipeGestureRecognizerDirection.Down:
                if pad > self.v1.bounds.height { break }
                pad += stepChange
            default:
                print("did you meant to swipe?!")
            }
            
            updateConstraints()

        }
    }
    

    func updateConstraints() {
        
        removeConstraints()
        refreshConstraints()
    }
    
    func removeConstraints() {
        
        swipeUpInfo.hidden = true
        swipeDownInfo.hidden = true
        
        swipeUpInfo.removeConstraints(swipeUpInfo.constraints)
        swipeDownInfo.removeConstraints(swipeDownInfo.constraints)
        
        // remove all constrains from views on main view
        for v in self.view.subviews {
            v.removeConstraints(v.constraints)
        }
        
        // carefully remove only orphan constraints on main view
        for c in self.view.constraints {
            
            if let v = c.firstItem as? UIView {
                if (self.myViews.contains(v)) {
                    self.view.removeConstraint(c)
                }
            }
            
            if let v = c.secondItem as? UIView {
                if (self.myViews.contains(v)) {
                    self.view.removeConstraint(c)
                }
            }
        }
    }
    
    func refreshConstraints() {
        self.setupConstraints()
        
        self.view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            
            }, completion: { (finished) in
                
                self.swipeUpInfo.hidden = false
                self.swipeDownInfo.hidden = false
        
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

