//
//  ShowChatViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 18/10/24.
//

import Firebase
import IQKeyboardManagerSwift
import UIKit
import SDWebImage

class ShowChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet var userImageAndName: UIStackView!
    @IBOutlet var videoCallBtn: UIView!
    @IBOutlet var bottomConst: NSLayoutConstraint!
    @IBOutlet var backView: UIView!
   
    @IBOutlet weak var mProfile: UIImageView!
    
    @IBOutlet var mName: UILabel!
    @IBOutlet var myTextField: UITextView!
    @IBOutlet var tableView: UITableView!
    var messages = [AllMessageModel]()
    var lastMessage: LastMessageModel?
    var callUUID = ""
    var mInfo = [String : String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        guard let lastMessage = lastMessage else {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }

        guard UserModel.data != nil else {
            DispatchQueue.main.async {
                self.logout()
            }
            return
        }

        self.mProfile.makeRounded()

        self.mProfile.sd_setImage(with: URL(string: lastMessage.senderImage ?? ""), placeholderImage: UIImage(named: "profile-placeholder"))
        self.mName.text = lastMessage.senderName ?? "Error"

       

        self.backView.layer.cornerRadius = 8
        self.backView.dropShadow()
        self.backView.isUserInteractionEnabled = true
        self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backBtnPressed)))


        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.showsVerticalScrollIndicator = false
        
        self.myTextField.sizeToFit()
        self.myTextField.isScrollEnabled = false
        self.myTextField.delegate = self
        self.myTextField.layer.cornerRadius = 8

        self.myTextField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.userImageAndName.isUserInteractionEnabled = true
        self.userImageAndName.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.userProfileClikced)
        ))

        

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        
      
            mInfo["fullName"] = UserModel.data!.fullName
            mInfo["profilePic"] = UserModel.data!.profilePic
            mInfo["deviceToken"] = UserModel.data!.notificationToken
            mInfo["uid"] = FirebaseStoreManager.auth.currentUser!.uid
          
            
          
      
        self.loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.moveToBottom()
        }
    }

    @objc func userProfileClikced() {
        self.viewUserProfile()
    }

    

   

    @objc func moreBtnClicked() {
        var alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert = UIAlertController(
                title: "Do you want to report & block this user?",
                message: nil,
                preferredStyle: .alert
            )
        }

        alert.addAction(UIAlertAction(title: "Block this user", style: .default, handler: { _ in
            self.showSnack(messages: "User has been blocked.")
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    func sendMessage(sMessage: String) {
        let messageID = FirebaseStoreManager.db.collection("Chats").document().documentID

        FirebaseStoreManager.db.collection("Chats").document(self.mInfo["uid"]!)
            .collection(self.lastMessage!.senderUid!).document(messageID)
            .setData([
                "message": sMessage,
                "senderUid": self.mInfo["uid"]!,
                "messageId": messageID,
              
                "date": FieldValue.serverTimestamp()
                
                
                
            ]) { error in

                if let error = error {
                    self.showError(error.localizedDescription)
                } else {
                    FirebaseStoreManager.db.collection("Chats").document(self.lastMessage!.senderUid!)
                        .collection(self.mInfo["uid"]!).document(messageID)
                        .setData([
                            "message": sMessage,
                            "senderUid": self.mInfo["uid"]!,
                            "messageId": messageID,
                           
                            "date": FieldValue.serverTimestamp()
                        ])

                    FirebaseStoreManager.db.collection("Chats").document(self.mInfo["uid"]!)
                        .collection("LastMessage").document(self.lastMessage!.senderUid!)
                        .setData([
                            "message": sMessage,
                            "senderUid": self.lastMessage!.senderUid!,
                            "isRead": true,
                       
                            "senderImage": self.lastMessage!.senderImage ?? "",
                            "senderName": self.lastMessage!.senderName!,
                            "date": FieldValue.serverTimestamp(),
                            "senderToken": self.lastMessage!.senderToken ?? ""
                        ])

                    FirebaseStoreManager.db.collection("Chats").document(self.lastMessage!.senderUid!)
                        .collection("LastMessage").document(self.mInfo["uid"]!)
                        .setData([
                            "message": sMessage,
                            "senderUid": self.mInfo["uid"]!,
                            "isRead": false,
                            "senderName": self.mInfo["fullName"] ?? "Error",
                            "date": FieldValue.serverTimestamp(),
                            "senderImage": self.mInfo["profilePic"] ?? "",
                           
                            "senderToken": self.mInfo["deviceToken"] ?? ""
                        ])

                    PushNotificationSender().sendPushNotification(
                        title:self.mInfo["fullName"] ?? "Error",
                        body: sMessage,
                        topic: self.lastMessage!.senderToken ?? ""
                    )
                }
            }
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func moveToBottom() {
        if !self.messages.isEmpty {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)

            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }

    @objc func keyboardWillShow(notify: NSNotification) {
        if let keyboardSize = (notify.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.bottomConst.constant = keyboardSize.height - view.safeAreaFrame
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notify _: NSNotification) {
        self.bottomConst.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }

        self.moveToBottom()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func backBtnPressed() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func sendMessageClick(_: Any) {
        let mMessage = self.myTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if mMessage != "" {
            self.myTextField.text = ""
            self.sendMessage(sMessage: mMessage)
        }
    }

    @objc func cellImageClicked() {
        self.viewUserProfile()
    }

    func viewUserProfile() {
        ProgressHUDShow(text: "")
        
            getUserDataByID(uid: self.lastMessage!.senderUid ?? "123") { userModel, _ in
                self.ProgressHUDHide()
                if let userModel = userModel {
                    self.performSegue(withIdentifier: "chatViewUserProfileSeg", sender: userModel)
                }
            }
        
    }

    func loadData() {
        ProgressHUDShow(text: "Loading...")
        guard let friendUid = lastMessage!.senderUid else {
            dismiss(animated: true, completion: nil)
            return
        }
        FirebaseStoreManager.db.collection("Chats").document(self.mInfo["uid"]!)
            .collection(friendUid).order(by: "date").addSnapshotListener { snapshot, error in
                self.ProgressHUDHide()
                if error == nil {
                    self.messages.removeAll()
                    if let snapshot = snapshot {
                        for snap in snapshot.documents {
                            if let message = try? snap.data(as: AllMessageModel.self) {
                                self.messages.append(message)
                            }
                        }
                    }
                    self.tableView.reloadData()
                    self.moveToBottom()
                } else {
                    self.showError(error!.localizedDescription)
                }
            }
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        self.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messagecell", for: indexPath) as? MessagesCell {
            let message = self.messages[indexPath.row]
            cell.config(
                message: message,
                senderName: self.lastMessage!.senderName ?? "123",
                uid: self.mInfo["uid"]!,
                image: self.lastMessage!.senderImage ?? ""
            )

            
            return cell
        }

        return MessagesCell()
    }

    override func viewWillAppear(_: Bool) {
        IQKeyboardManager.shared.enable = false
    }

    override func viewWillDisappear(_: Bool) {
        IQKeyboardManager.shared.enable = true
    }
}
