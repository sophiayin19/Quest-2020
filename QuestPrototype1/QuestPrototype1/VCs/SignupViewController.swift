//
//  SignupViewController.swift
//  QuestPrototype1
//
//  Created by Sophia Yin on 2/24/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    
   
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
       
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var yearOfGradPicker: UIPickerView!
    

    struct GlobalVariable{
        static var yearOfGrad = "2020"
        static var uid = "x"

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        yearOfGradPicker.delegate = self
        yearOfGradPicker.dataSource = self
        // Do any additional setup after loading the view.
        setUpElements()
    
    }
    let listofyears = ["2020","2021","2022","2023","2024" ]
    //MARK: Actions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
               return 1
           
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
               return  listofyears.count

       }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let chosenYear = listofyears[row]
        return chosenYear
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        GlobalVariable.yearOfGrad = listofyears[row]
    }
    


   func setUpElements(){
          errorLabel.alpha = 0
          Utilities.styleTextField(passwordTextField)
          Utilities.styleTextField(emailTextField)
          Utilities.styleTextField(firstNameTextField)
          Utilities.styleTextField(lastNameTextField)
        Utilities.styleFilledButton(signupButton)
    Utilities.styleTextField(phoneNumberTextField)
    
    
      }
    //check fields, if correct return nil, if not, return string
    func validateFields() -> String?{
        //check all fields are filled in
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please Fill in all Fields."
        }
        // check password is secure
        let cleanedpassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedpassword) == false {
            return "Please makes sure password is at least 8 characters long, has one special character, and one number."
        }
        
        return nil
        
        
    }

    @IBAction func signupTapped(_ sender: Any) {
        //validate fields
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else{
             //create the user
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    //there was an error
                    self.showError("Error creating User")
                }else{
                    GlobalVariable.uid = result!.user.uid
                    let db = Firestore.firestore()
                db.collection("users").document(GlobalVariable.uid).setData(["firstName": firstName, "lastName":lastName, "uid": GlobalVariable.uid, "phoneNumber":phoneNumber, "yearOfGrad":GlobalVariable.yearOfGrad]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                       
                    }
                    //transition to the homescreen
                    self.transitionToHome()
                }
            }
            
           
        
        }
        
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
        
        
    }

    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(identifier:Constants.Storyboard.homeViewController) as? tabViewController
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
