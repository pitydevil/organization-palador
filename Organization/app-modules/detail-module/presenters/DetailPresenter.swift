//
//  DetailPresenter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import Foundation

class DetailPresenter : ViewToPresenterProtocolDetail {
    /// initialize presenterToViewProtocolDetail for the ViewController
    var view: PresenterToViewProtocolDetail?
    /// initialize presenterToInteractoDetailr object
    var interactor: PresenterToInteractorProtocolDetail?
    /// initialize router object for the DetailViewController
    var router: PresenterToRouterProtocolDetail?

    //MARK: - onAppear Function
    /// Notify interactor to execute onAppear Function
    /// - Parameters:
    ///     - userArray: original datasource array for the tableView
    ///     - choosenUser: selected user on the parentViewController
    func onAppear(_ userArray: [UsersBody], _ choosenUser: UsersBody) async {
        await interactor?.onAppear(userArray, choosenUser)
    }
}

//MARK: InteractorToPresenterProtocolDetail
extension DetailPresenter: InteractorToPresenterProtocolDetail{
    
    //MARK: - noticeManagersSuccess Function
    /// Notify view to execute showManagers function
    /// - Parameters:
    ///     - userArray: array of user selected userBodyObject
    func noticeManagersSuccess(_ userArray: [UsersBody]) {
        view?.showManagers(userArray)
    }
    
    //MARK: - noticeSubordinatesSuccess Function
    /// Notify view to execute showSubordinates function
    /// - Parameters:
    ///     - userArray: array of user selected userBodyObject
    func noticeSubordinatesSuccess(_ userArray: [UsersBody]) {
        view?.showSubordinates(userArray)
    }
    
    //MARK: - Show Error from Presenter
    /// Notify view when there's something wrong with the fetching process
    func noticeFetchFailed() {
        view?.showError()
    }
}
