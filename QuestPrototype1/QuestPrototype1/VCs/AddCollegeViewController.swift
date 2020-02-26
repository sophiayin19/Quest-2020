//
//  AddCollegeViewController.swift
//  TodoAppPrototype
//
//  Created by Sophia Yin on 2/20/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import UIKit
import CoreData
class AddCollegeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: - Properties
    
    var managedContext: NSManagedObjectContext!
    
    //MARK: Outlets
    
    @IBOutlet weak var collegeListPickerView: UIPickerView!

    @IBOutlet weak var chancesSegmentedController: UISegmentedControl!
    
    
    @IBOutlet weak var timingSegmentedController: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
    }
    let listofcolleges = ["Harvard","Stanford","USC","Michigan","UCLA","Cornell","Tufts","Northwestern","UC Berkeley", "Harvey Mudd", "NYU" ]
    //MARK: Actions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let chosenCollege = listofcolleges[row]
        return chosenCollege
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listofcolleges.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = listofcolleges[row]
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func doneTapped(_ sender: Any) {
        let chosenCollege = label.text
        let college = College(context: managedContext)
        college.collegeName = chosenCollege
        college.chances = Int16(chancesSegmentedController.selectedSegmentIndex)
        college.timing = Int16(timingSegmentedController.selectedSegmentIndex)
        college.date = Date()
        
        do{
            try managedContext.save()
            dismiss(animated: true)
        } catch {
            print("Error Saving College \(error)")
        }
        

    }
    

  

}
