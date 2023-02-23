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
    /// Main Array datasource for the managerTableView
    private let managerList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    /// Main Array datasource for the subordinateTableView
    private let subordinateList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    /// Main Text datasource for the titleTextfield
    private let titleObservableString : BehaviorRelay<String> = BehaviorRelay(value: String())
    
    /// original Array datasource, to be injected by parentViewController
    let userList : BehaviorRelay<[UsersBody]> = BehaviorRelay(value: [])
    /// choosenUserObject to be injected by the parentViewController
    let choosenUser : BehaviorRelay<UsersBody> = BehaviorRelay(value: UsersBody(employeeID: 0, name: "", managerID: nil, isHead: false))
    /// initiate presentorObject for the viewToPresenter
    var presentor : ViewToPresenterProtocolDetail?

    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - OnAppear Function
        /// Fetch Manager and Subordinate from the original userArray
        Task {
            SVProgressHUD.show(withStatus: "Loading Data")
            /// tell the presentor, to fetch manager and subordinate from the original userArray
            await presentor?.onAppear(userList.value, choosenUser.value)
        }
    }
    
    //MARK: ViewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        /// update manager height constant based on the manager content size
        managerHeightConstant.constant = managerTableView.contentSize.height
        /// update subordinate height constant based on the subordinate content size
        subordinateHeightConstant.constant = subordinateTableView.contentSize.height
        /// set left padding for the initial textfield
        titleTextfield.setLeftPaddingPoints(8.0)
    }
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Register TableViewCell
        /// register detailTableViewCell with the managerTableView
        managerTableView.register(UINib(nibName: DetailTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellID)
        
        /// disable selection for managerTableView
        managerTableView.allowsSelection = false
        
        /// register subordinateTableView with the subordinateTableView
        subordinateTableView.register(UINib(nibName: DetailTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellID)
        
        /// disable selection for subordinateTableView
        subordinateTableView.allowsSelection = false
        
        //MARK: - Register TableView Delegate
        managerTableView.rx.setDelegate(self).disposed(by: bags)
        subordinateTableView.rx.setDelegate(self).disposed(by: bags)
        
        //MARK: - TableView Datasource and Delegate Functions
            //MARK: - Bind managerList with Table View
            managerList.bind(to: managerTableView.rx.items(cellIdentifier: DetailTableViewCell.cellID, cellType: DetailTableViewCell.self)) { row, model, cell in
                /// Configure Cell with the currentDequeuedModel
                cell.configurCell(model)
            }.disposed(by: bags)
        
            //MARK: - Bind subordinateList with Table View
            subordinateList.bind(to: subordinateTableView.rx.items(cellIdentifier: DetailTableViewCell.cellID, cellType: DetailTableViewCell.self)) { row, model, cell in
                /// Configure Cell with the currentDequeuedModel
                cell.configurCell(model)
            }.disposed(by: bags)
        
        //MARK: - Textfield Delegate Functions
            //MARK: - Bind titleObservableString with textField
            titleObservableString
                .bind(to: titleTextfield.rx.text)
                .disposed(by: bags)
    }
}

//MARK: TableViewDelegate
extension DetailViewController : UITableViewDelegate {
    
    //MARK: TableView WillDisplay Delegate Function
    /// Update tableView height to it's content size.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

//MARK: PresenterToViewProtocolDetail Delegate
extension DetailViewController : PresenterToViewProtocolDetail {
    
    //MARK: - Show Managers Function
    ///  Update managerList as the main datasource for the managerTableView
    /// - Parameters:
    ///     - userArray : an array of userBody object that's already filtered for the managerList
    func showManagers(_ userArray: [UsersBody]) {
        DispatchQueue.main.async { [self] in
            /// Dismiss loading spinner
            SVProgressHUD.dismiss()
            /// Change navigation Item to choosenUser name object
            title = "\(choosenUser.value.name)"
            /// change titleObservableString for the uitextfield to the choosenUser name object
            titleObservableString.accept(choosenUser.value.name)
            /// update managerList array as the main datasource for the managerTableView
            managerList.accept(userArray)
            /// Check if userArray is empty , if it's hide the managerLabel and change the height constant
            if userArray.isEmpty {
                /// hide managerLabel
                managerLabel.isHidden = true
                /// hide managerTableView
                managerTableView.isHidden = true
                /// change managerTableViewHeightConstant to 0
                managerHeightConstant.constant = 0
                /// update managerTableView layout
                managerTableView.layoutIfNeeded()
            }
        }
    }
    
    //MARK: - Show Subordinates Function
    ///  Update subordinate list as the main datasource for the subodinateTABLEvIEW
    /// - Parameters:
    ///     - userArray : an array of userBody object that's already filtered for the managerList
    func showSubordinates(_ userArray: [UsersBody]) {
        DispatchQueue.main.async { [self] in
            /// Dismiss loading spinner
            SVProgressHUD.dismiss()
            /// Change navigation Item to choosenUser name object
            title = "\(choosenUser.value.name)"
            /// change titleObservableString for the uitextfield to the choosenUser name object
            titleObservableString.accept(choosenUser.value.name)
            /// update subordinateList array as the main datasource for the subordinateTableView
            subordinateList.accept(userArray)
            /// Check if userArray is empty , if it's hide the managerLabel and change the height constant
            if userArray.isEmpty {
                /// hide subordinateTableView
                subordinateTableView.isHidden = true
                /// hide subrodinateLabel
                subordinateLabel.isHidden = true
            }
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
