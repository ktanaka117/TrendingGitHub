//
//  ViewController.swift
//  TrendingGitHub
//
//  Created by 田中賢治 on 2015/09/10.
//  Copyright (c) 2015年 田中賢治. All rights reserved.
//

import UIKit
import PromiseKit

let cellID = "Cell"

class TrendingTableViewController: UITableViewController {
    
    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        loadTrending()
    }
    
    func loadTrending() {
        firstly {
            Trending.getTrendingTask()
        }.then { repositories in
            self.repositories = repositories
        }.ensure {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let repositoryDetailViewController = RepositoryDetailViewController(repository: repositories[indexPath.row])
        navigationController?.pushViewController(repositoryDetailViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! TrendingTableViewCell
        cell.builderLabel.text = repositories[indexPath.row].builder
        cell.titleLabel.text = repositories[indexPath.row].title
        cell.descriptionLabel.text = repositories[indexPath.row].description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 96
    }
    
    func dropUnneccessaryElement(text: String) -> String {
        let nDrop = text.stringByReplacingOccurrencesOfString("\n", withString: "", options: [], range: nil)
        let spaceDrop = nDrop.stringByReplacingOccurrencesOfString(" ", withString: "", options: [], range: nil)
        
        return spaceDrop
    }
    
}

