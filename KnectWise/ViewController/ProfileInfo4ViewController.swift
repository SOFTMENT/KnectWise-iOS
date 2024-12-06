//
//  ProfileInfo4ViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 04/01/24.
//

import UIKit
import MediaPlayer

class ProfileInfo4ViewController : UIViewController {
    
    @IBOutlet weak var backBtn: UIView!
    @IBOutlet weak var number1: UIView!
    @IBOutlet weak var number2: UIView!
    @IBOutlet weak var number3: UIView!
    @IBOutlet weak var number4: UIView!
    @IBOutlet weak var skip: UILabel!
    @IBOutlet weak var saveAndContinueBtn: UIButton!
    @IBOutlet weak var uploadVoiceBtn: UIButton!
    
    @IBOutlet weak var interestsTF: UITextField!
    @IBOutlet weak var exerciseTF: UITextField!
    @IBOutlet weak var starSignTF: UITextField!
    @IBOutlet weak var languagesTF: UITextField!
    @IBOutlet weak var lookingForTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    @IBOutlet weak var mDescriptionTF: UITextView!
    
    let interestsPicker = UIPickerView()
    let exercisePicker = UIPickerView()
    let starSignPicker = UIPickerView()
    let languagesPicker = UIPickerView()
    let lookingForPicker = UIPickerView()
    
    override func viewDidLoad() {
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
        
        uploadVoiceBtn.layer.cornerRadius = 8
        
        
        interestsPicker.delegate = self
        interestsPicker.dataSource = self
        interestsPicker.tag = 1 // Unique identifier for the picker
        
        exercisePicker.delegate = self
        exercisePicker.dataSource = self
        exercisePicker.tag = 2 // Unique identifier for the picker
        
        starSignPicker.delegate = self
        starSignPicker.dataSource = self
        starSignPicker.tag = 3 // Unique identifier for the picker
        
        languagesPicker.delegate = self
        languagesPicker.dataSource = self
        languagesPicker.tag = 4 // Unique identifier for the picker
        
        
        lookingForPicker.delegate = self
        lookingForPicker.dataSource = self
        lookingForPicker.tag = 5 // Unique identifier for the picker
        
        
   
      
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        interestsTF.inputAccessoryView = toolBar
        exerciseTF.inputAccessoryView = toolBar
        starSignTF.inputAccessoryView = toolBar
        languagesTF.inputAccessoryView = toolBar
        lookingForTF.inputAccessoryView = toolBar
    
        
        
        interestsTF.delegate = self
        exerciseTF.delegate = self
        starSignTF.delegate = self
       languagesTF.delegate = self
      lookingForTF.delegate = self
       websiteTF.delegate = self
        
        
        interestsTF.inputView = interestsPicker
        exerciseTF.inputView = exercisePicker
        starSignTF.inputView = starSignPicker
       languagesTF.inputView = languagesPicker
      lookingForTF.inputView = lookingForPicker
      
       
        mDescriptionTF.layer.cornerRadius = 8
        mDescriptionTF.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        mDescriptionTF.layer.borderWidth = 1
        mDescriptionTF.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

       
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        if let userModel = UserModel.data {
            userModel.interests = interestsTF.text
            userModel.exercise = exerciseTF.text
            userModel.starSign = starSignTF.text
            userModel.language = languagesTF.text
            userModel.lookingFor = lookingForTF.text
            userModel.websiteUrl = websiteTF.text
            userModel.mDescription = mDescriptionTF.text
            userModel.profileInfo4Finish = true
            
            self.ProgressHUDShow(text: "")
            self.updateUserData(userModel: userModel) { error in
                self.ProgressHUDHide()
                if let error = error {
                    self.showError(error.localizedDescription)
                }
                else {
                    self.beRootScreen(mIdentifier: Constants.StroyBoard.tabBarViewController)
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
        UserModel.data!.profileInfo4Finish = true
        self.ProgressHUDShow(text: "")
        self.updateUserData(userModel: UserModel.data!) { error in
            self.ProgressHUDHide()
            if let error = error {
                self.showError(error.localizedDescription)
            }
            else {
                self.beRootScreen(mIdentifier: Constants.StroyBoard.tabBarViewController)
            }
        }
    }
    
    @objc func backBtnClicked(){
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadVoiceClicked(_ sender: Any) {
        
        if uploadVoiceBtn.currentTitle == "Voice Uploaded" {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Replace", style: .default, handler: { action in
                // Create UTType for audio
                      let audioType = UTType.audio
                      // Initialize the document picker for audio files
                      let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [audioType])
                      documentPicker.delegate = self
                self.present(documentPicker, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { action in
                self.uploadVoiceBtn.setTitle("Upload", for: .normal)
                self.uploadVoiceBtn.backgroundColor = UIColor(red: 35/255, green: 59/255, blue: 186/255, alpha: 1)
                UserModel.data!.voiceRecord = nil
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
        else {
            // Create UTType for audio
                  let audioType = UTType.audio
                  // Initialize the document picker for audio files
                  let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [audioType])
                  documentPicker.delegate = self
                  present(documentPicker, animated: true, completion: nil)
        }
        
    }
    
    
    
    
}

extension ProfileInfo4ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}


extension ProfileInfo4ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // Number of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
         case 1:
            return Constants.interestsOptions.count
         case 2:
            return   Constants.exerciseOptions.count
         case 3:
            return Constants.starSignOptions.count
        case 4:
           return Constants.languagesOptions.count
        case 5:
           return Constants.lookingForOptions.count
      
         default:
             return 0
         }
    }

    // Data for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
         case 1:
            return Constants.interestsOptions[row]
         case 2:
            return  Constants.exerciseOptions[row]
         case 3:
            return Constants.starSignOptions[row]
        case 4:
           return Constants.languagesOptions[row]
        case 5:
           return Constants.lookingForOptions[row]
      
     
         default:
             return nil
         }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
         case 1:
            interestsTF.text = Constants.interestsOptions[row]
         case 2:
            exerciseTF.text = Constants.exerciseOptions[row]
         case 3:
           starSignTF.text = Constants.starSignOptions[row]
        case 4:
           languagesTF.text = Constants.languagesOptions[row]
        case 5:
            lookingForTF.text = Constants.lookingForOptions[row]
      
     
         default:
            print("Default")
         }
    }
}

extension ProfileInfo4ViewController : UIDocumentPickerDelegate {
    
    // UIDocumentPickerDelegate methods
      func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
          
          guard let url = urls.first else { return }

            // Check if the URL is a file URL
            guard url.isFileURL && !url.hasDirectoryPath else {
                print("The URL is not a file URL or is a directory.")
                return
            }
          
          if url.startAccessingSecurityScopedResource() {
              let fileManager = FileManager.default
              let tempDir = fileManager.temporaryDirectory
              let tempFileURL = tempDir.appendingPathComponent(url.lastPathComponent)

              do {
                  if fileManager.fileExists(atPath: tempFileURL.path) {
                      try fileManager.removeItem(at: tempFileURL)
                  }
                  try fileManager.copyItem(at: url, to: tempFileURL)
                  // Now use tempFileURL for uploading
                  self.uploadMediaOnCloud(media: .audio(audioPath: tempFileURL, folderName: "Voices"), id: FirebaseStoreManager.auth.currentUser!.uid) { downloadURL, error in
                      if let error = error {
                          self.showError(error)
                      }
                      else {
                          self.uploadVoiceBtn.setTitle("Voice Uploaded", for: .normal)
                          self.uploadVoiceBtn.backgroundColor = UIColor(red: 40/255, green: 167/255, blue: 69/255, alpha: 1)
                          UserModel.data!.voiceRecord = downloadURL
                          
                      }
                  }
              } catch {
                  print("Failed to copy file: \(error)")
              }

              url.stopAccessingSecurityScopedResource()
          }

      }
    
  
   
}
