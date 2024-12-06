//
//  BoostProfileViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 26/10/24.
//

import UIKit
import RevenueCat

class BoostProfileViewController: UIViewController {
    
    @IBOutlet weak var privacyPolicy: UILabel!
    @IBOutlet weak var termsOfUse: UILabel!
    @IBOutlet weak var fullView: UIView!
    @IBOutlet weak var payBtn: UIButton!
 
    @IBOutlet weak var restoreLbl: UILabel!
    @IBOutlet weak var mView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Setup
        mView.clipsToBounds = true
        mView.layer.cornerRadius = 20
        mView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        payBtn.layer.cornerRadius = 8
    
        restoreLbl.isUserInteractionEnabled = true
        restoreLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restoreBtnClicked)))
        
        // Add gesture to dismiss view on background tap
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewClicked)))
    }
    
    // MARK: - Boost Profile Logic
    func boostProfile() {
        let currentDate = Date()
        
        // Add 30 days to the current date
        if let futureDate = Calendar.current.date(byAdding: .day, value: 30, to: currentDate) {
            UserModel.data?.boostExpireDate = futureDate
            
            // Update Firebase with the new expiration date
            FirebaseStoreManager.db.collection("Users")
                .document(FirebaseStoreManager.auth.currentUser!.uid)
                .setData(["boostExpireDate": futureDate], merge: true)
        }
        
        // Show success alert
        let alert = UIAlertController(
            title: "Profile Boost Successful",
            message: "We have successfully boosted your profile for 30 days.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func viewClicked() {
        // Dismiss the view controller on background tap
        self.dismiss(animated: true)
    }
    
    // MARK: - Payment Logic
    @IBAction func payBtnClicked(_ sender: Any) {
        self.ProgressHUDShow(text: "")
       
        Purchases.shared.getProducts(["com.softment.boost"]) { products in
            self.ProgressHUDHide()
            guard let product = products.first else {
                self.ProgressHUDHide()
                self.showError("Product not found.")
                return
            }
            
            // Start purchase
            Purchases.shared.purchase(product: product) { transaction, customerInfo, error, userCancelled in
               
                if let error = error {
                  
                    self.showError("Purchase failed: \(error.localizedDescription)")
                    return
                }
                
                if userCancelled {
                    print("User canceled the purchase.")
                    return
                }
                
                // Check entitlement for 'Boost'
                if customerInfo?.entitlements["Boost"]?.isActive == true {
                    self.boostProfile()
                } else {
                    self.showError("Purchase not successful.")
                }
            }
        }
    }
    
    // MARK: - Restore Purchases Logic
    @objc func restoreBtnClicked() {
        ProgressHUDShow(text: "Restoring Purchases...")
        
        Purchases.shared.restorePurchases { customerInfo, error in
            self.ProgressHUDHide()
            
            if error != nil {
                self.showError("Restore failed: No customer info available.")
                return
            }
            
            guard let customerInfo = customerInfo else {
                self.showError("Restore failed: No customer info available.")
                return
            }
            
            // Check if the 'Boost' entitlement is active
            if customerInfo.entitlements["Boost"]?.isActive == true {
                self.boostProfile() // Reapply the boost
                self.showSuccess("Purchases restored successfully.")
            } else {
                self.showError("No active purchases found to restore.")
            }
        }
    }
    
    
    
    private func showSuccess(_ message: String) {
        let alert = UIAlertController(
            title: "Success",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}
