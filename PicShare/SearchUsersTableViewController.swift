//
//  FeedViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/22/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import Parse
import ParseUI
import Foundation

class SearchUsersTableViewController: PFQueryTableViewController, UserTableViewCellDelegate {
    
    let cellIdentifier = "userCell"
    var friendUsernames: [String] = []
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        self.parseClassName = "_User"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        
    }
    
    override func viewDidLoad() {
        self.tableView.registerNib(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.allowsSelection = false
        self.tableView.backgroundColor = UIColor(red: CGFloat(52)/255.0, green: CGFloat(73)/255.0, blue: CGFloat(94)/255.0, alpha: CGFloat(1))
        self.tableView.separatorColor = UIColor.whiteColor()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
        self.loading = true
        let query = PFQuery(className: "Follow").whereKey("fromUser", equalTo: PFUser.currentUser()!.username!)
        
        if self.friendUsernames.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }
            
        query.findObjectsInBackgroundWithBlock({ (foundObjects, error) -> Void in
            self.loading = false;
            if let foundObjects = foundObjects{
                for foundObject in foundObjects {
                    self.friendUsernames.append(foundObject["toUser"] as! String);
                }
            }
        })
        
        
        super.viewDidLoad()
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: self.parseClassName!).whereKey("username", doesNotMatchKey: "toUser", inQuery: PFQuery(className: "Follow").whereKey("fromUser", equalTo: PFUser.currentUser()!.username!)).whereKey("username", notEqualTo: PFUser.currentUser()!.username!)

        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects!.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }
        
        
        
        query.orderByAscending("username")
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UserTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("UserTableViewCell", owner: self, options: nil)[0] as? UserTableViewCell
        }
        
        // Configure the cell to show todo item with a priority at the bottom
        if let object = object {
            let friendUsername = object["username"] as! String
            cell!.username?.text = "\(friendUsername)"
            cell!.actionButton.setTitle("Follow", forState: UIControlState.Normal)
            cell!.cellDelegate = self
        }
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadObjects()
        super.viewWillAppear(animated)
        
    }
    
    func buttonAction(username:String){
        
        
        let newFriend = PFObject(className: "Follow")
        newFriend["toUser"] = username
        newFriend["fromUser"] = PFUser.currentUser()!.username!
    
        newFriend.saveInBackgroundWithBlock { (success, error ) -> Void in
            self.loadObjects()
        }
        print("follow \(username)");
        
    }
    
    
}
