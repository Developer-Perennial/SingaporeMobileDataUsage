//
//  DataUsageTableViewCell.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import UIKit

protocol DataUsageTableViewCellDelegate : class {
    
    func imageViewClicked(cell : DataUsageTableViewCell)
}

class DataUsageTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var arrowimageView: UIImageView!
    @IBOutlet weak var lblYearName: UILabel!
    @IBOutlet weak var lblDataUsage: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    weak var delegate : DataUsageTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setYearData(name : String, dataUsage : String,messge : String?)
    {
        lblYearName.text = name
        lblDataUsage.text = dataUsage
        lblMessage.text = messge
    }
    func setupClickableImage(isClickable : Bool,isExpanded : Bool)
    {
        imageContainerView.isHidden = !isClickable
        lblMessage.isHidden = !isExpanded
    }

    @IBAction func imageViewClicked(_ sender: Any) {
        delegate?.imageViewClicked(cell: self)
    }
}
