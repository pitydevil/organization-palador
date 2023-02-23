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
    private let userList : BehaviorRelay<[[UsersBody]]> = BehaviorRelay(value: [])
    private let mainUserList : BehaviorRelay<[[UsersBody]]> = BehaviorRelay(value: [])
    var presentor : ViewToPresenterProtocol?
    
    //MARK: VIEWWILLAPPEAR
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - OnAppear Function
        /// Fetch all movies type endpoint from server
        Task {
            SVProgressHUD.show(withStatus: "Loading Organizations")
            await presentor?.onAppear()
        }
    }
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Instantiate & Register Controller
        self.title = "Organization List"
        
        // Connect Add Button with the necessary IBAction
        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(responseAddButton))
        self.navigationItem.rightBarButtonItem  = buttonAdd
        
        //MARK: - Register TableViewCell
        tableView.register(UINib(nibName: ParentTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: ParentTableViewCell.cellID)
        
        //MARK: - Register View Controller Delegate
        tableView.rx.setDelegate(self).disposed(by: bags)
        searchBar.rx.setDelegate(self).disposed(by: bags)
        
        //MARK: - TableView Datasource and Delegate Functions
            //MARK: - Bind upcomingMoviesList with Table View
            // Bind upcomingMoviesList with Table View
            userList.bind(to: tableView.rx.items(cellIdentifier: ParentTableViewCell.cellID, cellType: ParentTableViewCell.self)) { [self] row, model, cell in
                    // Reload the table view cell with no animation
                cell.configurCell(model)
                cell.delegate = self
                cell.childTableView.reloadData()
                cell.layoutIfNeeded()

                let childTableViewContentSize = cell.childTableView.contentSize.height
                 cell.childTableViewHeightConstraint.constant = childTableViewContentSize

                // Reload the table view cell with no animation
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }.disposed(by: bags)
        
            //MARK: - Upcoming Collection View DidSelect Delegate Function
            /// Response User Touch on Upcoming Collection View
            tableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
                tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: bags)
        
        //MARK: - SearchBar Functions
            //MARK: - Bind upcomingMoviesList with Table View
            // Bind upcomingMoviesList with Table View
            searchBar.rx.text.subscribe(onNext: { [self] searchText in
                searchText?.count != 0 ? presentor?.onSearch(mainUserList.value, searchText!) : userList.accept(mainUserList.value)
            }).disposed(by: bags)
    }
    
    @objc private func responseAddButton() {
        
    }
}

extension ParentTableViewController : PassBackTableViewCellObject {
    func passBackTableViewCellObject(_ userArray: [UsersBody], _ userObject: UsersBody) {
        presentor?.showDetailController(self.navigationController as! NavigationController, userArray, userObject)
    }
}

extension ParentTableViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let parentCell = cell as? ParentTableViewCell else { return }

        // Calculate the childTableViewContentSize
        let childTableViewContentSize = parentCell.childTableView.contentSize

        // Update the height constraint of the child table view
        parentCell.childTableViewHeightConstraint.constant = childTableViewContentSize.height

        // Update the layout of the parentTableViewCell
        parentCell.layoutIfNeeded()
    }
}

extension ParentTableViewController : PresenterToViewProtocol {
    
    //MARK: - Return Genre Array for CollectionView
    /// Return genre array for genre collection view
    /// - Parameters:
    ///     - genre : an object that return an array of genres for genre collectionview
    func showSearch(_ userArray: [[UsersBody]]) {
        userList.accept(userArray)
    }
    
    //MARK: - Return Genre Array for CollectionView
    /// Return genre array for genre collection view
    /// - Parameters:
    ///     - genre : an object that return an array of genres for genre collectionview
    func showUsersSuccess(_ userArray : [[UsersBody]]) {
        DispatchQueue.main.async { [self] in
            SVProgressHUD.dismiss()
            userList.accept(userArray)
            mainUserList.accept(userArray)
            tableView.reloadData()
        }
    }

    //MARK: - Show Error from Presenter
    func showError() {
        DispatchQueue.main.async { [self] in
            popupAlert(title: "Telah Terjadi Gangguan di Server!", message: "Silahkan coba beberapa saat lagi.", actionTitles: ["OK"], actionsStyle: [UIAlertAction.Style.cancel] ,actions:[{ [self] (action1) in
                navigationController!.popToRootViewController(animated: true)
            }])
        }
    }
}
