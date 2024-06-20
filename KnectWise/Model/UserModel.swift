//
//  UserModel.swift
//  KnectWise
//
//  Created by Vijay Rathore on 31/12/23.
//
import UIKit

class UserModel : NSObject, Codable {
   

    var fullName : String?
    var email : String?
    var uid : String?
    var registredAt : Date?
    var regiType : String?
    var profilePic : String?
    
    var gender : String?
    var isGenderActive : Bool?
    
    var eyeColour : String?
    var isEyeColourActive : Bool?
    
    var height : String?
    var isHeightActive : Bool?
    
    var age : String?
    var isAgeActive : Bool?
    
    var ethnicity : String?
    var isEthnicityActive : Bool?
    
    var sexualOrientation : String?
    var isSexualOrientationActive : Bool?
    
    var homeTown : String?
    var isHomeTownActive : Bool?
    
    var jobTitle : String?
    var isJobTitleActive : Bool?
    
    var children : String?
    var isChildrenActive : Bool?
    
    var familyPlanning : String?
    var isFamilyPlanningActive : Bool?
    
    var smoke : String?
    var isSmokeActive : Bool?
    
    var drink : String?
    var isDrinkActive : Bool?
    
    var drugs : String?
    var isDrugsActive : Bool?
    
    var educationLevel : String?
    var isEducationActive : Bool?
    
    var nameOfSchoolAttended : String?
    var isNameOfSchoolActive : Bool?
    
    var religion : String?
    var isReligionActive : Bool?
    
    var pronouns : String?
    var isPronounsActive : Bool?
    
    var politics:  String?
    var isPoliticsActive : Bool?
    
    var voiceRecord : String?
    var isVoiceRecordActive : Bool?
    
    var interests : String?
    var isInterestsActive : Bool?
    
    var exercise : String?
    var isExerciseActive : Bool?
    
    var starSign : String?
    var isStarSignActive : Bool?
    
    var language : String?
    var isLanguageActive : Bool?
    
    var lookingFor : String?
    var isLookingForActive : Bool?
    
    var websiteUrl : String?
    var isWebsiteUrlActive : Bool?
    
    var mDescription : String?
    var isMDescriptionActive : Bool?
    
    var profileInfo2Finish : Bool?
    var profileInfo3Finish : Bool?
    var profileInfo4Finish : Bool?
    
    
    private static var userData : UserModel?
    
    static func clearUserData() {
        self.userData = nil
    }
    
    static var data : UserModel? {
        set(userData) {
            if self.userData == nil {
                self.userData = userData
            }
        
            
        }
        get {
            return userData
        }
    }


    override init() {
        
    }
    
}
