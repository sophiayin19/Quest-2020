//
//  StartupViewController.swift
//  QuestPrototype1
//
//  Created by Sophia Yin on 2/24/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElement()
    }
    
    func setUpElement(){
        Utilities.styleFilledButton(signupButton)
        Utilities.styleHollowButton(loginButton)
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
