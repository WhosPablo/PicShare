//
//  FeedViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/16/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import Parse
import ParseUI
import Foundation

class FriendsTableViewController: PFQueryTableViewController, UserTableViewCellDelegate {
    
    let cellIdentifier = "friendCell"
    var selectedUser:String = ""
    
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        self.parseClassName = "Follow"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
    }
    
    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.backgroundColor = UIColor(red: CGFloat(52)/255.0, green: CGFloat(73)/255.0, blue: CGFloat(94)/255.0, alpha: CGFloat(1))
        self.tableView.separatorColor = UIColor.whiteColor()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)

        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadObjects()
        super.viewWillAppear(animated)
        
    }
    
    override func queryForTable() -> PFQuery {
        let currentUser = PFUser.currentUser();
        let query = PFQuery(className: self.parseClassName!).whereKey("fromUser", equalTo: currentUser!.username!)
        
        
        
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
            cell!.textLabel!.text = object["text"] as? String
            let friendUsername = object["toUser"] as! String
            cell!.username?.text = "\(friendUsername)"
            cell!.actionButton.setTitle("Unfollow", forState: UIControlState.Normal)
            cell!.cellDelegate = self
        
        }
        
        return cell
    }
    
    func buttonAction(username: String) {
        PFQuery(className: "Follow").whereKey("fromUser", equalTo: PFUser.currentUser()!.username!).whereKey("toUser", equalTo: username)
            .findObjectsInBackgroundWithBlock {  (objects, error) -> Void in
                if let objects = objects {
                    for object:PFObject in objects{
                        object.deleteInBackgroundWithBlock({ (success, error ) -> Void in
                            self.loadObjects()
                        })
                    }
                }
                
        }
        print("unfollow \(username)");
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = objectAtIndexPath(indexPath);
        self.selectedUser = object!["toUser"] as! String;
        performSegueWithIdentifier("showUser", sender: self)
        
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUser" {
            let destination = segue.destinationViewController as? UserViewController
            destination?.user = selectedUser
        }
    }
    
    
    
    
}
