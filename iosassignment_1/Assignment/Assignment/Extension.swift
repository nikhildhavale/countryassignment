
//
//  File.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    /// Show default AlertView
    func showAlertOK(title:String,message:String){
       showAlertOKWithAction(title: title, message: message, alertAction: nil)
    }
    /// Show default AlertView with Action
    func showAlertOKWithAction(title:String,message:String,alertAction:UIAlertAction?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if alertAction == nil {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        }
        else{
            alertController.addAction(alertAction!)

        }
        self.present(alertController, animated: true, completion: nil)
    }
}
extension UIView{
    @IBInspectable var borderWidth : CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable  var borderColor:UIColor
        {
        set{
            self.layer.borderColor = newValue.cgColor
        }
        
        get{
            if layer.borderColor == nil {
                return UIColor.clear
            }
            return UIColor(cgColor: layer.borderColor!)
        }
        
        
    }
    @IBInspectable var borderRadius:CGFloat {
        set{
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
}
extension UITextField{
    ///UI for textfield is set with placeholder text
    func setupUI(placeHolderText:String){
        self.backgroundColor = ColorConstants.LightBackgroundColor
        self.attributedPlaceholder = NSAttributedString(string:placeHolderText , attributes: [NSAttributedStringKey.foregroundColor:ColorConstants.TextColor])
        self.textColor = ColorConstants.TextColor
        self.font = FontConstant.defaultFont
        
    }
}
extension String{
    func isValidEmail() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        return predicate .evaluate(with: self)
        
        
    }
    /// Is this valid password
    func isValidPassword()->Bool{
        return self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil  && self.rangeOfCharacter(from: CharacterSet.punctuationCharacters) != nil && count > 8
    }

}
extension NSAttributedString {
    /// converts string to attributed string with bold and bigger default font
    static func mainAttributedString(string:String?) -> NSAttributedString{
        if string != nil {
            let itemAttributedString = NSAttributedString(string: "\n\n\(string!)", attributes: [NSAttributedStringKey.font:FontConstant.defaultBoldFontHigher,NSAttributedStringKey.foregroundColor: UIColor.black])
            return itemAttributedString
        }
        return NSAttributedString()
    }
    /// converts string to attributed string with bold default font
    static func itemAttributedString(string:String?) -> NSAttributedString{
        if string != nil {
            let itemAttributedString = NSAttributedString(string: "\n\(string!)", attributes: [NSAttributedStringKey.font:FontConstant.defaultBoldFont,NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            return itemAttributedString
        }
        return NSAttributedString()
    }
    /// converts string to attributed string with default font
    static func itemNonBoldAttributedString(string:String?) -> NSAttributedString {
        if string != nil {
            let itemAttributedString = NSAttributedString(string: "\n\(string!)", attributes: [NSAttributedStringKey.foregroundColor:ColorConstants.TextColor,NSAttributedStringKey.font:FontConstant.defaultFont])
            return itemAttributedString
        }
        return NSAttributedString()
        
    }
}
extension Data {
    func showString(){
        if let stringData = String(bytes: self, encoding: .utf8){
            print(stringData)
        }
    }
}
