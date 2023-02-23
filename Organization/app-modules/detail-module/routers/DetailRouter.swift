//
//  DetailRouter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import UIKit

class DetailRouter : PresenterToRouterProtocolDetail{
    
    //MARK: - CreateModule Function
    /// create DetailViewController
    /// - Parameters:
    ///     - userArray: an Array of current selected user
    ///     - userObject: choosen User Object from the userArray
    static func createModule(_ userArray: [UsersBody], _ choosenUser: UsersBody) -> DetailViewController {
        
        /// instantiate DetailViewController Object
        let view = mainstoryboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        /// instantiate presenter object
        let presenter: ViewToPresenterProtocolDetail & InteractorToPresenterProtocolDetail = DetailPresenter()
        /// instantiate interactor object
        let interactor: PresenterToInteractorProtocolDetail = DetailInteractor()
        /// instantiate router object
        let router:PresenterToRouterProtocolDetail = DetailRouter()
        
        /// inject view presentor
        view.presentor = presenter
        /// inject choosenUser to view
        view.choosenUser.accept(choosenUser)
        /// inject userList to view
        view.userList.accept(userArray)
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
}
