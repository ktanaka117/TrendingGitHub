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

class TopTableViewController: UITableViewController {
    
    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
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
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID)
        cell.textLabel?.text = repositories[indexPath.row].title
        cell.detailTextLabel?.text = repositories[indexPath.row].description
        
        return cell
    }
    
    func dropUnneccessaryElement(text: String) -> String {
        let nDrop = text.stringByReplacingOccurrencesOfString("\n", withString: "", options: [], range: nil)
        let spaceDrop = nDrop.stringByReplacingOccurrencesOfString(" ", withString: "", options: [], range: nil)
        
        return spaceDrop
    }
    
}

