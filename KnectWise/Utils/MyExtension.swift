//
//  MyExtension.swift
//  KnectWise
//
//  Created by Vijay Rathore on 31/12/23.
//


import UIKit
import MBProgressHUD
import TTGSnackbar
import GoogleSignIn
import AVFoundation
import Firebase
import Cloudinary

extension UIView {
    
    func addBorderColourAndRadius(){
       layer.cornerRadius = 8
     layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 57/255, green: 1, blue: 20/255, alpha: 1).cgColor
    }
    
}

extension Int {
    func numberFormator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "ERROR"
    }
}

extension UITextField {
    
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 22, height: 22)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
        
    }
    
    func setRightView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 22, height: 22)) // set your Own size
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        
        rightViewMode = .always
        self.tintColor = .lightGray
        
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.rightView = paddingView
        self.rightViewMode = .always
        
    }
    
    func changePlaceholderColour()  {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)])
    }
    
    
    
    /// set icon of 20x20 with left padding of 8px
    func setLeftIcons(icon: UIImage) {
        
        let padding = 8
        let size = 20
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    
    
    
    /// set icon of 20x20 with left padding of 8px
    func setRightIcons(icon: UIImage) {
        
        let padding = 8
        let size = 12
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: -padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        rightView = outerView
        rightViewMode = .always
    }
    
}

extension Date {
    
    
    func removeTimeStamp() -> Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return  nil
        }
        return date
    }
    
    func timeAgoSinceDate() -> String {
        
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        
        return "a moment ago"
    }
}




extension UIViewController {
    
  
    
    func loginWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting : self) { [unowned self] result, error in
            
            if let error = error {
              
                return
            }
            
            guard let user = result?.user,
              let idToken = user.idToken?.tokenString
            else {
             return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            self.authWithFirebase(credential: credential,type: "google", displayName: "")
            
        }
    }
    
    func getAge(birthDay : Date) -> Int{
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDay, to: now)
        return ageComponents.year!
        
    }
    
    func showSnack(messages : String) {
        
        let snackbar = TTGSnackbar(message: messages, duration: .long)
        snackbar.messageLabel.textAlignment = .center
        snackbar.show()
    }
    
    func DownloadProgressHUDShow(text : String) -> MBProgressHUD{
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.mode = .indeterminate
        loading.label.text =  text
        loading.label.font = UIFont(name: "Roboto-Medium", size: 11)
        return loading
    }
    func DownloadProgressHUDUpdate(loading : MBProgressHUD, text : String) {
        
        loading.label.text =  text
        
    }
    func ProgressHUDShow(text : String) {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.mode = .indeterminate
        loading.label.text =  text
        loading.label.font = UIFont(name: "Roboto-Medium", size: 11)
    }
    
    func ProgressHUDHide(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func convertSecondsToMinAndSec(totalSec : Int) -> String{
        let min = (totalSec % 3600) / 60
        let sec = totalSec % 60
        return String(format: "%02d:%02d", min, sec)
    }
    
    
    func addUserData(userData : UserModel) {
        
        ProgressHUDShow(text: "")
        try?  FirebaseStoreManager.db.collection("Users").document(userData.uid ?? "123").setData(from: userData,completion: { error in
            self.ProgressHUDHide()
            if error != nil {
                self.showError(error!.localizedDescription)
            }
            else {
                self.getUserData(uid: userData.uid ?? "123", showProgress: true)
                
            }
            
        })
    }
    
    func updateUserData(userModel : UserModel, completion : @escaping (_ error : Error?)->Void){
        try? FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).setData(from: userModel, merge : true, completion: { error in
           completion(error)
            
        })
    }
   
    func compressVideo(sourceURL: URL, completion: @escaping (URL?, Error?) -> Void) {
       let asset = AVAsset(url: sourceURL)
       let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality)
       
       let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       let compressedURL = documentsDirectory.appendingPathComponent("compressedVideo.mp4")
       
       do {
           if FileManager.default.fileExists(atPath: compressedURL.path) {
               try FileManager.default.removeItem(at: compressedURL)
           }
       } catch {}


       exportSession?.outputURL = compressedURL
       exportSession?.outputFileType = .mp4
       exportSession?.exportAsynchronously {
           switch exportSession?.status {
           case .completed:
               completion(compressedURL, nil)
           case .failed, .cancelled:
               completion(nil, exportSession?.error)
           default:
               break
           }
       }
   }


    func getMedia(uid : String, completion : @escaping (_ medias : Array<MediaModel>?, _ error : String?)->Void) {
        
        FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).collection("Media").order(by: "index").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            }
            else {
                var medias = Array<MediaModel>()
                if let snapshot = snapshot, !snapshot.isEmpty {
                    for qdr in snapshot.documents {
                        if let mediaModel = try? qdr.data(as: MediaModel.self) {
                            medias.append(mediaModel)
                        }
                    }
                }
                completion(medias, nil)
            }
        }
        
    }
    
    func getUserData(uid : String, showProgress : Bool)  {
        
        if showProgress {
            ProgressHUDShow(text: "")
        }
        
        FirebaseStoreManager.db.collection("Users").document(uid)
             .getDocument(as: UserModel.self, completion: { result in
                 if showProgress {
                     self.ProgressHUDHide()
                 }
                switch result {
                case .success(let userModel):
                    
                    UserModel.data = userModel
                    
                    if let profilePic = userModel.profilePic, !profilePic.isEmpty {
                        if let profileInfo2Finish = userModel.profileInfo2Finish , profileInfo2Finish {
                            if let profileInfo3Finish = userModel.profileInfo3Finish , profileInfo3Finish {
                                if let profileInfo4Finish = userModel.profileInfo4Finish , profileInfo4Finish {
                                    self.beRootScreen(mIdentifier: Constants.StroyBoard.tabBarViewController)
                                }
                                else {
                                    self.beRootScreen(mIdentifier: Constants.StroyBoard.profileInfo4ViewController)
                                }
                            }
                            else {
                                self.beRootScreen(mIdentifier: Constants.StroyBoard.profileInfo3ViewController)
                            }
                        }
                        else {
                            self.beRootScreen(mIdentifier: Constants.StroyBoard.profileInfo2ViewController)
                        }
                    }
                    else {
                        self.beRootScreen(mIdentifier: Constants.StroyBoard.profileInfo1ViewController)
                    }
                 
                    
                case .failure(_):
                    DispatchQueue.main.async {
                        self.beRootScreen(mIdentifier: Constants.StroyBoard.signInViewController)
                    }
                   
                }
            })
           
        
    }
    
    enum MediaType {
        case image(UIImage, folderName: String)
        case video(URL, folderName: String)
        case audio(audioPath: URL, folderName: String)
    }

    func deleteMediaOfCloud(folderPath: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
           
            return
        }
        appDelegate.cloudinary.createManagementApi().destroy(folderPath) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func uploadMediaOnCloud(media: MediaType, id: String, completion: @escaping (String?, String?) -> Void ) {
    
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, "Something went wrong")
            return
        }
        
        let uploader = appDelegate.cloudinary!.createUploader()
        let loading = self.DownloadProgressHUDShow(text: "Uploading : 0.0%")
        
        switch media {
        case .image(let image, let folderName):
            let params = CLDUploadRequestParams().setPublicId("\(FirebaseStoreManager.auth.currentUser!.uid)\(id)").setFolder(folderName)
            if let imageData = image.jpegData(compressionQuality: 0.5) {
            
 
                
                uploader.signedUpload(data: imageData, params: params).progress { progress in
                    DispatchQueue.main.async {
                        self.DownloadProgressHUDUpdate(loading: loading, text: "Image Uploading : \(String(format: "%.2f", progress.fractionCompleted * 100))%")
                    }
                   
                }.response { result, error in
                    DispatchQueue.main.async {
                        self.ProgressHUDHide()
                        if let error = error {
                            print(error.localizedDescription)
                            completion(nil, error.localizedDescription)
                        } else {
                            completion(result?.secureUrl, nil)
                        }
                    }
                }
            }
            
        case .video(let videoPath, let folderName):
            let params = CLDUploadRequestParams().setPublicId("\(FirebaseStoreManager.auth.currentUser!.uid)\(id)").setFolder(folderName).setResourceType("video")
            uploader.signedUpload(url: videoPath, params: params).progress { progress in
                DispatchQueue.main.async {
                    self.DownloadProgressHUDUpdate(loading: loading, text: "Video Uploading : \(String(format: "%.2f", progress.fractionCompleted * 100))%")
                }
            }.response { result, error in
                DispatchQueue.main.async {
                    self.ProgressHUDHide()
                    if let error = error {
                        completion(nil, error.localizedDescription)
                    } else {
                        completion(result?.secureUrl, nil)
                    }
                }
            }
        case .audio(audioPath: let audioPath, folderName: let folderName):
            let params = CLDUploadRequestParams().setPublicId("\(FirebaseStoreManager.auth.currentUser!.uid)\(id)").setFolder(folderName).setResourceType("auto")
                    uploader.signedUpload(url: audioPath, params: params).progress { progress in
                        DispatchQueue.main.async {
                            self.DownloadProgressHUDUpdate(loading: loading, text: "Voice Uploading : \(String(format: "%.2f", progress.fractionCompleted * 100))%")
                        }
                    }.response { result, error in
                        DispatchQueue.main.async {
                            self.ProgressHUDHide()
                            if let error = error {
                                completion(nil, error.localizedDescription)
                            } else {
                                completion(result?.secureUrl, nil)
                            }
                        }
                       
                    }
        }
    }

    
    func navigateToAnotherScreen(mIdentifier : String)  {
        
        let destinationVC = getViewControllerUsingIdentifier(mIdentifier: mIdentifier)
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true) {
            
        }
    }
    
  
    
    func getViewControllerUsingIdentifier(mIdentifier : String) -> UIViewController{
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        switch mIdentifier {
        case Constants.StroyBoard.signInViewController:
            return (mainStoryboard.instantiateViewController(identifier: mIdentifier) as? SignInViewController)!
            
            
        case Constants.StroyBoard.tabBarViewController :
            return (mainStoryboard.instantiateViewController(identifier: mIdentifier) as? UITabBarController )!
            
        case Constants.StroyBoard.profileInfo1ViewController :
            return (mainStoryboard.instantiateViewController(identifier: mIdentifier) as? ProfileInfo1ViewController )!
            
        case Constants.StroyBoard.profileInfo2ViewController :
            return (mainStoryboard.instantiateViewController(identifier: mIdentifier) as? ProfileInfo2ViewController )!
            
        case Constants.StroyBoard.profileInfo3ViewController :
            return (mainStoryboard.instantiateViewController(identifier: mIdentifier) as? ProfileInfo3ViewController )!
            
        case Constants.StroyBoard.profileInfo4ViewController :
            return (mainStoryboard.instantiateViewController(identifier: mIdentifier) as? ProfileInfo4ViewController )!
            
            
            
            
        default:
            return (mainStoryboard.instantiateViewController(identifier: Constants.StroyBoard.signInViewController) as? SignInViewController)!
        }
    }
    
    func beRootScreen(mIdentifier : String) {
        
        guard let window = self.view.window else {
            self.view.window?.rootViewController = getViewControllerUsingIdentifier(mIdentifier: mIdentifier)
            self.view.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = getViewControllerUsingIdentifier(mIdentifier: mIdentifier)
        window.makeKeyAndVisible()
        
        
    }
    
  
    
    func convertDateToMonthFormater(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    public func getDateDifference(startDate : Date, endDate : Date) -> String {
          //milliseconds
        var different = endDate.mMillisecondsSince1970 - startDate.mMillisecondsSince1970

          let secondsInMilli = 1000;
          let  minutesInMilli = secondsInMilli * 60;
          let hoursInMilli = minutesInMilli * 60;
          let daysInMilli = hoursInMilli * 24;

          let elapsedDays = different / Int64(daysInMilli)
        different = different % Int64(daysInMilli)

            let  elapsedHours = different / Int64(daysInMilli)
        different = different % Int64(hoursInMilli);

         let elapsedMinutes = different / Int64(daysInMilli)

         let diff = String(format: "%d:d %d:h %d:m",elapsedDays, elapsedHours, elapsedMinutes)
        return diff.replacingOccurrences(of: ":", with: "")
      }
    func convertDateAndTimeFormater(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy, hh:mm a"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    func convertDateFormaterWithoutDash(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    func convertDatetoString(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "E, dd MMM yyyy"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    func convertDateToYearMonthDay(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    func convertDateToYearMonth(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "yyyyMM"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    func convertDateToString(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    func convertDateForHomePage(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "EEEE, dd MMMM"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    func convertDateForVoucher(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "E, MMM dd  yyyy • hh:mm a"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    func convertDateForTicket(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "E,MMM dd, yyyy hh:mm a"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    
    
    func convertDateIntoTime(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return "\(df.string(from: date))"
        
        
    }
    
    
    
    func convertDateIntoMonthAndYearForRecurringVoucher(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "MMM • yyyy"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return "\(df.string(from: date))"
        
    }
    
    func convertDateIntoDayForRecurringVoucher(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return "\(df.string(from: date))"
        
    }
    
    func convertDatetoDay(_ date: Date) -> Int
    {
        let df = DateFormatter()
        df.dateFormat = "d"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return Int(df.string(from: date))!
        
    }
    
    func convertDateForShowTicket(_ date: Date, endDate :Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "E,dd"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        let s = "\(df.string(from: date))-\(df.string(from: endDate))"
        df.dateFormat = "MMM yyyy"
        return "\(s) \(df.string(from: date))"
    }
    
    func convertTimeFormater(_ date: Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.timeZone = TimeZone.current
        return df.string(from: date)
        
    }
    
    
    func showError(_ message : String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showMessage(title : String,message : String, shouldDismiss : Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",style: .default) { action in
            if shouldDismiss {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func handleError(_ error: Error) {
        if let errCode = AuthErrorCode.Code(rawValue: error._code) {
            var message: String
            
            switch errCode {
            case .userNotFound:
                message = "There is no user record corresponding to this identifier. Please sign up."
            case .emailAlreadyInUse:
                message = "The email is already in use with another account."
            case .invalidEmail:
                message = "Please enter a valid email."
            case .wrongPassword:
                message = "Your password is incorrect. Please try again or use 'Forgot password' to reset your password."
            default:
                message = "An unknown error occurred. Please try again."
            }
            
            self.showError(message)
        }
    }
    
    func authWithFirebase(credential : AuthCredential, type : String,displayName : String) {
        
        ProgressHUDShow(text: "")
        
        FirebaseStoreManager.auth.signIn(with: credential) { (authResult, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if error != nil {
                self.handleError(error!)
               
            }
            else {
                let user = authResult!.user
                let ref =  FirebaseStoreManager.db.collection("Users").document(user.uid)
                ref.getDocument { (snapshot, error) in
                    if error != nil {
                        self.showError(error!.localizedDescription)
                    }
                    else {
                        if let doc = snapshot {
                            if doc.exists {
                                self.getUserData(uid: user.uid, showProgress: true)
                                
                            }
                            else {
                                
                                
                                var emailId = ""
                                let provider =  user.providerData
                                var name = ""
                                for firUserInfo in provider {
                                    if let email = firUserInfo.email {
                                        emailId = email
                                    }
                                }
                                
                                if type == "apple" {
                                    name = displayName
                                }
                                else {
                                    name = user.displayName!.capitalized
                                }
                                
                                let userData = UserModel()
                                userData.fullName = name
                                userData.email = emailId
                                userData.uid = user.uid
                                userData.registredAt = user.metadata.creationDate ?? Date()
                                userData.regiType = type
                                
                                self.addUserData(userData: userData)
                            }
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    
    public func logout(){
        UserModel.clearUserData()
        do {
            try FirebaseStoreManager.auth.signOut()
            self.beRootScreen(mIdentifier: Constants.StroyBoard.signInViewController)
        }
        catch {
            self.beRootScreen(mIdentifier: Constants.StroyBoard.signInViewController)
        }
    }
    
}






extension UIImageView {
    func makeRounded() {
        
        //self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        // self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
    }
    
    
    
    
}



extension UIView {
    public var safeAreaFrame: CGFloat {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.currentUIWindow() {
                return window.safeAreaInsets.bottom
            }
            
        }
        else  {
            let window = UIApplication.shared.keyWindow
            return window!.safeAreaInsets.bottom
        }
        return 34
    }
    
    func smoothShadow(){
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        //        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 1.8)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
    
    func installBlurEffect(isTop : Bool) {
        self.backgroundColor = UIColor.clear
        var blurFrame = self.bounds
        
        if isTop {
            var statusBarHeight : CGFloat = 0.0
            if #available(iOS 13.0, *) {
                if let window = UIApplication.shared.currentUIWindow() {
                    statusBarHeight = window.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                }
                
            } else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            
            blurFrame.size.height += statusBarHeight
            blurFrame.origin.y -= statusBarHeight
            
        }
        else {
            if let window = UIApplication.shared.currentUIWindow() {
                let bottomPadding = window.safeAreaInsets.bottom
                blurFrame.size.height += bottomPadding
            }
            
            
            //  blurFrame.origin.y += bottomPadding
        }
        let blur = UIBlurEffect(style:.light)
        let visualeffect = UIVisualEffectView(effect: blur)
        visualeffect.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.7)
        visualeffect.frame = blurFrame
        self.addSubview(visualeffect)
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        layer.mask = mask
        
    }
}


extension Date {
    public func setTime(hour: Int, min: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        
        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        
        return cal.date(from: components)
    }
}

extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}


public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }
        
        return window
        
    }
}

extension Date {
    var mMillisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
