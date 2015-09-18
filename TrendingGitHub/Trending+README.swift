//
//  Trending+README.swift
//  TrendingGitHub
//
//  Created by 田中賢治 on 2015/09/17.
//  Copyright (c) 2015年 田中賢治. All rights reserved.
//

import Foundation
import Alamofire
import Kanna
import PromiseKit

extension Trending {
    
    class func getReadmeTask() -> Promise<String> {
        return Promise { fulfill, reject in
            let request = Alamofire.request(Router.Readme(builder: "Alamofire", repositoryTitle: "Alamofire"))
            request.response({ request, response, data, error in
                if let error = error {
                    reject(error)
                } else {
                    if let data = data {
                        let markdownStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                        fulfill(markdownStr as! String)
                    }
                }
            })
        }
    }
}