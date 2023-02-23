//
//  HomeRouter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit

class HomeRouter : PresenterToRouterProtocol{
        
    //MARK: - CreateModule Function
    /// create parentTableViewControllerObject
    static func createModule() -> ParentTableViewController {
        
        /// instantiate Parent TableViewController Object
        let view = mainstoryboard.instantiateViewController(withIdentifier: "parentTableViewController") as! ParentTableViewController
        /// instantiate presenter object
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = HomePresenter()
        /// instatntiate interactor object
        let interactor: PresenterToInteractorProtocol = HomeInteractor()
        /// instantiate router object
        let router:PresenterToRouterProtocol = HomeRouter()
        
        /// inject view presentor
        view.presentor = presenter
        /// inject view to the presenter
        presenter.view = view
        /// inject router to the presenter
        presenter.router = router
        /// inject interactor to the presenter
        presenter.interactor = interactor
        /// inject presenter to the interactor
        interactor.presenter = presenter
        
        return view
    }
    
    //MARK: - mainStoryboard
    /// instantiate storyboard name
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    //MARK: - Push To Detail Screen Functions
    /// Segue to the detailScreen and inject the detailViewController with the necessary object
    /// - Parameters:
    ///     - navigationController: current navigationController
    ///     - userArray: an Array of current selected user
    ///     - userObject: choosen User Object from the userArray
    func pushToDetailScreen(_ navigationConroller: NavigationController, _ userArray: [UsersBody], _ userObject: UsersBody) {
        /// instantiate detailViewController, and inject the userArray and userObject to the module
        let detailModule = DetailRouter.createModule(userArray, userObject)
        /// push the already instantiateViewController
        navigationConroller.pushViewController(detailModule, animated: true)
    }
}
