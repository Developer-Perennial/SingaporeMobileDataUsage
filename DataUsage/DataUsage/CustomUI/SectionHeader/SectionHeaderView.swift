//
//  SectionHeaderView.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    func configureHeader(title:String, valueTitle : String)
    {
        lblTitle.text = title
        lblValue.text = valueTitle
        contentView.backgroundColor = .white
    }
}
