//
//  Router.swift
//  TrendingGitHub
//
//  Created by 田中賢治 on 2015/09/15.
//  Copyright (c) 2015年 田中賢治. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case Ranking(language: String)
    
    var URLString: String {
        switch self {
        case .Ranking(let language):
            return "https://github.com/trending?l=\(language)"
        }
    }
    
    // MARK: - URLRequestConvertible
    var URLRequest: NSURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URLString)!)
        
        return mutableURLRequest
    }
}
