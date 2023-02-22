//
//  HomeViewController.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class HomeViewController: UIViewController {
    
    //MARK: LAYOUT SUBVIEWS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: OBJECT DECLARATION
    var presentor : ViewToPresenterProtocol?
    
    //MARK: VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - OnAppear Function
        /// Fetch all movies type endpoint from server
        Task {
            SVProgressHUD.show(withStatus: "Fetching Movies")
            await presentor?.onAppear()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension HomeViewController : PresenterToViewProtocol {
    func showError() {
        
    }
}
