//
//  BoostProfileViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 26/10/24.
//

import UIKit
import RevenueCat

class BoostProfileViewController : UIViewController {
    
    @IBOutlet weak var privacyPolicy: UILabel!
    @IBOutlet weak var termsOfUse: UILabel!
    
    @IBOutlet weak var fullView: UIView!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var mView: UIView!
    override func viewDidLoad() {
        
        mView.clipsToBounds = true
        mView.layer.cornerRadius = 20
        mView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        payBtn.layer.cornerRadius = 8
      
    }
    
    
    
    func boostProfile() {
        
        let currentDate = Date()
    
        // Add 30 days to the current date
        if let futureDate = Calendar.current.date(byAdding: .day, value: 30, to: currentDate) {
            UserModel.data?.boostExpireDate = futureDate
            FirebaseStoreManager.db.collection("Users").document(FirebaseStoreManager.auth.currentUser!.uid).setData(["boostExpireDate" : futureDate],merge: true)
        }
        
        let alert = UIAlertController(title: "Profile Boost Successful", message: "We have successfully boosted your profile for 30 days.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewClicked)))
    }
    
    @objc func viewClicked(){
        self.dismiss(animated: true)
    }
    
    @IBAction func payBtnClicked(_ sender: Any) {
        
        Purchases.shared.getProducts(["in.softmet.boost"]) { (products) in
          
                   guard let product = products.first else {
                       print("Product not found.")
                       return
                   }
            // Purchase the product
            Purchases.shared.purchase(product: product) { transaction, customerInfo, error, userCancelled in
                if let error = error {
                    self.showError("Purchase failed: \(error.localizedDescription)")
          
                    return
                }
                
                if userCancelled {
                    print("User canceled the purchase.")
                    return
                }
                
              
                // Check if the user is entitled to 'Boost'
                if customerInfo?.entitlements["Boost"]?.isActive == true {
                  
                    self.boostProfile()
                } else {
                    self.showError("Purchase not successful.")
                 
                }
            }
        }
    }
}
