//
//  ViewController.swift
//  MovieDB
//
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    //MARK: Properties
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        main()
        emailTextField.text = "liram@gmail.com"
        passwordTextField.text = "12345678"
       
    }
    
    //MARK: Action
    @IBAction func loginTapped(_ sender: UIButton) {
        
        login()
    }
    
    @IBAction func registerHereTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "register", sender: nil)
    }
    
    //MARK: Functions
    private func main() {
        
    }
    
    private func login() {
        
        guard let email = emailTextField.text, email.emailValidateContent() else {
            appearDialog(title: "Invalid email", message: "Please enter valid email address")
            return}
        
        guard let password = passwordTextField.text, password.count >= 6 else {
            appearDialog(title: "Invalid password", message: "Password must contain at least 3 character")
            return}
        activityIndicatorView.startAnimating()
        loginButton.isEnabled = false
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.activityIndicatorView.stopAnimating()
            self?.loginButton.isEnabled = true
            guard let _ = authResult else {
                self?.appearDialog(title: "Error Occured", message: error?.localizedDescription ?? "")
                return}
            //save local storage user already login
            UserDefaults.standard.set(true, forKey: "isLogin")
            //move to home screen
            self?.performSegue(withIdentifier: ConstantValue.SegueIdentifier.home, sender: nil)
        }
    }
}

