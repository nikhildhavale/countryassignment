//
//  ViewController.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
// Username must be unique and it should be an email address.

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthOfStackView: NSLayoutConstraint!
    var oldConstant:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = ColorConstants.NavigationColor
        userName.setupUI(placeHolderText: PlaceHolderText.UserName)
        password.setupUI(placeHolderText: PlaceHolderText.Password)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        setStackViewWidthBasedOnOrientation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        oldConstant = bottomConstraint.constant
    }
    @objc func keyboardWillHide(notification:Notification){
        bottomConstraint.constant = oldConstant
        
    }
    @objc func keyboardWillShow(notification:Notification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardSize.height
        }
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func setStackViewWidthBasedOnOrientation(){
        widthOfStackView.constant = UIScreen.main.bounds.width - 50
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setStackViewWidthBasedOnOrientation()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setStackViewWidthBasedOnOrientation()

    }
/// Login Button clicked
    @IBAction func authenticationButton(_ sender: Any) {
        guard let userNameText = userName.text, let passwordText = password.text else {
            self.showAlertOK(title: "Error", message: "Please enter credentials to procced")
            return
        }
        if DatabaseModel.shared.checkCredentials(email: userNameText, password: passwordText){
            self.performSegue(withIdentifier: StoryBoardConstants.AuthenticationSuccess, sender: nil)
        }
        else{
            self.showAlertOK(title: "Error", message: "Entered credentials are invalid")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if textField == userName {
            password.becomeFirstResponder()
        }
        else{
            authenticationButton(userName) // Any so d
        }
        return true
    }

}

