//
//  ChatViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 05/01/24.
//
import UIKit



// MARK: - ChatViewController

class ChatViewController: UIViewController {
   
    @IBOutlet var no_chats_available: UILabel!
    @IBOutlet var tableView: UITableView!
    var lastMessages = [LastMessageModel]()
   
  
   

    override func viewDidLoad() {
        super.viewDidLoad()

        guard  FirebaseStoreManager.auth.currentUser != nil,  let _ = UserModel.data else {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }

        setupViews()
        getAllLastMessages()
    }
    
    func deleteLastMessage(uid: String, otherUid: String) {
        FirebaseStoreManager.db.collection("Chats").document(uid).collection("LastMessage").document(otherUid).delete()
        FirebaseStoreManager.db.collection("Chats").document(otherUid).collection("LastMessage").document(uid).delete()
    }

    private func setupViews() {
       
        tableView.delegate = self
        tableView.dataSource = self

        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardHide)))

       

        
    }


    

    @objc private func lastMessageBtnClicked(value: MyGesture) {
        let lastmessage = self.lastMessages[value.index]
        performSegue(withIdentifier: "chatHome_ChatScreenSeg", sender: lastmessage)
    }

    @objc private func keyboardHide() {
        view.endEditing(true)
    }

    private func getAllLastMessages() {
        guard let  uid = FirebaseStoreManager.auth.currentUser?.uid else { return }
       

        FirebaseStoreManager.db.collection("Chats").document(uid)
            .collection("LastMessage").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
                self.ProgressHUDHide()
                if error == nil {
                    self.lastMessages.removeAll()
                    if let snapshot = snapshot, !snapshot.isEmpty {
                        for qds in snapshot.documents {
                            if let lastMessage = try? qds.data(as: LastMessageModel.self) {
                                self.lastMessages.append(lastMessage)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatHome_ChatScreenSeg" {
            if let destinationVC = segue.destination as? ShowChatViewController {
                if let lastMessage = sender as? LastMessageModel {
                    destinationVC.lastMessage = lastMessage
                    destinationVC.from = "lastchat"
                    
                }
            }
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        no_chats_available.isHidden = !lastMessages.isEmpty
        return lastMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homechat", for: indexPath) as? HomeChatTableViewCell else {
            return HomeChatTableViewCell()
        }

        let lastMessage = lastMessages[indexPath.row]

        cell.mImage.makeRounded()
        cell.mImage.layer.borderWidth = 1
        cell.mImage.layer.borderColor = UIColor.lightGray.cgColor
        cell.mView.layer.borderWidth = 1
        cell.mView.layer.cornerRadius = 8
        

       
            guard let senderUid = lastMessage.senderUid else { return cell }
            getUserDataByID(uid: senderUid) { userModel, _ in
                self.configureCell(cell, with: userModel, lastMessage: lastMessage)
          
        }

        cell.mLastMessage.text = lastMessage.message
        cell.mTime.text = lastMessage.date?.timeAgoSinceDate()

        cell.mView.isUserInteractionEnabled = true
        let lastMessageTap = MyGesture(target: self, action: #selector(lastMessageBtnClicked(value:)))
        lastMessageTap.index = indexPath.row
        cell.mView.addGestureRecognizer(lastMessageTap)

        return cell
    }

    private func configureCell(_ cell: HomeChatTableViewCell, with model: Any?, lastMessage: LastMessageModel) {
        guard let senderUid = lastMessage.senderUid else { return }

      if let userModel = model as? UserModel {
            if let index = lastMessages.firstIndex(of: lastMessage) {
                lastMessages[index].senderToken = userModel.notificationToken
            }
            if let image = userModel.profilePic, !image.isEmpty {
                cell.mImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "profile-placeholder"))
            } else {
                cell.mImage.image = UIImage(named: "profile-placeholder")
            }
            cell.mTitle.text = userModel.fullName ?? "Something went wrong"
        } else {
            deleteLastMessage(uid: FirebaseStoreManager.auth.currentUser!.uid, otherUid: senderUid)
        }
    }
}
