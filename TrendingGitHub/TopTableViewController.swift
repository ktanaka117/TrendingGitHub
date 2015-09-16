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
    
    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        getTrending()
    }
    
    func getTrending() {
        
        var elementIndex = 0
        
        Alamofire.request(Router.Ranking(language: "swift")).response({ [weak self] request, response, data, error in
            if let s = self {
                if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
                    for node in doc.css(".repo-list-item") {
                        let repoListName = s.dropUnneccessaryElement(doc.css(".repo-list-name")[elementIndex].text!)
                        let repoListDescription = s.dropUnneccessaryElement(doc.css(".repo-list-description")[elementIndex].text!)
                        
                        var repository = Repository()
                        repository.title = repoListName
                        repository.description = repoListDescription
                        s.repositories.append(repository)
                        
                        elementIndex++
                    }
                }
                s.tableView.reloadData()
            }
            })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let repositoryDetailViewController = RepositoryDetailViewController()
        repositoryDetailViewController.title = repositories[indexPath.row].title
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
        let nDrop = text.stringByReplacingOccurrencesOfString("\n", withString: "", options: nil, range: nil)
        let spaceDrop = nDrop.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        
        return spaceDrop
    }
    
}

