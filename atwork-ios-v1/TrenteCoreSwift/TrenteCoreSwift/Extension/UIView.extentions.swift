//
//  UIView.extentions.swift
//  B1029
//
//  Created by Nguyen Duc Viet on 10/2/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import Foundation
import  UIKit

fileprivate var ActivityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"

public extension UIView {
    
    public var activityIndicatorView: UIActivityIndicatorView {
        get {
            if let activityIndicatorView = objc_getAssociatedObject(self,&ActivityIndicatorViewAssociativeKey) as? UIActivityIndicatorView {
                return activityIndicatorView
            } else {
                let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
                activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
                activityIndicatorView.color = .gray
                activityIndicatorView.center = center
                activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(activityIndicatorView)
//                activityIndicatorView.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
//                activityIndicatorView.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
                self.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
                
                objc_setAssociatedObject(self, &ActivityIndicatorViewAssociativeKey,activityIndicatorView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activityIndicatorView
            }
        }
        
        set {
            addSubview(newValue)
            objc_setAssociatedObject(self, &ActivityIndicatorViewAssociativeKey,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult   // 1
    public func fromNib<T : UIView>() -> T? {   // 2
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {    // 3
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        view.frame = bounds
        self.addSubViewWithConstraints(subView:view)
//        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
//        addSubview(view)     // 4
        
        return view   // 7
    }
    
    public func addSubViewWithConstraints(subView:UIView){
        if subView.superview == nil{
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subView)
            self.bringSubview(toFront: subView)
            //add constraint
            self.addConstraint(NSLayoutConstraint.init(item: subView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint.init(item: subView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint.init(item: subView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint.init(item: subView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        }
        self.layoutIfNeeded()
    }
    
    
    
    
    public func addShadowAndRoundCorner(cornerRadius:CGFloat,shadowOffset:CGSize = CGSize(width: 0, height: 1),opacity:Float = 0.3,color:UIColor = UIColor.black){
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = cornerRadius
        self.layer.cornerRadius = cornerRadius
    }
    
    
    public func addRoundCorner(cornerRadius:CGFloat){
        self.layer.cornerRadius = cornerRadius
    }
    
    public func addBorder(color: UIColor, width: CGFloat = 1, cornerRadius: CGFloat = 0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    public func showWithAnimation(animationView:UIView){
        self.frame = (KEY_WINDOW?.bounds)!
        KEY_WINDOW?.addSubViewWithConstraints(subView: self)
        KEY_WINDOW?.bringSubview(toFront: self)

        animationView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            animationView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }, completion:nil)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            animationView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }, completion:nil)

    }
    public func hideWithAnimation(animationView:UIView){
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            animationView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        }, completion:{finished in
            self.removeFromSuperview()
        })
    }
}





