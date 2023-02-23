//
//  DetailPresenter.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import Foundation

class DetailPresenter:ViewToPresenterProtocolDetail {
  
    var view: PresenterToViewProtocolDetail?
    var interactor: PresenterToInteractorProtocolDetail?
    var router: PresenterToRouterProtocolDetail?

    func onAppear(_ userArray: [UsersBody], _ choosenUser: UsersBody) async {
        await interactor?.onAppear(userArray, choosenUser)
    }
}

extension DetailPresenter: InteractorToPresenterProtocolDetail{
    func noticeManagersSuccess(_ userArray: [UsersBody]) {
        view?.showManagers(userArray)
    }
    
    func noticeSubordinatesSuccess(_ userArray: [UsersBody]) {
        view?.showSubordinates(userArray)
    }
    func noticeFetchFailed() {
        view?.showError()
    }
}
