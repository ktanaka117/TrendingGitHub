//
//  Trending.swift
//  TrendingGitHub
//
//  Created by 田中賢治 on 2015/09/15.
//  Copyright (c) 2015年 田中賢治. All rights reserved.
//

import Foundation
import Alamofire
import Kanna
import PromiseKit

class Trending {
    class func getTrendingTask() -> Promise<[Repository]> {
        
        var repositories: [Repository] = []
        
        return Promise { fulfill, reject in
            let request = Alamofire.request(Router.Ranking(language: "swift"))
            request.response { request, response, data, error in
                if let error = error {
                    reject(error)
                } else {
                    if let data = data {
                        if let doc = Kanna.HTML(html: data, encoding: NSUTF8StringEncoding) {
                            for var i = 0; i < doc.css(".repo-list-item").count-1; i++ {
                                let repoBuilder = doc.css(".prefix")[i].text!
                                let repoName = getTitle(dropUnneccessaryElement(doc.css(".repo-list-name")[i].text!))
                                let repoDescription = dropUnneccessaryElement(doc.css(".repo-list-description")[i].text!)
                                
                                var repository = Repository()
                                repository.builder = repoBuilder
                                repository.title = repoName
                                repository.description = repoDescription
                                repositories.append(repository)
                            }
                            fulfill(repositories)
                        }
                    }
                }
            }
        }
    }
}

func getTitle(text: String) -> String {
    let str: NSString = text
    let loc = str.rangeOfString("/").location
    return str.substringFromIndex(loc+1)
}

func dropUnneccessaryElement(text: String) -> String {
    let nDrop = text.stringByReplacingOccurrencesOfString("\n", withString: "", options: [], range: nil)
    let spaceDrop = nDrop.stringByReplacingOccurrencesOfString(" ", withString: "", options: [], range: nil)
    
    return spaceDrop
}
