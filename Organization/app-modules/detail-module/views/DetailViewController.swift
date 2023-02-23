//
//  DetailViewController.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD

class DetailViewController: UIViewController {

    //MARK: LAYOUT SUBVIEWS
    @IBOutlet var subordinateTableView: UITableView!
    @IBOutlet var managerTableView: UITableView!
    @IBOutlet var titleTextfield: UITextField!
    @IBOutlet var managerHeightConstant: NSLayoutConstraint!
    @IBOutlet var subordinateHeightConstant: NSLayoutConstraint!
    @IBOutlet var managerLabel: UILabel!
    @IBOutlet var subordinateLabel: UILabel!
    
    //MARK: OBJECT DECLARATION
    private let managerList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    private let subordinateList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    private let titleObservableString : BehaviorRelay<String> = BehaviorRelay(value: String())
    let userList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    let choosenUser : BehaviorRelay<UsersBody> = BehaviorRelay(value: UsersBody(employeeID: 0, name: "", managerID: nil, isHead: false))
    var presentor : ViewToPresenterProtocolDetail?

    //MARK: VIEWWILLAPPEAR
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - OnAppear Function
        /// Fetch all movies type endpoint from server
        Task {
            SVProgressHUD.show(withStatus: "Loading Data")
            await presentor?.onAppear(userList.value, choosenUser.value)
        }
    }
    
    //MARK: ViewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        managerHeightConstant.constant = managerTableView.contentSize.height
        subordinateHeightConstant.constant = subordinateTableView.contentSize.height
        titleTextfield.setLeftPaddingPoints(8.0)
    }
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Register TableViewCell
        managerTableView.register(UINib(nibName: DetailTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellID)
        managerTableView.allowsSelection = false
        subordinateTableView.register(UINib(nibName: DetailTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellID)
        subordinateTableView.allowsSelection = false
        managerTableView.rx.setDelegate(self).disposed(by: bags)
        
        //MARK: - TableView Datasource and Delegate Functions
            //MARK: - Bind upcomingMoviesList with Table View
            // Bind upcomingMoviesList with Table View
            managerList.bind(to: managerTableView.rx.items(cellIdentifier: DetailTableViewCell.cellID, cellType: DetailTableViewCell.self)) { row, model, cell in
                // Reload the table view cell with no animation
                cell.configurCell(model, row)
            }.disposed(by: bags)
        
        
            //MARK: - Bind upcomingMoviesList with Table View
            // Bind upcomingMoviesList with Table View
            subordinateList.bind(to: subordinateTableView.rx.items(cellIdentifier: DetailTableViewCell.cellID, cellType: DetailTableViewCell.self)) { row, model, cell in
                // Reload the table view cell with no animation
                cell.configurCell(model, row)
            }.disposed(by: bags)
        
            //MARK: - Textfield Delegate Functions
                //MARK: - Bind upcomingMoviesList with Table View
                // Bind upcomingMoviesList with Table View
                titleObservableString
                    .bind(to: titleTextfield.rx.text)
                    .disposed(by: bags)
        
    }
}

extension DetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

extension DetailViewController : PresenterToViewProtocolDetail {
    
    //MARK: - Return Genre Array for CollectionView
    /// Return genre array for genre collection view
    /// - Parameters:
    ///     - genre : an object that return an array of genres for genre collectionview
    func showManagers(_ userArray: [UsersBody]) {
        DispatchQueue.main.async { [self] in
            title = "\(choosenUser.value.name)"
            titleObservableString.accept(choosenUser.value.name)
            SVProgressHUD.dismiss()
            managerList.accept(userArray)
            if userArray.isEmpty {
                managerLabel.isHidden = true
                managerTableView.isHidden = true
                managerHeightConstant.constant = 0
                managerTableView.layoutIfNeeded()
            }
        }
    }
    
    //MARK: - Return Genre Array for CollectionView
    /// Return genre array for genre collection view
    /// - Parameters:
    ///     - genre : an object that return an array of genres for genre collectionview
    func showSubordinates(_ userArray: [UsersBody]) {
        DispatchQueue.main.async { [self] in
            title = "\(choosenUser.value.name)"
            titleObservableString.accept(choosenUser.value.name)
            SVProgressHUD.dismiss()
            subordinateList.accept(userArray)
            if userArray.isEmpty {
                subordinateTableView.isHidden = true
                subordinateLabel.isHidden = true
            }
        }
    }
    
    //MARK: - Return Genre Array for CollectionView
    /// Return genre array for genre collection view
    /// - Parameters:
    ///     - genre : an object that return an array of genres for genre collectionview
    func showError() {
        DispatchQueue.main.async { [self] in
            popupAlert(title: "Telah Terjadi Gangguan di Server!", message: "Silahkan coba beberapa saat lagi.", actionTitles: ["OK"], actionsStyle: [UIAlertAction.Style.cancel] ,actions:[{ [self] (action1) in
                navigationController!.popToRootViewController(animated: true)
            }])
        }
    }
}
