//
//  TabbarViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 04/01/24.
//
import UIKit
import FirebaseMessaging

class TabbarViewController : UITabBarController, UITabBarControllerDelegate {
  
    var tabBarItems = UITabBarItem()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate  = self
        
        
        let selectedImage1 = UIImage(named: "houseblue")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage1 = UIImage(named: "housegrey")?.withRenderingMode(.alwaysOriginal)
        tabBarItems = self.tabBar.items![0]
        tabBarItems.image = deSelectedImage1
        tabBarItems.selectedImage = selectedImage1
        
        let selectedImage2 = UIImage(named: "messageblue")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage2 = UIImage(named: "messagegrey")?.withRenderingMode(.alwaysOriginal)
        tabBarItems = self.tabBar.items![1]
        tabBarItems.image = deSelectedImage2
        tabBarItems.selectedImage = selectedImage2
        
        let selectedImage3 = UIImage(named: "userblue")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage3 = UIImage(named: "usergrey")?.withRenderingMode(.alwaysOriginal)
        tabBarItems = self.tabBar.items![2]
        tabBarItems.image = deSelectedImage3
        tabBarItems.selectedImage = selectedImage3
        
        updateFCMToken()
   
        
        
        
        
    }
    // Updates the FCM token for notifications
    func updateFCMToken() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM token: \(error)")
            } else if let token = token {
                self.updateUserNotificationToken(token)
            }
        }
    }

    
    // Helper function to update user and business notification tokens
    private func updateUserNotificationToken(_ token: String) {
        if let currentUser = FirebaseStoreManager.auth.currentUser {
            UserModel.data?.notificationToken = token
            FirebaseStoreManager.db.collection("Users").document(currentUser.uid)
                .setData(["notificationToken": token], merge: true)

           
        } else {
            self.logout()
        }
    }
    
}


