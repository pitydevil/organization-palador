//
//  HomeViewController.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presentor : ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension HomeViewController : PresenterToViewProtocol {
    func showError() {
        
    }
}
