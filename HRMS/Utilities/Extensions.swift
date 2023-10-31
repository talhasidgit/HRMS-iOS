//
//  Extensions.swift
//  
//
//  Created by Ahmed on 31/12/2021.
//

import Foundation
import UIKit
import ObjectiveC

extension NSObject {
    var classIdentifier: String {
        return String(describing: type(of: self))
    }
    
    class var classIdentifier: String {
        return String(describing: self)
    }
    
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
}


extension UIView {
    
    
    func addShadow(opacity: Float, cornerRadius: Float, shadowRadius:Float ,borderColor:CGColor ,borderWith:CGFloat) {
        
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOffset = .zero
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        //self.clipsToBounds = true
        
    }
    func addShadow(opacity: Float, cornerRadius: Float, shadowRadius:Float) {
        
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOffset = CGSize(width: 2.0,height: 2.0)
      //  self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
//        self.layer.borderWidth = borderWith
//        self.layer.borderColor = borderColor
        //self.clipsToBounds = true
        
    }
    func uiViewShadow() {
        
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 2.0,height: 2.0)

      }
    
    func buttonUiViewShadow() {
        
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = .zero

      }
    
    func makeViewRound(){
        self.layer.borderColor = UIColor(red:25/255, green:66/255, blue:132/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
    
    public var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
  
    
    public var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    public var centerX: CGFloat{
        get { return self.center.x }
        set { self.center = CGPoint(x: newValue,y: self.centerY) }
    }
    public var centerY: CGFloat {
        get { return self.center.y }
        set { self.center = CGPoint(x: self.centerX,y: newValue) }
    }
    
    public var origin: CGPoint {
        set { self.frame.origin = newValue }
        get { return self.frame.origin }
    }
    
}

extension UITextField {

enum Direction {
    case Left
    case Right
}
    
    

// add image to textfield
func withImage(direction: Direction, image: UIImage){
    let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
    mainView.layer.cornerRadius = 5

    let view = UIView(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
    view.backgroundColor = .white
    view.clipsToBounds = true
    view.layer.cornerRadius = 5
    mainView.addSubview(view)

    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
    view.addSubview(imageView)

    if(Direction.Left == direction){ // image left
        self.leftViewMode = .always
        self.leftView = mainView
    } else { // image right
        self.rightViewMode = .always
        self.rightView = mainView
    }

}
    
    // add image to textfield
    func textFieldwithImage(direction: Direction, image: UIImage, iconBtn: UIButton){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
       // view.layer.borderWidth = CGFloat(0)
       // view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        let iconButton = iconBtn
        iconButton.titleLabel?.text = ""
        iconButton.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(iconButton)
        
//        let seperatorView = UIView()
//        seperatorView.backgroundColor = colorSeparator
//        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
           // seperatorView.frame = CGRect(x: 45, y: 0, width: 2, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
          //  seperatorView.frame = CGRect(x: 0, y: 0, width: 2, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
      //  self.layer.borderColor = colorBorder.cgColor
       // self.layer.borderWidth = CGFloat(2.0)
        //self.layer.cornerRadius = 10
    }
}
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}


extension UITextField {
   
   //MARK:- Set Image on the right of text fields
   
   func setupRightImage(imageName:String){
      let imageView = UIImageView(frame: CGRect(x: 5, y:5, width: 10, height: 7))
      imageView.image = UIImage(named: imageName)
      imageView.backgroundColor = UIColor.gray
      let imageContainerView: UIView = UIView(frame: CGRect(x: -35, y: 0, width: 20, height: 20))
      imageContainerView.addSubview(imageView)
      imageContainerView.backgroundColor = UIColor.black
      rightView = imageContainerView
      rightViewMode = .always
      self.tintColor = .lightGray
   }
    
    
   
   //MARK:- Set Image on left of text fields
   
   func setupLeftImage(imageName:String){
      let imageView = UIImageView(frame: CGRect(x: 5, y: 6, width: 10, height: 7))
      imageView.image = UIImage(named: imageName)
   // imageView.backgroundColor = UIColor.gray
      let imageContainerView: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
      imageContainerView.addSubview(imageView)
    //imageContainerView.backgroundColor = UIColor.black
      leftView = imageContainerView
      leftViewMode = .always
      self.tintColor = .lightGray
   }
    
    //MARK:- Set bottom border only of text field
     func bottomBorder(textfeild:UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textfeild.frame.height - 1, width: textfeild.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        textfeild.borderStyle = UITextField.BorderStyle.none
        textfeild.layer.addSublayer(bottomLine)
    }
    func setBorderColor(width:CGFloat,color:UIColor) -> Void{
           self.layer.borderColor = color.cgColor
           self.layer.borderWidth = width
       }
    
    
    
   
}
extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

extension NSMutableAttributedString {

    public func setAsLink(textToFind:String, linkURL:String) -> Bool {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
