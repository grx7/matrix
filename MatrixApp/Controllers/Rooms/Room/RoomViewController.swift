//
//  RoomViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 22/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import MatrixSDK

class RoomViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextField!
    
    var room: MatrixRoom!
    
    var events: [MatrixEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.room.displayName()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        
        self.messageTextField.backgroundColor = AppColors.lightBlue
        self.messageTextField.textColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        self.loadRoomEvents()
    }
    
    func loadRoomEvents() {
        self.room.room.liveTimeline.listen { (matrixEvent, direction, state) in
            if matrixEvent != nil {
                let event = MatrixEvent(event: matrixEvent!, room: self.room)
                
                if event.shouldShowEventInChat() {
                    self.addEvent(event)
                }
            }
        }
        
        self.room.room.liveTimeline.resetPagination()
        self.room.room.liveTimeline.paginate(30, direction: MXTimelineDirectionBackwards, onlyFromStore: false, complete: {
            self.events = self.events.sorted(by: { (a, b) -> Bool in
                return a.event.age < b.event.age
            })
        }) { (error) in
            print("Could not load history: \(error)")
        }
    }

    func addEvent(_ event: MatrixEvent) {
        self.events.insert(event, at: 0)
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    //MARK: - Keyboard Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]) as? Double,
            let animationOptions = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey]) as? UInt {
            
            self.bottomSpaceConstraint.constant = keyboardSize.height
            UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions(rawValue: animationOptions), animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        if let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]) as? Double,
            let animationOptions = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey]) as? UInt {
            
            self.bottomSpaceConstraint.constant = 0
            UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions(rawValue: animationOptions), animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

}

extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = self.events[indexPath.row]
        
        if (indexPath.row - 1) >= 0 && event.isPartOfChain(previousEvent: self.events[indexPath.row - 1]) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.messageLabel.text = event.asString
                
            return cell
        }
        
        if event.isNotice {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noticeMessageTableViewCell", for: indexPath) as! NoticeMessageTableViewCell
                        
            cell.noticeLabel.text = event.asString
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstMessageTableViewCell", for: indexPath) as! FirstMessageTableViewCell
        
        cell.messageLabel.text = event.asString
        cell.authorLabel.text = event.event.sender
        if event.senderAvatarLink != nil {
            cell.avatarImageView.downloadedFrom(link: event.senderAvatarLink!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
