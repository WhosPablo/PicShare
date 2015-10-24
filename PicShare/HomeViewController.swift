//
//  UserViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/16/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import Parse
import ParseUI
import Foundation

class HomeViewController: PFQueryTableViewController {
    
    let cellIdentifier:String = "PhotoCell"
    
    
   
    
    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.rowHeight = 350
        self.tableView.allowsSelection = false
        self.tableView.backgroundColor = UIColor(red: CGFloat(52)/255.0, green: CGFloat(73)/255.0, blue: CGFloat(94)/255.0, alpha: CGFloat(1))
        self.tableView.separatorColor = UIColor.whiteColor()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutAction(sender: AnyObject) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier("logOutDone", sender: self)
    }
    
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        self.parseClassName = "Photo"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadObjects()
        super.viewWillAppear(animated)
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: self.parseClassName!).whereKey("user", matchesKey: "toUser", inQuery: PFQuery(className:"Follow").whereKey("fromUser", equalTo: PFUser.currentUser()!.username!))
        
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects!.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }
        
        query.orderByDescending("createdAt")
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        var cell:PhotoTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PhotoTableViewCell
        
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("PhotoTableViewCell", owner: self, options: nil)[0] as? PhotoTableViewCell
        }
        
        cell?.parseObject = object
        
        // Configure the cell to show todo item with a priority at the bottom
        if let object = object {
            
            let userName = object["user"] as! String
            
            cell?.userNameLabel?.text = userName
            
            cell?.photoImageView?.image = nil
            
            let userImageFile = object["photo"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell?.photoImageView?.image = image
                    }
                }
            }
            
            
        }
        
        return cell
    }
}