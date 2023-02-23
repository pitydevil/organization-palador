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
    private let childTableID = "ChildTableViewCell"
    private let userList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    var delegate : PassBackTableViewCellObject?

    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()

        //MARK: - Register TableViewCell & TableView Delegate
        childTableView.rx.setDelegate(self).disposed(by: bags)
        childTableView.register(UITableViewCell.self, forCellReuseIdentifier: childTableID)
      
        //MARK: - TableView Datasource and Delegate Functions
            //MARK: - Bind userList with Table View
            /// Bind userList object as the datasource for the childTableView
        userList.bind(to: childTableView.rx.items(cellIdentifier: childTableID, cellType: UITableViewCell.self)) { [self] row, model, cell in
                
                /// set the cell accessory tpe to disclosure indicator
                cell.accessoryType = .disclosureIndicator
            
                // Current userList object that we want to dequeue.
                let currentUserObj = userList.value[row]
            
                /// CalculateTheSpacer for the textLabel according to it's row
                /// Use tempSpacer as the baseSpacer to concatenante the base text for the textlabel
                var tempSpacer = ""
                /// if the current row is zero, no need to add spacer, if else we need to add spacer according to it's row position.
                if row != 0 {
                    for _ in 0...row-1 {
                        tempSpacer += "   "
                    }
                    /// Set textlabel font size as regular
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                }else {
                    /// Set textlabel font size as bold
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                }
                
                /// Set textlabel text current user object and the spacer.
                cell.textLabel?.text = "\(tempSpacer)\(currentUserObj.name)"
            }.disposed(by: bags)
        
        //MARK: - Child TableView DidSelect Delegate Function
        /// Response User Touch on child Table View
        childTableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            /// Send user's choosen object to the delegate function, so the delegate can notify the parentTableViewController
            childTableView.deselectRow(at: indexPath, animated: true)
            
            /// Pass Choosen TableView Object to the parent TableView Controller
            /// - Parameters:
            ///     - userArray: an Array of current selected user
            ///     - userObject: choosen User Object from the userArray
            delegate?.passBackTableViewCellObject(userList.value, userList.value[indexPath.row])
        }).disposed(by: bags)
    }
    
    //MARK: - configureCell Function
    /// Update userList as the main datasource array for the childTableView
    /// - Parameters:
    ///     - userArray: an array of user Array that's gonna be used as the main datasource
    func configurCell(_ userArray : [UsersBody]) {
        userList.accept(userArray)
    }
}

//MARK: TableViewDelegate Functions
extension ParentTableViewCell : UITableViewDelegate {
    
    //MARK: TableView HeightForRow Delegate Function
    /// Set the height of row as dynamic
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    //MARK: TableView estimatedHeightForRow Delegate Function
    /// Set initial heightForRow
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
