//
//  ProfileInfo1ViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 04/01/24.
//

import UIKit
import CropViewController
import Cloudinary
import SDWebImage
import Photos

class ProfileInfo1ViewController : UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var number1: UIView!
    @IBOutlet weak var number2: UIView!
    @IBOutlet weak var number3: UIView!
    @IBOutlet weak var number4: UIView!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
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
    
    
    @IBOutlet weak var uploadAndContinueBtn: UIButton!
    var isProfileSelected = false
    var imageIndex = 0
    let cameraPicker = UIImagePickerController()
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
        profilePic.layer.cornerRadius = 8
        uploadBtn.layer.cornerRadius = 8
        
        uploadAndContinueBtn.layer.cornerRadius = 8
        
      
            let myGest1 = MyGesture(target: self, action: #selector(placeholderClicked))
            myGest1.index = 1
            placeholder1.isUserInteractionEnabled = true
            placeholder1.addGestureRecognizer(myGest1)
        
        let myGest2 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest2.index = 2
        placeholder2.isUserInteractionEnabled = true
        placeholder2.addGestureRecognizer(myGest2)
        
        let myGest3 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest3.index = 3
        placeholder3.isUserInteractionEnabled = true
        placeholder3.addGestureRecognizer(myGest3)
        
        let myGest4 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest4.index = 4
        placeholder4.isUserInteractionEnabled = true
        placeholder4.addGestureRecognizer(myGest4)
        
        let myGest5 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest5.index = 5
        placeholder5.isUserInteractionEnabled = true
        placeholder5.addGestureRecognizer(myGest5)
        
        let myGest6 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest6.index = 6
        placeholder6.isUserInteractionEnabled = true
        placeholder6.addGestureRecognizer(myGest6)
        
        let myGest7 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest7.index = 7
        placeholder7.isUserInteractionEnabled = true
        placeholder7.addGestureRecognizer(myGest7)
        
        let myGest8 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest8.index = 8
        placeholder8.isUserInteractionEnabled = true
        placeholder8.addGestureRecognizer(myGest8)
        
        let myGest9 = MyGesture(target: self, action: #selector(placeholderClicked))
        myGest9.index = 9
        placeholder9.isUserInteractionEnabled = true
        placeholder9.addGestureRecognizer(myGest9)
        
        backView.isUserInteractionEnabled = true
        backView.dropShadow()
        backView.layer.cornerRadius = 8
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backViewClicked)))
        
        
        getMedia(uid: user.uid!) { medias, error in
            if let medias = medias {
                for media in medias {
                    
                
                    switch Int(media.id!) {
                   
                    case 1:
                        if let url = media.url, !url.isEmpty {
                            self.playIcon1.isHidden = false
                            
                        }
                        self.placeholder1.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder1.layer.cornerRadius = 8
                        
                        break
                    case 2:
                        if let url = media.url, !url.isEmpty {
                            self.playIcon2.isHidden = false
                            
                        }
                        self.placeholder2.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder2.layer.cornerRadius = 8
                        break
                    case 3:
                     
                        if let url = media.url, !url.isEmpty {
                            self.playIcon3.isHidden = false
                            
                        }
                        self.placeholder3.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder3.layer.cornerRadius = 8
                        break
                    case 4:
                        if let url = media.url, !url.isEmpty {
                            self.playIcon4.isHidden = false
                            
                        }
                        self.placeholder4.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder4.layer.cornerRadius = 8
                        break
                    case 5:
                   
                        if let url = media.url, !url.isEmpty {
                            self.playIcon5.isHidden = false
                            
                        }
                        self.placeholder5.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder5.layer.cornerRadius = 8
                        break
                    case 6:
                   
                        if let url = media.url, !url.isEmpty {
                            self.playIcon6.isHidden = false
                            
                        }
                        self.placeholder6.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder6.layer.cornerRadius = 8
                        break
                    case 7:
                     
                        if let url = media.url, !url.isEmpty {
                            self.playIcon7.isHidden = false
                            
                        }
                        self.placeholder7.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder7.layer.cornerRadius = 8
                        break
                    case 8:
                    
                        if let url = media.url, !url.isEmpty {
                            self.playIcon8.isHidden = false
                            
                        }
                        self.placeholder8.sd_setImage(with: URL(string: media.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                        self.placeholder8.layer.cornerRadius = 8
                        break
                    case 9:
                     
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
    
    @objc func backViewClicked(){
        self.logout()
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
    
    @objc func placeholderClicked(value : MyGesture){
       
        imageIndex = value.index
        
        var imageView : UIImageView!
        var playIcon : UIImageView!
        
        switch imageIndex {
        case 1 : 
            imageView = placeholder1
            playIcon = self.playIcon1
        case 2 : imageView = placeholder2
            playIcon = self.playIcon2
        case 3 : imageView = placeholder3
            playIcon = self.playIcon3
        case 4 : imageView = placeholder4
            playIcon = self.playIcon4
        case 5 : imageView = placeholder5
            playIcon = self.playIcon5
        case 6 : imageView = placeholder6
            playIcon = self.playIcon6
        case 7 : imageView = placeholder7
            playIcon = self.playIcon7
        case 8 : imageView = placeholder8
            playIcon = self.playIcon8
        case 9 : imageView = placeholder9
            playIcon = self.playIcon9
            
        default:
            imageView = placeholder1
        }
        
        
        
        
        // Assume `currentImage` is your existing UIImage instance and `imageView` is an UIImageView
        if let currentImage = imageView.image,
           let namedImage = UIImage(named: "Group111"),
           let currentImageData = currentImage.pngData(),
           let namedImageData = namedImage.pngData(),
           currentImageData == namedImageData {
            self.showImagePickerAlert(onlyImage: false)
        }
        else {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Replace", style: .default, handler: { action in
                self.showImagePickerAlert(onlyImage: false)
            }))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { action in
                
                self.deleteMedia(id: String(self.imageIndex))
                
                let namedImage = UIImage(named: "Group111")
                imageView.image = namedImage
                playIcon.isHidden = true
                imageView.layer.cornerRadius = 0
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }

    }
    
    @objc func deleteMedia(id : String){
        self.deleteMediaOfCloud(folderPath: "Gallery/\(FirebaseStoreManager.auth.currentUser!.uid)/\(FirebaseStoreManager.auth.currentUser!.uid)\(id)")
        FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).collection("Media").document(id).delete()
    }
    
    @IBAction func uploadAndContinueClicked(_ sender: Any) {
        if isProfileSelected {
            self.uploadMediaOnCloud(media: .image(self.profilePic.image!, folderName: "ProfilePictures"), id: FirebaseStoreManager.auth.currentUser!.uid) { downloadURL, error in
                if let error = error {
                    self.showError(error)
                }
                else {
                    self.ProgressHUDShow(text: "")
                    UserModel.data!.profilePic = downloadURL
                    self.updateUserData(userModel: UserModel.data!) { error in
                        self.ProgressHUDHide()
                        if let error = error {
                            self.showError(error.localizedDescription)
                        }
                        else {
                            self.performSegue(withIdentifier: "profileInfo2Seg", sender: nil)
                        }
                    }
                }
            }
        }
        else {
            self.showSnack(messages: "Upload Profile Picture")
        }
    }
    
    @IBAction func uploadBtnClicked(_ sender: Any) {
        imageIndex = 0
        showImagePickerAlert(onlyImage: true)
    }
    
    func chooseImageAndVideoFromPhotoLibrary(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary

        // Use UTType.image and UTType.movie for media types
        imagePicker.mediaTypes = [UTType.image.identifier, UTType.movie.identifier]

        self.present(imagePicker, animated: true)

    }
    
    func chooseImageFromPhotoLibrary(){
        let image = UIImagePickerController()
        image.delegate = self
        image.title = "Profile Picture"
        image.sourceType = .photoLibrary
        
        self.present(image,animated: true)
    }
    
    func setupCameraPicker() {
       
              cameraPicker.delegate = self
              cameraPicker.sourceType = .camera
             cameraPicker.videoQuality = .typeMedium
              cameraPicker.mediaTypes = [UTType.image.identifier, UTType.movie.identifier]
              cameraPicker.showsCameraControls = true // Hide default controls

            
        
        self.present(cameraPicker, animated: true)
       
      }

     


      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          // Handle cancellation
          picker.dismiss(animated: true, completion: nil)
      }
    
    func showImagePickerAlert(onlyImage : Bool){
        var title = ""
        if onlyImage {
            title = "Upload Profile Picture"
        }
        else {
            title = "Upload Picture"
        }
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Using Camera", style: .default) { (action) in
            self.setupCameraPicker()
           
            
        }
        
        let action2 = UIAlertAction(title: "From Photo Library", style: .default) { (action) in
            if onlyImage {
                self.chooseImageFromPhotoLibrary()
            }
            else {
                self.chooseImageAndVideoFromPhotoLibrary()
            }

        }
        
        let action3 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        
        self.present(alert,animated: true,completion: nil)
    }
    
    

        
    
}

extension ProfileInfo1ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate,CropViewControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.originalImage] as? UIImage {
            
            self.dismiss(animated: true) {
                
                let cropViewController = CropViewController(image: editedImage)
                cropViewController.title = picker.title
                cropViewController.delegate = self
                cropViewController.customAspectRatio = CGSize(width: 1  , height: 1)
                cropViewController.aspectRatioLockEnabled = true
                cropViewController.aspectRatioPickerButtonHidden = true
                self.present(cropViewController, animated: true, completion: nil)
            }
 
        }
        else if let videoPath = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaURL.rawValue)] as? URL {
            if FileManager.default.fileExists(atPath: videoPath.path) {
                self.compressVideo(sourceURL: videoPath) { url, error in
                    if let url = url {
                        DispatchQueue.main.async {
                            let id  = FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).collection("Media").document().documentID
                            self.uploadMediaOnCloud(media: .video(url, folderName: "Gallery/\(FirebaseStoreManager.auth.currentUser!.uid)"), id: String(self.imageIndex)) { downloadUrl, error in
                                DispatchQueue.main.async {
                                    if let error = error {
                                        self.showError(error.localizedLowercase)
                                    }
                                    else {
                                   
                                        let mediaModel = MediaModel()
                                        mediaModel.id = id
                                        mediaModel.date = Date()
                                        mediaModel.url = downloadUrl
                                        mediaModel.index = self.imageIndex
                                        mediaModel.thumbnail = downloadUrl!.replacingOccurrences(of: ".mp4", with: ".jpg")
                                        
                                        switch self.imageIndex {
                                    
                                        case 1:
                                            self.playIcon1.isHidden = false
                                            self.placeholder1.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder1.layer.cornerRadius = 8
                                            break
                                        case 2:
                                            self.playIcon2.isHidden = false
                                            self.placeholder2.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder2.layer.cornerRadius = 8
                                            break
                                        case 3:
                                            self.playIcon3.isHidden = false
                                            self.placeholder3.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder3.layer.cornerRadius = 8
                                            break
                                        case 4:
                                            self.playIcon4.isHidden = false
                                            self.placeholder4.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder4.layer.cornerRadius = 8
                                            break
                                        case 5:
                                            self.playIcon5.isHidden = false
                                            self.placeholder5.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder5.layer.cornerRadius = 8
                                            break
                                        case 6:
                                            self.playIcon6.isHidden = false
                                            self.placeholder6.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder6.layer.cornerRadius = 8
                                            break
                                        case 7:
                                            self.playIcon7.isHidden = false
                                            self.placeholder7.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder7.layer.cornerRadius = 8
                                            break
                                        case 8:
                                            self.playIcon8.isHidden = false
                                            self.placeholder8.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder8.layer.cornerRadius = 8
                                            break
                                        case 9:
                                            self.playIcon9.isHidden = false
                                            self.placeholder9.sd_setImage(with: URL(string: mediaModel.thumbnail!), placeholderImage: UIImage(named: "placeholder"))
                                            self.placeholder9.layer.cornerRadius = 8
                                            break
                                            
                                        default:
                                            print("OH NO")
                                        }
                                        
                                        try? FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).collection("Media").document(String(self.imageIndex)).setData(from: mediaModel)
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            
         
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        let id  = FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).collection("Media").document().documentID
        
        switch imageIndex {
        case 0:
            isProfileSelected = true
            profilePic.image = image
            break
        case 1:
            self.placeholder1.image = image
            self.placeholder1.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 1,image: image)
            
            break
        case 2:
            self.placeholder2.image = image
            self.placeholder2.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 2,image: image)
            break
        case 3:
         
            self.placeholder3.image = image
            self.placeholder3.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 3,image: image)
            break
        case 4:
            self.placeholder4.image = image
            self.placeholder4.layer.cornerRadius = 8
            self.uploadImage(id: id, index:4,image: image)
            break
        case 5:
       
            self.placeholder5.image = image
            self.placeholder5.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 5,image: image)
            break
        case 6:
       
            self.placeholder6.image = image
            self.placeholder6.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 6,image: image)
            break
        case 7:
         
            self.placeholder7.image = image
            self.placeholder7.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 7,image: image)
            break
        case 8:
        
            self.placeholder8.image = image
            self.placeholder8.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 8,image: image)
            break
        case 9:
         
            self.placeholder9.image = image
            self.placeholder9.layer.cornerRadius = 8
            self.uploadImage(id: id, index: 9,image: image)
            break
            
        default:
            print("OH NO")
        }
      
        
        
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func uploadImage(id : String, index : Int, image : UIImage){
        self.uploadMediaOnCloud(media: .image(image, folderName: "Gallery/\(FirebaseStoreManager.auth.currentUser!.uid)"), id: String(index)) { downloadURL, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showError(error)
                }
                else {
                    let mediaModel = MediaModel()
                    mediaModel.id = id
                    mediaModel.date = Date()
                    mediaModel.index = index
                    mediaModel.thumbnail = downloadURL
                    try? FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).collection("Media").document(String(index)).setData(from: mediaModel)
                
                }
            }
        }
    }
   
    
    
}
