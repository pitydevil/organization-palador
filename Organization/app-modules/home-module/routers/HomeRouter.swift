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
    
    func pushToDetailScreen(navigationConroller: NavigationController) {
//        let detailModule = DetailRouter.createModule()
//        detailModule.movieIdObject.accept(movieIdObject)
//        navigationConroller.pushViewController(detailModule, animated: true)
    }
}
