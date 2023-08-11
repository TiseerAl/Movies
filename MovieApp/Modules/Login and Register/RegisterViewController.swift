//
//  RegisterViewController.swift
//  MovieDB
//
//  Created by We Write Software on 09/01/2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passworTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK: Properties
    private var handle: AuthStateDidChangeListenerHandle?
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        main()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    //MARK: Action

    @IBAction func registerTapped(_ sender: Any) {
        
        register()
    }
    
    //MARK: - Functions
    private func main() {}
    
    private func configureUI() {}
    
    private func register() {
        
        guard let email = emailTextField.text, email.emailValidateContent() else {
            appearDialog(title: "Invalid email", message: "Please enter valid email address")
            return}
        
        guard let password = passworTextField.text,
              let confirmPasswoed = confirmPasswordTextField.text else {return}
        
        guard password.count >= 6 else {
            appearDialog(title: "Invalid password", message: "Password must contain at least 3 character")
            return}
        
        guard password == confirmPasswoed else {
            appearDialog(title: "Password not match", message: "Please confirm yout password")
            return}
        
        //After all validation success move to Home Screen
        activityIndicatorView.startAnimating()
        registerButton.isEnabled = false
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            self?.activityIndicatorView.stopAnimating()
            self?.registerButton.isEnabled = true
            guard let result = authResult else {
                self?.appearDialog(title: "Error Occured", message: error?.localizedDescription ?? "")
                return
            }
            //save in local storage this user already sign in
            UserDefaults.standard.set(true, forKey: "isLogin")
            //move to home screen
            self?.performSegue(withIdentifier: ConstantValue.SegueIdentifier.home, sender: nil)
        }
    }
}
