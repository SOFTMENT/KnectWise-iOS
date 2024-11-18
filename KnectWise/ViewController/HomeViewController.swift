//
//  HomeViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 05/01/24.
//

import UIKit
import CoreLocation
import Firebase
import GeoFire



class HomeViewController : UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var daysLeftBtn: UIButton!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var boostMeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noUsersAvailable: UILabel!
    var userModels : [UserModel] = []
    var useUserModels : [UserModel] = []
    
    
    
    @IBOutlet weak var searchTF: UITextField!
    private let locationManager = CLLocationManager()
    private var timer: Timer?

    private let RADIUS_IN_METERS : Double = 1000.0

    

    override func viewDidLoad() {
        
        guard let userModel = UserModel.data else {
            
            DispatchQueue.main.async {
                self.beRootScreen(mIdentifier: Constants.StroyBoard.signInViewController)
            }
            return
            
        }
        
        locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.requestAlwaysAuthorization() // Ensure background updates are allowed
               locationManager.startUpdatingLocation()
        
        boostMeBtn.layer.cornerRadius = 8
        daysLeftBtn.layer.cornerRadius = 8

        profilePic.layer.cornerRadius = profilePic.bounds.height / 2
        if let path = userModel.profilePic, !path.isEmpty {
            profilePic.sd_setImage(with: URL(string: path), placeholderImage: UIImage(named: "profile-placeholder"))
        }

        fullName.text = "Hi, \(userModel.fullName ?? "")"
        filterView.layer.cornerRadius = 8
        
        filterView.isUserInteractionEnabled = true
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterBtnClicked)))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewClicked)))
        
       
        
        if userModel.email == "vijay@softmet.com" {
            
            getAllUsers()
        }
        else {
         
            self.fetchAndUploadLocation()
            startLocationUpdates()
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let daysLeft =  self.boostDaysLeft(boostExpirationDate: UserModel.data!.boostExpireDate ?? Date())
        if daysLeft > 0 {
            self.boostMeBtn.isHidden = true
            self.daysLeftBtn.isHidden = false
            self.daysLeftBtn.setTitle("\(daysLeft + 1) days left", for: .normal)
        }
        else {
            self.daysLeftBtn.isHidden = true
            self.boostMeBtn.isHidden = false
        }
    }
    
    @objc func viewClicked() {
        self.view.endEditing(true)
    }
    

    private func startLocationUpdates() {
           // Schedule a timer to fetch location every 60 seconds
           timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fetchAndUploadLocation), userInfo: nil, repeats: true)
       }
       
       @objc private func fetchAndUploadLocation() {
           if let currentLocation = locationManager.location {
               let latitude = currentLocation.coordinate.latitude
               let longitude = currentLocation.coordinate.longitude
               
               // Create geohash for the current location
               let geohash = GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
               
               // Upload to Firebase
               uploadLocationToFirebase(latitude: latitude, longitude: longitude, geohash: geohash)
           }
       }
       
    private func uploadLocationToFirebase(latitude: Double, longitude: Double, geohash: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return } // Ensure user is authenticated
        
        UserModel.data?.latitude = latitude
        UserModel.data?.longtitude = longitude
        UserModel.data?.geoHash = geohash
        FirebaseStoreManager.db.collection("Users").document(userId).setData(["latitude" : latitude, "longitude" : longitude, "geoHash" : geohash],merge: true)
        
        queryUsersNearby(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radiusInMeters: RADIUS_IN_METERS)
    }
    
    func getAllUsers() {
        
        userModels.removeAll()
        useUserModels.removeAll()
        
        
        let query = FirebaseStoreManager.db.collection("Users")
           
             query.getDocuments(completion: { snapshot, error in
                 guard let documents = snapshot?.documents else {
    
                     return
                 }
                 
                 for document in documents {
                  
                     if let userModel = try? document.data(as: UserModel.self) {
                           
                         if userModel.uid != Auth.auth().currentUser?.uid {
                             self.userModels.append(userModel)
                             self.useUserModels.append(userModel)
                         }
                                                 
                             }
                         }
                  
                 self.tableView.reloadData()
             })

     }
  
    func queryUsersNearby(center: CLLocationCoordinate2D, radiusInMeters: Double) {
        
      
        userModels.removeAll()
        useUserModels.removeAll()
        
         // Convert the center location to a GeoHash
         let bounds = GFUtils.queryBounds(forLocation: center, withRadius: radiusInMeters)
         
         let dispatchGroup = DispatchGroup()
         
         
         for bound in bounds {
             let query = FirebaseStoreManager.db.collection("Users")
                 .order(by: "geohash")
                 .start(at: [bound.startValue])
                 .end(at: [bound.endValue])
             
             dispatchGroup.enter()
             query.getDocuments(completion: { snapshot, error in
                 guard let documents = snapshot?.documents else {
                     dispatchGroup.leave()
                     return
                 }
                 
                 for document in documents {
                     if let userModel = try? document.data(as: UserModel.self) {
                            let latitude = userModel.latitude ?? 0.0
                            let longitude = userModel.longtitude ?? 0.0
                             let location = CLLocation(latitude: latitude, longitude: longitude)
                             let distance = location.distance(from: CLLocation(latitude: center.latitude, longitude: center.longitude))
                             
                             if distance <= radiusInMeters {
                                 
                                 if let boostExpirationDate = userModel.boostExpireDate {
                                     let daysLeft = self.boostDaysLeft(boostExpirationDate: boostExpirationDate)
                                     userModel.isBoosted = daysLeft > 0
                                }
                                 
                                 if userModel.uid != Auth.auth().currentUser?.uid {
                                     self.userModels.append(userModel)
                                     self.useUserModels.append(userModel)
                                 }
                                                         
                             }
                         }
                 }
                 dispatchGroup.leave()
             })
         }

         dispatchGroup.notify(queue: .main) {
             // Sort userModels: boosted users appear first
             self.userModels.sort { $0.isBoosted ?? false && !($1.isBoosted ?? false) }
             self.useUserModels.sort { $0.isBoosted ?? false && !($1.isBoosted ?? false) }
             self.tableView.reloadData()
         }
     }
  
    
    @IBAction func boostMeClicked(_ sender: Any) {
        performSegue(withIdentifier: "boostProfileSeg", sender: nil)
    }
    

    
    @objc func filterBtnClicked(){
        let searchText = searchTF.text ?? ""
        useUserModels.removeAll()
        if searchText == "" {
            
          
            useUserModels = userModels
            tableView.reloadData()
            return
            
        }
           
        let filteredUsers = searchUsers(searchText: searchText)
        useUserModels.append(contentsOf: filteredUsers)
        tableView.reloadData()
    }
    
    @objc func cellClicked(gest : MyGesture) {
        performSegue(withIdentifier: "showUserProfileSeg", sender: useUserModels[gest.index])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserProfileSeg" {
            if let VC = segue.destination as? ShowUserProfileViewController {
                if let user = sender as? UserModel {
                    VC.userModel = user
                }
            }
        }
    }
    
    // Search function to filter based on the search text
    func searchUsers(searchText: String) -> [UserModel] {
        let filteredUsers = userModels.filter { user in
            let searchTextLowercased = searchText.lowercased()
            
            // Check each field for the search text
            let fullNameMatches = user.fullName?.lowercased().contains(searchTextLowercased) ?? false
            let emailMatches = user.email?.lowercased().contains(searchTextLowercased) ?? false
            let genderMatches = user.gender?.lowercased().contains(searchTextLowercased) ?? false
            let eyeColourMatches = user.eyeColour?.lowercased().contains(searchTextLowercased) ?? false
            let heightMatches = user.height?.lowercased().contains(searchTextLowercased) ?? false
            let ageMatches = user.age?.lowercased().contains(searchTextLowercased) ?? false
            let ethnicityMatches = user.ethnicity?.lowercased().contains(searchTextLowercased) ?? false
            let sexualOrientationMatches = user.sexualOrientation?.lowercased().contains(searchTextLowercased) ?? false
            let homeTownMatches = user.homeTown?.lowercased().contains(searchTextLowercased) ?? false
            let jobTitleMatches = user.jobTitle?.lowercased().contains(searchTextLowercased) ?? false
            let childrenMatches = user.children?.lowercased().contains(searchTextLowercased) ?? false
            let familyPlanningMatches = user.familyPlanning?.lowercased().contains(searchTextLowercased) ?? false
            let educationLevelMatches = user.educationLevel?.lowercased().contains(searchTextLowercased) ?? false
            let nameOfSchoolAttendedMatches = user.nameOfSchoolAttended?.lowercased().contains(searchTextLowercased) ?? false
            let religionMatches = user.religion?.lowercased().contains(searchTextLowercased) ?? false
            let pronounsMatches = user.pronouns?.lowercased().contains(searchTextLowercased) ?? false
            let politicsMatches = user.politics?.lowercased().contains(searchTextLowercased) ?? false
            let interestsMatches = user.interests?.lowercased().contains(searchTextLowercased) ?? false
            let exerciseMatches = user.exercise?.lowercased().contains(searchTextLowercased) ?? false
            let starSignMatches = user.starSign?.lowercased().contains(searchTextLowercased) ?? false
            let languageMatches = user.language?.lowercased().contains(searchTextLowercased) ?? false
            let descriptionMatches = user.mDescription?.lowercased().contains(searchTextLowercased) ?? false
            
            // Return true if any of the fields match the search text
            return fullNameMatches ||
                   emailMatches ||
                   genderMatches ||
                   eyeColourMatches ||
                   heightMatches ||
                   ageMatches ||
                   ethnicityMatches ||
                   sexualOrientationMatches ||
                   homeTownMatches ||
                   jobTitleMatches ||
                   childrenMatches ||
                   familyPlanningMatches ||
                   educationLevelMatches ||
                   nameOfSchoolAttendedMatches ||
                   religionMatches ||
                   pronounsMatches ||
                   politicsMatches ||
                   interestsMatches ||
                   exerciseMatches ||
                   starSignMatches ||
                   languageMatches ||
                   descriptionMatches
        }
        
        return filteredUsers
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noUsersAvailable.isHidden = userModels.count > 0 ? true : false
        return useUserModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTableViewCell{
            
            let userModel = useUserModels[indexPath.row]
            cell.mView.layer.cornerRadius = 8
            cell.mName.text = userModel.fullName ?? ""
            if let jobTitle = userModel.jobTitle, !jobTitle.isEmpty {
                cell.mSubtitle.text = jobTitle
                cell.mSubtitle.isHidden = false
            }
            else {
                cell.mSubtitle.isHidden = true
            }
          
            cell.mImage.layer.cornerRadius = 8
            
            if let path = userModel.profilePic, !path.isEmpty {
                cell.mImage.sd_setImage(with: URL(string: path), placeholderImage: UIImage(named: "profile-placeholder"))
            }
            
            let myGest = MyGesture(target: self, action: #selector(cellClicked))
            myGest.index = indexPath.row
            cell.mView.isUserInteractionEnabled = true
            cell.mView.addGestureRecognizer(myGest)
            
            return cell
        }
        return UserTableViewCell()
                
        }
}

    
    

