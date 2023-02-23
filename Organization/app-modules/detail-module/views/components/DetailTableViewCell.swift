//
//  DetailTableViewCell.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    //MARK: LAYOUT SUBVIEWS
    @IBOutlet weak var nameLabel : UILabel!
    
    //MARK: OBJECT DECLARATION
    static var cellID = "DetailTableViewCell"
    
    //MARK: AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Configure Cell Functions
    /// iInstantiate tableViewCellObject
    /// - Parameters:
    ///     - userBody: selected UserBody object for the nameLabel text
    func configurCell(_ userBody : UsersBody) {
        nameLabel.text = "\(userBody.name)"
    }
}
