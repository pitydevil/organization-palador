//
//  HomeRouter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit

class HomeRouter : PresenterToRouterProtocol{
        
    static func createModule() -> ParentTableViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "parentTableViewController") as! ParentTableViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = HomePresenter()
        let interactor: PresenterToInteractorProtocol = HomeInteractor()
        let router:PresenterToRouterProtocol = HomeRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToDetailScreen(_ navigationConroller: NavigationController, _ userArray: [UsersBody], _ userObject: UsersBody) {
        let detailModule = DetailRouter.createModule(userArray, userObject)
        navigationConroller.pushViewController(detailModule, animated: true)
    }
}
