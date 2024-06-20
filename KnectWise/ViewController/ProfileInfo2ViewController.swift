//
//  ProfileInfo2ViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 04/01/24.
//

import UIKit

class ProfileInfo2ViewController : UIViewController {
    
    @IBOutlet weak var backBtn: UIView!
    @IBOutlet weak var number1: UIView!
    @IBOutlet weak var number2: UIView!
    @IBOutlet weak var number3: UIView!
    @IBOutlet weak var number4: UIView!
    @IBOutlet weak var skip: UILabel!
    
    @IBOutlet weak var maleCheck: UIButton!
    @IBOutlet weak var femaleCheck: UIButton!
    @IBOutlet weak var otherCheck: UIButton!
    
    @IBOutlet weak var eyeColourTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var ethencityTF: UITextField!
    @IBOutlet weak var sexualOrientationTF: UITextField!
    
    @IBOutlet weak var homeTownTF: UITextField!
    @IBOutlet weak var jobTitleTF: UITextField!
    @IBOutlet weak var selectChildrenTF: UITextField!
    @IBOutlet weak var saveAndContinueBtn: UIButton!
    
    let eyeColorPicker = UIPickerView()
    let heightPicker = UIPickerView()
    let agePicker = UIPickerView()
    let ethencityPicker = UIPickerView()
    let sexualOrientationPicker = UIPickerView()
    let jobTitlePicker = UIPickerView()
    let selectChildrenPicker = UIPickerView()
   

    
    override func viewDidLoad() {
    
        number1.layer.cornerRadius = 14
        number2.layer.cornerRadius = 14
        number3.layer.cornerRadius = 14
        number4.layer.cornerRadius = 14
        
      
        
        
        eyeColourTF.delegate = self
        heightTF.delegate = self
        ageTF.delegate = self
        ethencityTF.delegate = self
        sexualOrientationTF.delegate = self
        homeTownTF.delegate = self
        jobTitleTF.delegate = self
        selectChildrenTF.delegate = self
        
        
           eyeColorPicker.delegate = self
           eyeColorPicker.dataSource = self
           eyeColorPicker.tag = 1 // Unique identifier for the picker

           heightPicker.delegate = self
           heightPicker.dataSource = self
           heightPicker.tag = 2 // Unique identifier for the picker

           agePicker.delegate = self
           agePicker.dataSource = self
           agePicker.tag = 3 // Unique identifier for the picker
        
        ethencityPicker.delegate = self
        ethencityPicker.dataSource = self
        ethencityPicker.tag = 4 // Unique identifier for the picker
        
        sexualOrientationPicker.delegate = self
        sexualOrientationPicker.dataSource = self
        sexualOrientationPicker.tag = 5 // Unique identifier for the picker
        
        
        jobTitlePicker.delegate = self
        jobTitlePicker.dataSource = self
        jobTitlePicker.tag = 6 // Unique identifier for the picker
        
        selectChildrenPicker.delegate = self
        selectChildrenPicker.dataSource = self
        selectChildrenPicker.tag = 7 // Unique identifier for the picker
        
        eyeColourTF.inputView = eyeColorPicker
         heightTF.inputView = heightPicker
        ageTF.inputView = agePicker
        
        ethencityTF.inputView = ethencityPicker
       sexualOrientationTF.inputView = sexualOrientationPicker
       jobTitleTF.inputView = jobTitlePicker
        selectChildrenTF.inputView = selectChildrenPicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        eyeColourTF.inputAccessoryView = toolBar
        heightTF.inputAccessoryView = toolBar
        ageTF.inputAccessoryView = toolBar
        ethencityTF.inputAccessoryView = toolBar
        sexualOrientationTF.inputAccessoryView = toolBar
        jobTitleTF.inputAccessoryView = toolBar
        selectChildrenTF.inputAccessoryView = toolBar

        backBtn.isUserInteractionEnabled = true
        backBtn.dropShadow()
        backBtn.layer.cornerRadius = 8
        backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        
        self.saveAndContinueBtn.layer.cornerRadius = 8
        
        skip.isUserInteractionEnabled = true
        skip.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipClicked)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    
    @objc func skipClicked(){
        UserModel.data!.profileInfo2Finish = true
        self.ProgressHUDShow(text: "")
        self.updateUserData(userModel: UserModel.data!) { error in
            self.ProgressHUDHide()
            if let error = error {
                self.showError(error.localizedDescription)
            }
            else {
                self.performSegue(withIdentifier: "personalInfo3Seg", sender: nil)
            }
        }
    }
    
    @objc func backBtnClicked(){
        self.dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func maleClicked(_ sender: Any) {
       
            unCheckGender()
        maleCheck.isSelected = true
    }
    @IBAction func femaleClicked(_ sender: Any) {
        unCheckGender()
    femaleCheck.isSelected = true
        
    }
    @IBAction func otherClicked(_ sender: Any) {
        unCheckGender()
        otherCheck.isSelected = true
    }
    
    func unCheckGender(){
         maleCheck.isSelected = false
        femaleCheck.isSelected = false
        otherCheck.isSelected = false
    }
    
    @IBAction func saveAndContinueClick(_ sender: Any) {
        if let userModel = UserModel.data {
            userModel.eyeColour = eyeColourTF.text
            userModel.height = heightTF.text
            userModel.age = ageTF.text
            userModel.ethnicity = ethencityTF.text
            userModel.sexualOrientation = sexualOrientationTF.text
            userModel.jobTitle = jobTitleTF.text
            userModel.children = selectChildrenTF.text
            userModel.homeTown = homeTownTF.text
            userModel.profileInfo2Finish = true
           
            if maleCheck.isSelected {
                userModel.gender = "Male"
            }
            else if femaleCheck.isSelected {
                userModel.gender = "Female"
            }
            else if otherCheck.isSelected {
                userModel.gender = "Other"
            }
            
            self.ProgressHUDShow(text: "")
            self.updateUserData(userModel: userModel) { error in
                self.ProgressHUDHide()
                if let error = error {
                    self.showError(error.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: "personalInfo3Seg", sender: nil)
                }
            }
        }
        else {
            self.showError("UserModel null Error")
        }
        

      
    }
    
}

extension ProfileInfo2ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

extension ProfileInfo2ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // Number of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
         case 1:
            return Constants.eyeColors.count
         case 2:
            return Constants.heights.count
         case 3:
            return Constants.ages.count
        case 4:
           return Constants.ethnicities.count
        case 5:
           return Constants.sexualOrientations.count
        case 6:
           return Constants.jobTitles.count
        case 7:
           return Constants.childrenOptions.count
     
         default:
             return 0
         }
    }

    // Data for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
         case 1:
            return Constants.eyeColors[row]
         case 2:
            return Constants.heights[row]
         case 3:
            return Constants.ages[row]
        case 4:
           return Constants.ethnicities[row]
        case 5:
           return Constants.sexualOrientations[row]
        case 6:
           return Constants.jobTitles[row]
        case 7:
           return Constants.childrenOptions[row]
     
         default:
             return nil
         }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
         case 1:
            eyeColourTF.text = Constants.eyeColors[row]
         case 2:
            heightTF.text = Constants.heights[row]
         case 3:
            ageTF.text = Constants.ages[row]
        case 4:
            ethencityTF.text = Constants.ethnicities[row]
        case 5:
            sexualOrientationTF.text = Constants.sexualOrientations[row]
        case 6:
            jobTitleTF.text = Constants.jobTitles[row]
        case 7:
            selectChildrenTF.text = Constants.childrenOptions[row]
     
         default:
            print("Default")
         }
    }
}
