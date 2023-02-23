//
//  ParentTableViewController.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa

class ParentTableViewController: UIViewController, UISearchBarDelegate {

    //MARK: LAYOUT SUBVIEWS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK: OBJECT DECLARATION
    /// Main Array datasource for the tableView
    private let userList : BehaviorRelay<[[UsersBody]]> = BehaviorRelay(value: [])
    /// Original Array datasource for the tableView Searchbar capabilites.
    private let mainUserList : BehaviorRelay<[[UsersBody]]> = BehaviorRelay(value: [])
    /// Presentor Object to notify the homeViewController Presenter
    var presentor : ViewToPresenterProtocol?
    
    //MARK: VIEWWILLAPPEAR
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - OnAppear Function
        /// Fetch Organization from the endpoint
        Task {
            SVProgressHUD.show(withStatus: "Loading Organizations")
            /// tell the presentor, to fetch the organizationList from the server.
            await presentor?.onAppear()
        }
    }
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Instantiate Navigation Controller
        self.title = "Organization List"
        
        //MARK: - Register TableViewCell
        tableView.register(UINib(nibName: ParentTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: ParentTableViewCell.cellID)
        
        //MARK: - Register Table View & Search Delegate
        tableView.rx.setDelegate(self).disposed(by: bags)
        searchBar.rx.setDelegate(self).disposed(by: bags)
        
        //MARK: - TableView Datasource and Delegate Functions
            //MARK: - Bind User List with the tableView
            userList.bind(to: tableView.rx.items(cellIdentifier: ParentTableViewCell.cellID, cellType: ParentTableViewCell.self)) { [self] row, model, cell in
            
                /// Pass the model to the tableViewCell
                cell.configurCell(model)
                
                /// Tell the protocol, that parent tableViewController will be it's delegate
                cell.delegate = self
                
                /// Reload the table view cell with no animation
                cell.childTableView.reloadData()
                cell.layoutIfNeeded()

                /// Update Child Table View Height according to it's content
                let childTableViewContentSize = cell.childTableView.contentSize.height
                 cell.childTableViewHeightConstraint.constant = childTableViewContentSize

                /// Reload the table view cell with no animation
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }.disposed(by: bags)
        
            //MARK: -  TableView DidSelect Delegate Function
            /// Response User Touch on Upcoming Collection View
            tableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
                tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: bags)
        
        //MARK: - SearchBar Functions
            //MARK: - Search Bar Did Change Delegate Function
            /// Query user array based on us userSearch
            searchBar.rx.text.subscribe(onNext: { [self] searchText in
                /// Check whether the searchText is null or not, if null we set the userList as the originalList, else we filter the array based on the searchtext.
                searchText?.count != 0 ? presentor?.onSearch(mainUserList.value, searchText!) : userList.accept(mainUserList.value)
            }).disposed(by: bags)
    }
}

//MARK: PassBackTableViewDelegate
extension ParentTableViewController : PassBackTableViewCellObject {
    
    //MARK: - passBackTableViewCellObject
    /// Segue to the detailViewController
    /// - Parameters:
    ///     - userArray: an Array of current selected user
    ///     - userObject: choosen User Object from the userArray
    func passBackTableViewCellObject(_ userArray: [UsersBody], _ userObject: UsersBody) {
        presentor?.showDetailController(self.navigationController as! NavigationController, userArray, userObject)
    }
}

//MARK: TableViewDelegate
extension ParentTableViewController : UITableViewDelegate {

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
    
    //MARK: TableView WillDisplay Delegate Function
    /// Update cell nested tableView to it's content size.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let parentCell = cell as? ParentTableViewCell else { return }

        /// Calculate the childTableViewContentSize
        let childTableViewContentSize = parentCell.childTableView.contentSize

        /// Update the height constraint of the child table view
        parentCell.childTableViewHeightConstraint.constant = childTableViewContentSize.height

        /// Update the layout of the parentTableViewCell
        parentCell.layoutIfNeeded()
    }
}

//MARK: PresenterToViewProtocol Delegate
extension ParentTableViewController : PresenterToViewProtocol {
    
    //MARK: - Show Search Function
    /// Return filtered userArray based on the searchBar Text
    /// - Parameters:
    ///     - userArray : array of filtered userBody based on the searchbar Text
    func showSearch(_ userArray: [[UsersBody]]) {
        /// Update the base datasource array for the tableView
        userList.accept(userArray)
    }
    
    //MARK: - Show UserArray Function
    /// Return userArray from the endpoint
    /// - Parameters:
    ///     - userArray : array of userbody that's received from the endpoint
    func showUsersSuccess(_ userArray : [[UsersBody]]) {
        DispatchQueue.main.async { [self] in
            /// Dismiss the current loading state
            SVProgressHUD.dismiss()
            /// Update the main datasource array for the current TableView
            userList.accept(userArray)
            /// Update the original datasource array for searchbar filter function
            mainUserList.accept(userArray)
        }
    }

    //MARK: - Show Error from Presenter
    /// Notify Current User there's something wrong with the fetching process
    func showError() {
        DispatchQueue.main.async { [self] in
            popupAlert(title: "Telah Terjadi Gangguan di Server!", message: "Silahkan coba beberapa saat lagi.", actionTitles: ["OK"], actionsStyle: [UIAlertAction.Style.cancel] ,actions:[{ [self] (action1) in
                navigationController!.popToRootViewController(animated: true)
            }])
        }
    }
}
