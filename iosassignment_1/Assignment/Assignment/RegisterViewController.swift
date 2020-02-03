//
//  RegisterViewController.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var buttomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPassword.setupUI(placeHolderText: PlaceHolderText.ConfirmPassword)
        password.setupUI(placeHolderText: PlaceHolderText.Password)
        userName.setupUI(placeHolderText: PlaceHolderText.UserName)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillHide(notification:Notification){
        buttomConstraint.constant = 0
        
    }
    @objc func keyboardWillShow(notification:Notification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            buttomConstraint.constant = keyboardSize.height
        }
        
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// Signup button as well as logging in 
    @IBAction func authenticationButton(_ sender: Any) {

        guard let passwordText = password.text , let userNameText = userName.text else {
            self.showAlertOK(title: "Error", message: "Please enter all fields")
            return
        }
        if confirmPassword.text != password.text {
            self.showAlertOK(title: "Error", message: "Passwords do not match")
            
        }
        else if !passwordText.isValidPassword(){
            self.showAlertOK(title: "Error", message: "Password should contain at least one special character and atleast one digit and should be alteast 8 characters")

        }
        else if !userNameText.isValidEmail() {
            self.showAlertOK(title: "Error", message: "Email entered is invalid")
        }
        else if DatabaseModel.shared.checkIfUserExists(userName: userNameText) {
            self.showAlertOK(title: "Error", message: "User already exists")
        }
        else if DatabaseModel.shared.insertUser(email: userNameText, password: passwordText) 
        {
            self.showAlertOKWithAction(title: "", message: "User registered successfully", alertAction: UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                
                self.performSegue(withIdentifier: StoryBoardConstants.AuthenticationSuccess, sender: nil)

            }))
        }
        else{
            self.showAlertOK(title: "Error", message: "Could not register")
        }

    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        stackViewWidthConstraint.constant = UIScreen.main.bounds.width - 50
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        stackViewWidthConstraint.constant = UIScreen.main.bounds.width - 50

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == userName {
            password.becomeFirstResponder()
        }
        else if textField == password{
            confirmPassword.becomeFirstResponder()
        }
        else{
             authenticationButton(userName) // Any so user name 
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
