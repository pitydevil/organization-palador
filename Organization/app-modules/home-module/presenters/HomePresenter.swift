//
//  HomePresenter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import Foundation

class HomePresenter:ViewToPresenterProtocol {

    
  
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func onAppear() async {
        await interactor?.onAppear()
    }
    
    func onSearch(_ userArray: [[UsersBody]], _ searchText: String) {
        interactor?.onSearch(userArray, searchText)
    }
    
    func showDetailController(_ navigationController: NavigationController, _ userArray: [UsersBody], _ userObject: UsersBody) {
        router?.pushToDetailScreen(navigationController, userArray, userObject)
    }
}

extension HomePresenter: InteractorToPresenterProtocol{
    func noticeSearchSuccess(_ userArray: [[UsersBody]]) {
        view?.showSearch(userArray)
    }
    
    func noticeUsersSuccess(_ userArray: [[UsersBody]]) {
        view?.showUsersSuccess(userArray)
    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
}
