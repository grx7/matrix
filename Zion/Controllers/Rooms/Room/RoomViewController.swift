//
//  RoomViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 22/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import MatrixSDK
import SlackTextViewController

class RoomViewController: SLKTextViewController {
    
    var room: MatrixRoom!
    
    var events: [MatrixEvent] = []
    
    override var tableView: UITableView {
        get {
            return super.tableView!
        }
    }
    
    override init(tableViewStyle style: UITableViewStyle) {
        super.init(tableViewStyle: .plain)
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.room.displayName()
        
        self.tableView.backgroundColor = UIColor.clear
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        self.tableView.separatorStyle = .none

        self.textInputbar.backgroundColor = AppColors.lightBlue
        self.textInputbar.textView.backgroundColor = AppColors.lightBlue
        self.textInputbar.textView.textColor = UIColor.lightGray
        
//        self.messageTextField.backgroundColor = AppColors.lightBlue
//        self.messageTextField.textColor = UIColor.lightGray

        self.tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "messageTableViewCell")
        self.tableView.register(UINib(nibName: "NoticeMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "noticeMessageTableViewCell")
        self.tableView.register(UINib(nibName: "FirstMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "firstMessageTableViewCell")
        
        self.loadRoomEvents()
    }
    
    func loadRoomEvents() {
        self.room.room.liveTimeline.__listen { (matrixEvent, direction, state) in
            if matrixEvent != nil {
                let event = MatrixEvent(event: matrixEvent!, room: self.room)
                
                if event.shouldShowEventInChat() {
                    self.addEvent(event)
                }
            }
        }
        
        self.room.room.liveTimeline.resetPagination()
        self.room.room.liveTimeline.__paginate(30, direction: __MXTimelineDirectionBackwards, onlyFromStore: false, complete: {
            self.events = self.events.sorted(by: { (a, b) -> Bool in
                return a.event.age < b.event.age
            })
        }) { (error) in
            print("Could not load history: \(error)")
        }
    }

    func addEvent(_ event: MatrixEvent) {
        self.events.insert(event, at: 0)
        
//        self.tableView.beginUpdates()
//        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        self.tableView.endUpdates()
    }
    
    func sendMessage(_ message: String) {
        self.room.room.sendTextMessage(message, success: { (string) in
            print(string ?? "error")
        }) { (error) in
            print(error ?? "error")
        }
        
        // handle echos

        //print("message: \(message)")
    }
    

}

extension RoomViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = self.events[indexPath.row]
        
        if (indexPath.row - 1) >= 0 && event.isPartOfChain(previousEvent: self.events[indexPath.row - 1]) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewCell") as! MessageTableViewCell
            
            cell.messageLabel.text = event.asString
            cell.transform = self.tableView.transform;
            
            return cell
        }

        if event.isNotice {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noticeMessageTableViewCell", for: indexPath) as! NoticeMessageTableViewCell
                        
            cell.messageLabel.text = event.asString
            cell.transform = self.tableView.transform;
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstMessageTableViewCell", for: indexPath) as! FirstMessageTableViewCell
        
        cell.messageLabel.text = event.asString
        cell.authorLabel.text = event.event.sender
        if event.senderAvatarLink != nil {
            cell.avatarImageView.downloadedFrom(link: event.senderAvatarLink!)
        }
        
        cell.transform = self.tableView.transform;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.messageTextField.resignFirstResponder()
    }
    
}

//extension RoomViewController: UITextFieldDelegate {
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField.text != nil && (textField.text?.characters.count)! > 0 {
//            //self.sendMessage(textField.text!)
//        }
//        return false
//    }
//    
//    
//}
