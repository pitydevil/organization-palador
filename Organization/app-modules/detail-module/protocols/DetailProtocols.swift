//
//  DetailProtocols.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import UIKit

//MARK: - View To Presenter Protocol
/// Pass view request and object to the presenter
protocol ViewToPresenterProtocolDetail: AnyObject{
    /// presenterToViewProtocol Object
    var view: PresenterToViewProtocolDetail? {get set}
    /// presenterToInteractor Object
    var interactor: PresenterToInteractorProtocolDetail? {get set}
    /// presenterToRouter Object
    var router: PresenterToRouterProtocolDetail? {get set}
    /// onAppear Function to pass call from View to Presenter
    func onAppear(_ userArray : [UsersBody], _ choosenUser : UsersBody) async
}

//MARK: - Presenter To View Protocol
/// Pass presenter request and object to the view
protocol PresenterToViewProtocolDetail: AnyObject{
    /// pass showManagers from presenter call to view
    func showManagers(_ userArray: [UsersBody])
    /// pass showSubordinates from presenter call to view
    func showSubordinates(_ userArray : [UsersBody])
    /// pass showError from presenter call to view
    func showError()
}

//MARK: - Presenter To Router Protocol
/// Pass presenter request and object to router
protocol PresenterToRouterProtocolDetail: AnyObject {
    /// instantiate detailViewController and inject userArray and choosenUser object
    static func createModule(_ userArray : [UsersBody], _ choosenUser : UsersBody) -> DetailViewController
}

//MARK: - Presenter To Interactor Protocol
/// Pass presenter to interactor request and object
protocol PresenterToInteractorProtocolDetail: AnyObject {
    /// interactorToPresenterObject
    var presenter:InteractorToPresenterProtocolDetail? {get set}
    /// pass onAppear call from presenter to interactor
    func onAppear(_ userArray : [UsersBody], _ choosenUser : UsersBody) async
}

//MARK: - Interactor to presenter Protocol
/// pass interactor to presenter request and object
protocol InteractorToPresenterProtocolDetail: AnyObject {
    /// pass managerArray to the presenter from interactor
    func noticeManagersSuccess(_ userArray : [UsersBody])
    /// pass subordinateArray to the presenter from interactor
    func noticeSubordinatesSuccess(_ userArray: [UsersBody])
    /// pass failedNotice to the presenter from interactor
    func noticeFetchFailed()
}
