//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [NSDictionary]! = [NSDictionary]()
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reload()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        NSLog("Hi")
        NSLog("\(self.posts)")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("HERE NuM")
        while self.posts.count == 0 {}
        NSLog("\(self.posts)")
        NSLog("\(self.posts.count)")
        return self.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        NSLog("HERE")
        var cellA = PhotoCell()
        var cellB = StatusCell()
        var picture = false
        var post: NSDictionary = NSDictionary()
        
        while true {
            post = self.posts[indexPath.row + offset]
            var m = post["message"] != nil
            print("\(m)")
            var mp = m && (post["picture"] != nil)
            print("\(m)")
            
            print("\(post)")
            
            if mp {
                cellA = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
                picture = true
                break
            }else if m {
                cellB = tableView.dequeueReusableCellWithIdentifier("StatusCell", forIndexPath: indexPath) as! StatusCell
                break
            }else {
                offset++
            }
        }
            
        if picture {
            cellA.nameLabel!.text = post["name"] as? String
            cellA.statusLabel!.text = post["message"] as? String
            var url = post["picture"] as? String
            cellA.pictureView.setImageWithURL(NSURL(string: url!)!)
            return cellA
        }else {
            cellB.nameLabel!.text = post["name"] as? String
            cellB.statusLabel!.text = post["message"] as? String
            return cellB
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        FBRequestConnection.startWithGraphPath("/me/home", parameters: nil, HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            self.posts = result["data"] as! [NSDictionary]
            NSLog("\(self.posts)")
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
