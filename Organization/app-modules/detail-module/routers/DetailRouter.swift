//
//  DetailRouter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import UIKit

class DetailRouter : PresenterToRouterProtocolDetail{
    static func createModule(_ userArray: [UsersBody], _ choosenUser: UsersBody) -> DetailViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        
        let presenter: ViewToPresenterProtocolDetail & InteractorToPresenterProtocolDetail = DetailPresenter()
        let interactor: PresenterToInteractorProtocolDetail = DetailInteractor()
        let router:PresenterToRouterProtocolDetail = DetailRouter()
        
        view.presentor = presenter
        view.choosenUser.accept(choosenUser)
        view.userList.accept(userArray)
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
