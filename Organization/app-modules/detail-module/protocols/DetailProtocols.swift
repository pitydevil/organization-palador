//
//  DetailProtocols.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import UIKit

protocol ViewToPresenterProtocolDetail: AnyObject{
    var view: PresenterToViewProtocolDetail? {get set}
    var interactor: PresenterToInteractorProtocolDetail? {get set}
    var router: PresenterToRouterProtocolDetail? {get set}
    func onAppear(_ userArray : [UsersBody], _ choosenUser : UsersBody) async
}

protocol PresenterToViewProtocolDetail: AnyObject{
    func showManagers(_ userArray: [UsersBody])
    func showSubordinates(_ userArray : [UsersBody])
    func showError()
}

protocol PresenterToRouterProtocolDetail: AnyObject {
    static func createModule(_ userArray : [UsersBody], _ choosenUser : UsersBody) -> DetailViewController
}

protocol PresenterToInteractorProtocolDetail: AnyObject {
    var presenter:InteractorToPresenterProtocolDetail? {get set}
    func onAppear(_ userArray : [UsersBody], _ choosenUser : UsersBody) async
}

protocol InteractorToPresenterProtocolDetail: AnyObject {
    func noticeManagersSuccess(_ userArray : [UsersBody])
    func noticeSubordinatesSuccess(_ userArray: [UsersBody])
    func noticeFetchFailed()
}
