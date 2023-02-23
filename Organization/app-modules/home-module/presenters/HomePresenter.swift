//
//  HomePresenter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import Foundation

class HomePresenter : ViewToPresenterProtocol {

    /// initialize presenterToViewObject for the ViewController
    var view: PresenterToViewProtocol?
    /// initialize presenterToInteractor object
    var interactor: PresenterToInteractorProtocol?
    /// initialize router object for the parentViewController
    var router: PresenterToRouterProtocol?
    
    //MARK: - onAppear Function
    /// Notify interactor to execute the onAppear Function
    func onAppear() async {
        await interactor?.onAppear()
    }
    
    //MARK: - onSearch Function
    /// Notify interactor to execute onSearch Function
    /// - Parameters:
    ///     - userArray: original datasource array for the tableView
    ///     - searchText: user's written text on the searchBar
    func onSearch(_ userArray: [[UsersBody]], _ searchText: String) {
        interactor?.onSearch(userArray, searchText)
    }
    
    //MARK: - showDetailController Function
    /// Notify router to execute pushDetailScreen function
    /// - Parameters:
    ///     - navigationController: current navigation controller object
    ///     - userArray: array of user selected userBodyObject
    ///     - userObject: user's selected userBodyObject
    func showDetailController(_ navigationController: NavigationController, _ userArray: [UsersBody], _ userObject: UsersBody) {
        router?.pushToDetailScreen(navigationController, userArray, userObject)
    }
}

//MARK: InteractorToPresenterProtocol
extension HomePresenter: InteractorToPresenterProtocol{
    
    //MARK: - noticeSearchSuccess Function
    /// Notify view to execute showSearch function
    /// - Parameters:
    ///     - userArray: array of user selected userBodyObject
    func noticeSearchSuccess(_ userArray: [[UsersBody]]) {
        view?.showSearch(userArray)
    }
    
    //MARK: - noticeUsersSuccess Function
    /// Notify view show the userArray object from the interactor
    /// - Parameters:
    ///     - userArray: array of fetched userArray from the endpoint.
    func noticeUsersSuccess(_ userArray: [[UsersBody]]) {
        view?.showUsersSuccess(userArray)
    }
    
    //MARK: - Show Error from Presenter
    /// Notify view when there's something wrong with the fetching process
    func noticeFetchFailed() {
        view?.showError()
    }
}
