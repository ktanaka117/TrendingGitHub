//
//  TrendingTableViewCell.swift
//  TrendingGitHub
//
//  Created by 田中賢治 on 2015/09/21.
//  Copyright © 2015年 田中賢治. All rights reserved.
//

import Foundation
import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var builderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init() {
        self.init()
    }
}