//
//  EditProfile3ViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 03/03/24.
//

import UIKit

class EditProfile3ViewController : UIViewController {
    @IBOutlet weak var backBtn: UIView!
    @IBOutlet weak var number1: UIView!
    @IBOutlet weak var number2: UIView!
    @IBOutlet weak var number3: UIView!
    @IBOutlet weak var number4: UIView!
    @IBOutlet weak var skip: UILabel!
    @IBOutlet weak var saveAndContinueBtn: UIButton!
    
    @IBOutlet weak var wantKidsCheck: UIButton!
    @IBOutlet weak var doesntWantKidsCheck: UIButton!
    
    @IBOutlet weak var smokeTF: UITextField!
    @IBOutlet weak var drinkTF: UITextField!
    @IBOutlet weak var drugsTF: UITextField!
    @IBOutlet weak var educationLevelTF: UITextField!
    @IBOutlet weak var schoolAttendedTF: UITextField!
    @IBOutlet weak var religionTF: UITextField!
    @IBOutlet weak var pronounsTF: UITextField!
    @IBOutlet weak var politicsTF: UITextField!
    
    
    let smokePicker = UIPickerView()
    let drinkPicker = UIPickerView()
    let drugsPicker = UIPickerView()
    let educationLevelPicker = UIPickerView()
    let religionPicker = UIPickerView()
    let pronounPicker = UIPickerView()
    let politicsPicker = UIPickerView()
    
    @IBOutlet weak var familySwitch: UISegmentedControl!
    @IBOutlet weak var smokeSwitch: UISegmentedControl!
    @IBOutlet weak var drinkSwitch: UISegmentedControl!
    @IBOutlet weak var drugsSwitch: UISegmentedControl!
    @IBOutlet weak var educationLevelSwitch: UISegmentedControl!
    @IBOutlet weak var schoolAttendedSwitch: UISegmentedControl!
    @IBOutlet weak var religionSwitch: UISegmentedControl!
    @IBOutlet weak var pronousSwitch: UISegmentedControl!
    @IBOutlet weak var politicsSwitch: UISegmentedControl!
    
    
    override func viewDidLoad() {
        guard let user = UserModel.data else {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }
        number1.layer.cornerRadius = 14
        number2.layer.cornerRadius = 14
        number3.layer.cornerRadius = 14
        number4.layer.cornerRadius = 14
        
        
        
        backBtn.isUserInteractionEnabled = true
        backBtn.dropShadow()
        backBtn.layer.cornerRadius = 8
        backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        
        self.saveAndContinueBtn.layer.cornerRadius = 8
        
        skip.isUserInteractionEnabled = true
        skip.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipClicked)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        smokePicker.delegate = self
        smokePicker.dataSource = self
        smokePicker.tag = 1 // Unique identifier for the picker
        
        drinkPicker.delegate = self
        drinkPicker.dataSource = self
        drinkPicker.tag = 2 // Unique identifier for the picker
        
        drugsPicker.delegate = self
        drugsPicker.dataSource = self
        drugsPicker.tag = 3 // Unique identifier for the picker
        
        educationLevelPicker.delegate = self
        educationLevelPicker.dataSource = self
        educationLevelPicker.tag = 4 // Unique identifier for the picker
        
        
        religionPicker.delegate = self
        religionPicker.dataSource = self
        religionPicker.tag = 5 // Unique identifier for the picker
        
        
       pronounPicker.delegate = self
        pronounPicker.dataSource = self
        pronounPicker.tag = 6 // Unique identifier for the picker
        
        
       politicsPicker.delegate = self
        politicsPicker.dataSource = self
        politicsPicker.tag = 7 // Unique identifier for the picker
        
      
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        
        smokeTF.inputAccessoryView = toolBar
        drinkTF.inputAccessoryView = toolBar
        drugsTF.inputAccessoryView = toolBar
       educationLevelTF.inputAccessoryView = toolBar
        religionTF.inputAccessoryView = toolBar
      pronounsTF.inputAccessoryView = toolBar
    politicsTF.inputAccessoryView = toolBar
       
        
        
        if let familyPlanning = user.familyPlanning , !familyPlanning.isEmpty {
            if familyPlanning == "Want Kids" {
                wantKidsCheck.isSelected = true
            }
            else {
                doesntWantKidsCheck.isSelected = true
            }
        }
        
        
        familySwitch.selectedSegmentIndex = (user.isGenderActive ?? true) == true ? 0 : 1
        
        smokeTF.delegate = self
        smokeTF.text = user.smoke ?? ""
        smokeSwitch.selectedSegmentIndex = (user.isSmokeActive ?? true) == true ? 0 : 1
        
        drinkTF.delegate = self
        drinkTF.text = user.drink ?? ""
        drinkSwitch.selectedSegmentIndex = (user.isDrinkActive ?? true) == true ? 0 : 1
        
        drugsTF.delegate = self
        drugsTF.text = user.drugs ?? ""
        drugsSwitch.selectedSegmentIndex = (user.isDrugsActive ?? true) == true ? 0 : 1
        
        educationLevelTF.delegate = self
        educationLevelTF.text = user.educationLevel ?? ""
        educationLevelSwitch.selectedSegmentIndex = (user.isEducationActive ?? true) == true ? 0 : 1
        
        schoolAttendedTF.delegate = self
        schoolAttendedTF.text = user.nameOfSchoolAttended ?? ""
        schoolAttendedSwitch.selectedSegmentIndex = (user.isNameOfSchoolActive ?? true) == true ? 0 : 1
        
        religionTF.delegate = self
        religionTF.text = user.religion ?? ""
        religionSwitch.selectedSegmentIndex = (user.isReligionActive ?? true) == true ? 0 : 1
        
        pronounsTF.delegate = self
        pronounsTF.text = user.religion ?? ""
        pronousSwitch.selectedSegmentIndex = (user.isPronounsActive ?? true) == true ? 0 : 1
        
        politicsTF.delegate = self
        politicsTF.text = user.religion ?? ""
        politicsSwitch.selectedSegmentIndex = (user.isPoliticsActive ?? true) == true ? 0 : 1
        
       
        
        smokeTF.inputView = smokePicker
        drinkTF.inputView = drinkPicker
         drugsTF.inputView = drugsPicker
       educationLevelTF.inputView = educationLevelPicker
     
       religionTF.inputView = religionPicker
         pronounsTF.inputView = pronounPicker
       politicsTF.inputView = politicsPicker
   
    }
    
    
    @IBAction func familySwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isFamilyPlanningActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    @IBAction func smokeSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isSmokeActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    @IBAction func drinkSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isDrinkActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    @IBAction func drugsSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isDrugsActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    @IBAction func educationLevelSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isEducationActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    @IBAction func schoolAttendedSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isNameOfSchoolActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    @IBAction func religionSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isReligionActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    @IBAction func pronounsSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isPronounsActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    
    @IBAction func politicsSwitchClicked(_ sender: UISegmentedControl) {
        UserModel.data!.isPoliticsActive = sender.selectedSegmentIndex == 0 ? true : false
        updateUserOnFirebase()
    }
    
    func updateUserOnFirebase(){
        updateUserData(userModel: UserModel.data!) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func unCheckAllFamilyPlan(){
        wantKidsCheck.isSelected = false
        doesntWantKidsCheck.isSelected = false
    }
    
    @IBAction func wantKidsClicked(_ sender: Any) {
        unCheckAllFamilyPlan()
        wantKidsCheck.isSelected = true
        
    }
    
    @IBAction func doesnWantKidsClicked(_ sender: Any) {
        unCheckAllFamilyPlan()
        doesntWantKidsCheck.isSelected = true
    }
    
    @IBAction func saveAndContinueClicked(_ sender: Any) {
        
        if let userModel = UserModel.data {
            userModel.smoke = smokeTF.text
            userModel.drink = drinkTF.text
            userModel.drugs = drugsTF.text
            userModel.educationLevel = educationLevelTF.text
            userModel.nameOfSchoolAttended = schoolAttendedTF.text
            userModel.politics = politicsTF.text
            userModel.pronouns = pronounsTF.text
            userModel.religion = religionTF.text
            
            if wantKidsCheck.isSelected {
                userModel.familyPlanning = "Want Kids"
            }
            else if doesntWantKidsCheck.isSelected {
                userModel.familyPlanning = "Doesn't Want Kids"
            }
            
            userModel.profileInfo3Finish = true
            
            self.ProgressHUDShow(text: "")
            self.updateUserData(userModel: userModel) { error in
                self.ProgressHUDHide()
                if let error = error {
                    self.showError(error.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: "editIInfo4Seg", sender: nil)
                }
            }
        }
        else {
            self.showError("UserModel null Error")
        }
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func skipClicked(){
        UserModel.data!.profileInfo3Finish = true
        self.ProgressHUDShow(text: "")
        self.updateUserData(userModel: UserModel.data!) { error in
            self.ProgressHUDHide()
            if let error = error {
                self.showError(error.localizedDescription)
            }
            else {
                self.performSegue(withIdentifier: "editIInfo4Seg", sender: nil)
            }
        }
    }
    
    @objc func backBtnClicked(){
        self.dismiss(animated: true)
    }
}
extension EditProfile3ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

extension EditProfile3ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // Number of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
         case 1:
            return Constants.smokingOptions.count
         case 2:
            return  Constants.drinkOptions.count
         case 3:
            return Constants.drugsOptions.count
        case 4:
           return Constants.educationLevelOptions.count
        case 5:
           return Constants.religionOptions.count
        case 6:
           return Constants.pronounsOptions.count
        case 7:
           return Constants.politicsOptions.count
     
         default:
             return 0
         }
    }

    // Data for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
         case 1:
            return Constants.smokingOptions[row]
         case 2:
            return  Constants.drinkOptions[row]
         case 3:
            return Constants.drugsOptions[row]
        case 4:
           return Constants.educationLevelOptions[row]
        case 5:
           return Constants.religionOptions[row]
        case 6:
           return Constants.pronounsOptions[row]
        case 7:
           return Constants.politicsOptions[row]
     
         default:
             return nil
         }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
         case 1:
            smokeTF.text = Constants.smokingOptions[row]
         case 2:
            drinkTF.text = Constants.drinkOptions[row]
         case 3:
            drugsTF.text = Constants.drugsOptions[row]
        case 4:
            educationLevelTF.text = Constants.educationLevelOptions[row]
        case 5:
            religionTF.text = Constants.religionOptions[row]
        case 6:
            pronounsTF.text = Constants.pronounsOptions[row]
        case 7:
          politicsTF.text = Constants.politicsOptions[row]
     
         default:
            print("Default")
         }
    }
}
