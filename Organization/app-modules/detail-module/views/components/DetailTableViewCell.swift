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
    
    //MARK: AWAKEFROMNIB
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    //MARK: - Convert Users to User Hierarchy Function
    /// Return result argument whether scrollview is already the bottom or not
    /// - Parameters:
    ///     - user1DArray: movie type that's gonan be passed onto the fetch movie endpoint
    func configurCell(_ userBody : UsersBody, _ row : Int) {
        var tempSpacer = ""
        if row != 0 {
            for _ in 0...row-1 {
                tempSpacer += "   "
            }
            nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }else {
            nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        nameLabel.text = "\(tempSpacer)\(userBody.name)"
    }
}