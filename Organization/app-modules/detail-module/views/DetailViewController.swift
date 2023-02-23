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
    
    //MARK: OBJECT DECLARATION
    private let managerList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    private let subordinateList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    private let titleObservableString : BehaviorRelay<String> = BehaviorRelay(value: String())
    let userList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    let choosenUser : BehaviorRelay<UsersBody> = BehaviorRelay(value: UsersBody(employeeID: 0, name: "", managerID: nil, isHead: false))
    var presentor : ViewToPresenterProtocolDetail?

    
    //MARK: OBJECT OBSERVER DECLARATION
//    private var userListObserver : Observable<[UsersBody]> {
//        return userList.asObservable()
//    }
//
//    private var userListObserver : Observable<[UsersBody]> {
//        return userList.asObservable()
//    }
    
    //MARK: VIEWWILLAPPEAR
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - OnAppear Function
        /// Fetch all movies type endpoint from server
        Task {
            SVProgressHUD.show(withStatus: "Loading Data")
            await presentor?.onAppear(userList.value, choosenUser.value)
        }
    }
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Register TableViewCell
        managerTableView.register(UINib(nibName: DetailTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellID)
        subordinateTableView.register(UINib(nibName: DetailTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellID)
        
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
