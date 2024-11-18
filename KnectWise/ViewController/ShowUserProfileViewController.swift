//
//  ShowUserProfileViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 17/10/24.
//

import UIKit
import AVKit
import AVFoundation

class ShowUserProfileViewController : UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!

    @IBOutlet weak var chatView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    
    @IBOutlet weak var placeholder1: UIImageView!
    @IBOutlet weak var placeholder2: UIImageView!
    @IBOutlet weak var placeholder3: UIImageView!
    
    @IBOutlet weak var placeholder4: UIImageView!
    @IBOutlet weak var placeholder5: UIImageView!
    @IBOutlet weak var placeholder6: UIImageView!
    @IBOutlet weak var placeholder7: UIImageView!
    @IBOutlet weak var placeholder8: UIImageView!
    @IBOutlet weak var placeholder9: UIImageView!
    
    @IBOutlet weak var playIcon1: UIImageView!
    @IBOutlet weak var playIcon2: UIImageView!
    @IBOutlet weak var playIcon3: UIImageView!
    
    @IBOutlet weak var playIcon4: UIImageView!
    @IBOutlet weak var playIcon5: UIImageView!
    @IBOutlet weak var playIcon6: UIImageView!
    
    @IBOutlet weak var playIcon7: UIImageView!
    @IBOutlet weak var playIcon8: UIImageView!
    @IBOutlet weak var playIcon9: UIImageView!
    
    @IBOutlet weak var genderStack: UIStackView!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var eyeColourStack: UIStackView!
    @IBOutlet weak var eyeColourLbl: UILabel!
    
    @IBOutlet weak var heightStack: UIStackView!
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var ageStack: UIStackView!
    @IBOutlet weak var ageLbl: UILabel!
    
    @IBOutlet weak var ethnicityStack: UIStackView!
    @IBOutlet weak var ethnicityLbl: UILabel!
    
    @IBOutlet weak var sexualOrientationStack: UIStackView!
    @IBOutlet weak var sexualOrientationLbl: UILabel!
    
    @IBOutlet weak var hometownView: UIStackView!
    @IBOutlet weak var hometownLbl: UILabel!
    
    @IBOutlet weak var childrenStack: UIStackView!
    @IBOutlet weak var childrenLbl: UILabel!
    
    @IBOutlet weak var familyPlanningStack: UIStackView!
    @IBOutlet weak var familyPlanningLbl: UILabel!
    
    @IBOutlet weak var smokeStack: UIStackView!
    @IBOutlet weak var smokeLbl: UILabel!
    
    @IBOutlet weak var drinkStack: UIStackView!
    @IBOutlet weak var drinkLbl: UILabel!
    
    @IBOutlet weak var educationStack: UIStackView!
    @IBOutlet weak var educationLbl: UILabel!
    
    @IBOutlet weak var schoolAttendedStack: UIStackView!
    @IBOutlet weak var schoolAttendedLbl: UILabel!
    
    @IBOutlet weak var religionStack: UIStackView!
    @IBOutlet weak var religionLbl: UILabel!
    
    @IBOutlet weak var prononsStack: UIStackView!
    @IBOutlet weak var pronounsLbl: UILabel!
    
    @IBOutlet weak var politicsStack: UIStackView!
    @IBOutlet weak var politicsLbl: UILabel!
    
    @IBOutlet weak var interestsStack: UIStackView!
    @IBOutlet weak var interestsLbl: UILabel!
    
    @IBOutlet weak var exerciseStack: UIStackView!
    @IBOutlet weak var exerciseLbl: UILabel!
    
    @IBOutlet weak var starSignStack: UIStackView!
    @IBOutlet weak var starSignLbl: UILabel!
    
    @IBOutlet weak var languagesStack: UIStackView!
    @IBOutlet weak var languagesLbl: UILabel!
    
    @IBOutlet weak var lookingForStack: UIStackView!
    @IBOutlet weak var lookingForLbl: UILabel!
    
    @IBOutlet weak var websiteURLStack: UIStackView!
    @IBOutlet weak var websiteURLLbl: UILabel!
    
    @IBOutlet weak var descriptionStack: UIStackView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var mediaStackView: UIStackView!
    var userModel : UserModel?
    
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var stack3: UIStackView!
    
    
    
    override func viewDidLoad() {
    
        guard let userModel = userModel else {
            return
        }
        
        userPic.layer.cornerRadius = 8
        
        backView.layer.cornerRadius = 8
        backView.dropShadow()
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnTapped)))
        
        chatView.isUserInteractionEnabled = true
        chatView.layer.cornerRadius = 8
        chatView.dropShadow()
        chatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chatBtnTapped)))
        
        if let name = userModel.fullName {
            fullName.text = name
        }
        
        if let job = userModel.jobTitle, !job.isEmpty {
            jobTitle.isHidden = false
            jobTitle.text = job
        }
        
        if let path = userModel.profilePic, !path.isEmpty {
            userPic.sd_setImage(with: URL(string: path), placeholderImage: UIImage(named: "profile-placeholder"))
        }
        
        
        if let gender = userModel.gender, !gender.isEmpty {
            genderStack.isHidden = false
            genderLbl.text = gender
        }
        
        if let eyeColour = userModel.eyeColour, !eyeColour.isEmpty {
            eyeColourStack.isHidden = false
            eyeColourLbl.text = eyeColour
        }
        
        if let height = userModel.height,!height.isEmpty {
            heightStack.isHidden = false
            heightLbl.text = height + " cm"
        }
        
        if let age = userModel.age, !age.isEmpty {
           
                ageStack.isHidden = false
                ageLbl.text = String(age) + " years old"
        }
        
        if let ethnicity = userModel.ethnicity, !ethnicity.isEmpty {
            ethnicityStack.isHidden = false
            ethnicityLbl.text = ethnicity
        }
        
        if let sexualOrientation = userModel.sexualOrientation, !sexualOrientation.isEmpty {
            sexualOrientationStack.isHidden = false
            sexualOrientationLbl.text = sexualOrientation
        }
        
        if let homeTown = userModel.homeTown, !homeTown.isEmpty {
            hometownView.isHidden = false
            hometownLbl.text = homeTown
        }
        
        if let children = userModel.children, !children.isEmpty {
            childrenStack.isHidden = false
            childrenLbl.text = children
        }
        
        if let familyPlanning = userModel.familyPlanning, !familyPlanning.isEmpty {
            familyPlanningStack.isHidden = false
            familyPlanningLbl.text = familyPlanning
        }
        
        if let smoke = userModel.smoke, !smoke.isEmpty {
            smokeStack.isHidden = false
            smokeLbl.text = smoke
        }
        
        if let drink = userModel.drink, !drink.isEmpty {
            drinkStack.isHidden = false
            drinkLbl.text = drink
        }
        
        if let educationLevel = userModel.educationLevel, !educationLevel.isEmpty {
            educationStack.isHidden = false
            educationLbl.text = educationLevel
        }
        
        if let nameOfSchoolAttended = userModel.nameOfSchoolAttended, !nameOfSchoolAttended.isEmpty {
            schoolAttendedStack.isHidden = false
            schoolAttendedLbl.text = nameOfSchoolAttended
        }
        
        if let religion = userModel.religion, !religion.isEmpty {
            religionStack.isHidden = false
            religionLbl.text = religion
        }
        
        if let pronouns = userModel.pronouns, !pronouns.isEmpty {
            prononsStack.isHidden = false
            pronounsLbl.text = pronouns
        }
        
        if let politics = userModel.politics, !politics.isEmpty {
            politicsStack.isHidden = false
            politicsLbl.text = politics
        }
        
        if let interests = userModel.interests, !interests.isEmpty {
            interestsStack.isHidden = false
            interestsLbl.text = interests
        }
        
        if let exercise = userModel.exercise, !exercise.isEmpty {
            exerciseStack.isHidden = false
            exerciseLbl.text = exercise
        }
        
        if let starSign = userModel.starSign, !starSign.isEmpty {
            starSignStack.isHidden = false
            starSignLbl.text = starSign
        }
        
        if let language = userModel.language, !language.isEmpty {
            languagesStack.isHidden = false
            languagesLbl.text = language
        }
        
        if let lookingFor = userModel.lookingFor, !lookingFor.isEmpty {
            lookingForStack.isHidden = false
            lookingForLbl.text = lookingFor
        }
        
        if let websiteUrl = userModel.websiteUrl, !websiteUrl.isEmpty {
            websiteURLStack.isHidden = false
            websiteURLLbl.text = websiteUrl
        }
        
        if let description = userModel.mDescription, !description.isEmpty {
            descriptionStack.isHidden = false
            descriptionLbl.text = description
        }
        
        getMedia(uid: userModel.uid!) { medias, error in
            if let medias = medias {
                self.mediaStackView.isHidden = false
                var i = 0
                for media in medias {
                    i = i + 1
                    
                    switch i {
                   
                    case 1:
                        self.view1.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon1.isHidden = false
                            let gest = MyGesture(target: self, action: #selector(self.playVideo))
                            gest.value = url
                            self.view1.isUserInteractionEnabled = true
                            self.view1.addGestureRecognizer(gest)
                            
                            
                        }
                        self.placeholder1.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder1.layer.cornerRadius = 8
                        
                        break
                    case 2:
                        self.view2.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon2.isHidden = false
                            let gest = MyGesture(target: self, action: #selector(self.playVideo))
                            gest.value = url
                            self.view2.isUserInteractionEnabled = true
                            self.view2.addGestureRecognizer(gest)
                        }
                        self.placeholder2.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder2.layer.cornerRadius = 8
                        break
                    case 3:
                        self.view3.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon3.isHidden = false
                            
                            let gest = MyGesture(target: self, action: #selector(self.playVideo))
                            gest.value = url
                            self.view3.isUserInteractionEnabled = true
                            self.view3.addGestureRecognizer(gest)
                            
                        }
                        self.placeholder3.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder3.layer.cornerRadius = 8
                        break
                    case 4:
                        self.stack2.isHidden = false
                        self.view4.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon4.isHidden = false
                            
                            let gest = MyGesture(target: self, action: #selector(self.playVideo))
                            gest.value = url
                            self.view4.isUserInteractionEnabled = true
                            self.view4.addGestureRecognizer(gest)
                            
                        }
                        self.placeholder4.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder4.layer.cornerRadius = 8
                        break
                    case 5:
                        self.view5.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon5.isHidden = false
                            let gest = MyGesture(target: self, action: #selector(self.playVideo))
                            gest.value = url
                            self.view5.isUserInteractionEnabled = true
                            self.view5.addGestureRecognizer(gest)
                            
                        }
                        self.placeholder5.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder5.layer.cornerRadius = 8
                        break
                    case 6:
                        self.view6.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon6.isHidden = false
                            let gest = MyGesture(target: self, action: #selector(self.playVideo))
                            gest.value = url
                            self.view1.isUserInteractionEnabled = true
                            self.view1.addGestureRecognizer(gest)
                            
                        }
                        self.placeholder6.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder6.layer.cornerRadius = 8
                        break
                    case 7:
                        self.stack3.isHidden = false
                        self.view7.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon7.isHidden = false
                            
                        }
                        self.placeholder7.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder7.layer.cornerRadius = 8
                        break
                    case 8:
                        self.view8.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon8.isHidden = false
                            
                        }
                        self.placeholder8.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder8.layer.cornerRadius = 8
                        break
                    case 9:
                        self.view9.isHidden = false
                        if let url = media.url, !url.isEmpty {
                            self.playIcon9.isHidden = false
                            
                        }
                        self.placeholder9.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder9.layer.cornerRadius = 8
                        break
                        
                    default:
                        print("OH NO")
                    }
                  
                }
              
            }
         }
        self.hideAllPlayIcons()
    }
    
    @objc func playVideo(gest : MyGesture) {
        
        guard let videoLink = gest.value else {
            return
        }
        // Create an AVPlayer instance with the provided URL
        let player = AVPlayer(url: URL(string: videoLink)!)
               
               // Create an AVPlayerViewController instance
               let playerViewController = AVPlayerViewController()
               playerViewController.player = player
               
               // Present the playerViewController
               present(playerViewController, animated: true) {
                   // Start playing the video once the playerViewController is presented
                   player.play()
               }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatViewUserProfileSeg" {
            if let vc = segue.destination as? ShowChatViewController {
                let lastModel = LastMessageModel()
                lastModel.senderName = userModel?.fullName ?? "Full Name"
                lastModel.senderUid = userModel?.uid ?? ""
                lastModel.senderToken = userModel?.notificationToken ?? "Token"
                lastModel.senderImage = userModel?.profilePic ?? ""
                lastModel.senderToken = userModel?.notificationToken ?? ""
                vc.lastMessage = lastModel
            }
        }
    }
    
    func hideAllPlayIcons(){
        playIcon1.isHidden = true
        playIcon2.isHidden = true
        playIcon3.isHidden = true
        playIcon4.isHidden = true
        playIcon5.isHidden = true
        playIcon6.isHidden = true
        playIcon7.isHidden = true
        playIcon8.isHidden = true
        playIcon9.isHidden = true
    }
  
    @objc func chatBtnTapped() {
        performSegue(withIdentifier: "chatViewUserProfileSeg", sender: nil)
    }
    

    @objc func backBtnTapped() {
        dismiss(animated: true, completion: nil)
    }
}
