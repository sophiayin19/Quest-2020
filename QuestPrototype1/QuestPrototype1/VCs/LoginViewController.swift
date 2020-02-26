//
//  LoginViewController.swift
//  QuestPrototype1
//
//  Created by Sophia Yin on 2/24/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {

    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
      errorLabel.alpha = 0
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleFilledButton(loginButton)
    }
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                             //there was an error
                self.showError(err!.localizedDescription)
                         }
            else{
                self.transitionToHome()
            }
            
        }

    
        
    }
    func validateFields() -> String?{
         //TODO: check all fields are filled in
         
         if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
             return "Please Fill in all Fields."
         }
         // check password is secure
         let cleanedpassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         if Utilities.isPasswordValid(cleanedpassword) == false {
             return "Please makes sure password is at least 8 characters long, has one special character, and one number."
         }
         
         return nil
         
         
     }
    func showError(_ message:String){
           errorLabel.text = message
           errorLabel.alpha = 1
           
           
       }
    func transitionToHome(){
          let homeViewController = storyboard?.instantiateViewController(identifier:Constants.Storyboard.homeViewController) as? navigationController
           view.window?.rootViewController = homeViewController
           view.window?.makeKeyAndVisible()
           
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
