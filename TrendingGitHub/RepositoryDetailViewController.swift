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
    var repository: Repository!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(repository: Repository) {
        self.init()
        
        self.repository = repository
        self.title = repository.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView = UITextView(frame: view.frame)
        textView.dataDetectorTypes = UIDataDetectorTypes.Link
        view.addSubview(textView)
        
        loadReadme()
    }
    
    func loadReadme() {
        firstly {
            Trending.getReadmeTask(self.repository.builder, repositoryName: self.repository.title)
        }.then { readme in
            self.markdown = readme
        }.ensure {
            let html = try? MMMarkdown.HTMLStringWithMarkdown(self.markdown!, extensions: MMMarkdownExtensions.GitHubFlavored)
            let options = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
            let preview = try? NSAttributedString(data: html!.dataUsingEncoding(NSUTF8StringEncoding)!, options: options, documentAttributes: nil)
            
            self.textView.attributedText = preview
            self.textView.editable = false
        }
    }
    
}
