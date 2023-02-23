//
//  ParentTableViewCell.swift
//  test
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit
import RxSwift
import RxCocoa

class ParentTableViewCell: UITableViewCell {

    //MARK: LAYOUT SUBVIEWS
    @IBOutlet weak var childTableView: UITableView!
    @IBOutlet weak var childTableViewHeightConstraint: NSLayoutConstraint!

    //MARK: OBJECT DECLARATION
    static var cellID = "ParentTableViewCell"
    private let userList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    var delegate : PassBackTableViewCellObject?

    //MARK: AWAKEFROMNIB
    override func awakeFromNib() {
        super.awakeFromNib()

        //MARK: - Register TableViewCell
        childTableView.rx.setDelegate(self).disposed(by: bags)
        childTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ChildTableViewCell")
      
        //MARK: - TableView Datasource and Delegate Functions
            //MARK: - Bind upcomingMoviesList with Table View
            // Bind upcomingMoviesList with Table View
        userList.bind(to: childTableView.rx.items(cellIdentifier: "ChildTableViewCell", cellType: UITableViewCell.self)) { [self] row, model, cell in
                cell.accessoryType = .disclosureIndicator
                let obj = userList.value[row]
                var tempSpacer = ""
                if row != 0 {
                    for _ in 0...row-1 {
                        tempSpacer += "   "
                    }
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                }else {
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                }
                
                cell.textLabel?.text = "\(tempSpacer)\(obj.name)"
            }.disposed(by: bags)
        
        //MARK: - Upcoming Collection View DidSelect Delegate Function
        /// Response User Touch on Upcoming Collection View
        childTableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            /// Send User's choosen Upcoming Movie Object to response handleMovieFunction
            childTableView.deselectRow(at: indexPath, animated: true)
            delegate?.passBackTableViewCellObject(userList.value, userList.value[indexPath.row])
        }).disposed(by: bags)
    }
    
    //MARK: - Convert Users to User Hierarchy Function
    /// Return result argument whether scrollview is already the bottom or not
    /// - Parameters:
    ///     - user1DArray: movie type that's gonan be passed onto the fetch movie endpoint
    func configurCell(_ userArray : [UsersBody]) {
        userList.accept(userArray)
    }
}

//MARK: TABLEVIEWDELEGATE
extension ParentTableViewCell : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
