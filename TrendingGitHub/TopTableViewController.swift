//
//  ViewController.swift
//  TrendingGitHub
//
//  Created by 田中賢治 on 2015/09/10.
//  Copyright (c) 2015年 田中賢治. All rights reserved.
//

import UIKit
import Kanna
import Alamofire

let cellID = "Cell"

class TopTableViewController: UITableViewController {
    
    var libTitleArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        getTrending()
    }
    
    func getTrending() {
        Alamofire.request(.GET, "https://github.com/trending?l=swift").response({[weak self] request, response, data, error in
            
            if let s = self {
                if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
                    // print an element of one library.
                    println(doc.css("h3.repo-list-name").first!.toHTML)
                    
                    for node2 in doc.css("h3.repo-list-name") {
                        let str = node2.text?.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
                        
                        let str2 = str?.stringByReplacingOccurrencesOfString("\n", withString: "", options: nil, range: nil)
                        println(str2)
                        
                        s.libTitleArray.append(str2!)
                    }
                    
                    s.tableView.reloadData()
                }
            }
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let repositoryDetailViewController = RepositoryDetailViewController()
        repositoryDetailViewController.title = libTitleArray[indexPath.row]
        navigationController?.pushViewController(repositoryDetailViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libTitleArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = libTitleArray[indexPath.row]
        
        return cell
    }

}

