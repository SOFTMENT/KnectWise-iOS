//
//  TabbarViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 04/01/24.
//
import UIKit

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
        
        
   
        
        
        
        
    }
    
}


