//
//  AddTodoViewController.swift
//  QuestPrototype1
//
//  Created by Sophia Yin on 5/6/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import UIKit
import CoreData

class AddTodoViewController: UIViewController, UITextFieldDelegate {
    var managedContext: NSManagedObjectContext!
    
    @IBOutlet var field: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func saveTapped(_ sender: Any) {
        guard let title = field.text, !title.isEmpty else{
            return
        }
    //TODO: FIX ERRORS IN CODE U DUMB BITCH
        let todo = Todo(context: managedContext)
        let text = field.text
        todo.title = text
        todo.date = Date()
    }
}

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


