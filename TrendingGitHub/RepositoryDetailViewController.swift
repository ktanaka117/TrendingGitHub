//
//  RepositoryDetailViewController.swift
//  TrendingGitHub
//
//  Created by 田中賢治 on 2015/09/10.
//  Copyright (c) 2015年 田中賢治. All rights reserved.
//

import UIKit
import PromiseKit
import MMMarkdown

class RepositoryDetailViewController: UIViewController {
    
    var textView: UITextView!
    var markdown: String?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView = UITextView(frame: view.frame)
        view.addSubview(textView)
        
        loadReadme()
    }
    
    func loadReadme() {
        firstly {
            Trending.getReadmeTask()
        }.then { readme in
            self.markdown = readme
        }.finally {
            let html = MMMarkdown.HTMLStringWithMarkdown(self.markdown!, extensions: MMMarkdownExtensions.GitHubFlavored, error: nil)
            let options = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
            let preview = NSAttributedString(data: html.dataUsingEncoding(NSUTF8StringEncoding)!, options: options, documentAttributes: nil, error: nil)
            
            self.textView.attributedText = preview
            self.textView.editable = false
        }
    }
    
}
