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
        
        var elementIndex = 0
        var repositories: [Repository] = []
        
        return Promise { fulfill, reject in
            let request = Alamofire.request(Router.Ranking(language: "swift"))
            request.response({ request, response, data, error in
                if let error = error {
                    reject(error)
                } else {
                    if let data = data {
                        if let doc = Kanna.HTML(html: data, encoding: NSUTF8StringEncoding) {
                            for node in doc.css(".repo-list-item") {
                                let repoListName = dropUnneccessaryElement(doc.css(".repo-list-name")[elementIndex].text!)
                                let repoListDescription = dropUnneccessaryElement(doc.css(".repo-list-description")[elementIndex].text!)
                                
                                var repository = Repository()
                                repository.title = repoListName
                                repository.description = repoListDescription
                                repositories.append(repository)
                                
                                elementIndex++
                            }
                            fulfill(repositories)
                        }
                    }
                }
            })
        }
    }
}

func dropUnneccessaryElement(text: String) -> String {
    let nDrop = text.stringByReplacingOccurrencesOfString("\n", withString: "", options: nil, range: nil)
    let spaceDrop = nDrop.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
    
    return spaceDrop
}
