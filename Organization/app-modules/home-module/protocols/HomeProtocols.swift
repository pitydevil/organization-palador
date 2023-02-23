//
//  HomeProtocols.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit

//MARK: - PassBackTableViewCell Protocol
/// Pass parentTableViewCell tableView to the parentViewController
/// - Parameters:
///     - userArray: an Array of current selected user
///     - userObject: choosen User Object from the userArray
protocol PassBackTableViewCellObject {
    func passBackTableViewCellObject(_ userArray : [UsersBody], _ userObject: UsersBody)
}

//MARK: - View To Presenter Protocol
/// Pass view request and object to the presenter
protocol ViewToPresenterProtocol: AnyObject{
    /// presenterToViewProtocol Object
    var view: PresenterToViewProtocol? {get set}
    /// presenterToInteractor Object
    var interactor: PresenterToInteractorProtocol? {get set}
    /// presenterToRouter Object
    var router: PresenterToRouterProtocol? {get set}
    /// onAppear Function to pass call from View to Presenter
    func onAppear() async
    /// pass onSearch call function to the interactor
    func onSearch(_ userArray : [[UsersBody]], _ searchText : String)
    /// pass showDetailFunction call to the router
    func showDetailController(_ navigationController:NavigationController, _ userArray : [UsersBody], _ userObject: UsersBody)
}

//MARK: - Presenter To View Protocol
/// Pass presenter request and object to the view
protocol PresenterToViewProtocol: AnyObject{
    /// pass showUsersSuccess from presenter call to view
    func showUsersSuccess(_ userArray: [[UsersBody]])
    /// pass showSearch from presenter call to view
    func showSearch(_ userArray : [[UsersBody]])
    /// pass showError from presenter call to view
    func showError()
}

//MARK: - Presenter To Router Protocol
/// Pass presenter request and object to router
protocol PresenterToRouterProtocol: AnyObject {
    /// instantiate parentTableViewController
    static func createModule() -> ParentTableViewController
    /// pass pushToDetail Function from presenter to router
    func pushToDetailScreen(_ navigationConroller:NavigationController, _ userArray : [UsersBody], _ userObject: UsersBody)
}

//MARK: - Presenter To Interactor Protocol
/// Pass presenter to interactor request and object
protocol PresenterToInteractorProtocol: AnyObject {
    /// interactorToPresenterObject
    var presenter:InteractorToPresenterProtocol? {get set}
    /// pass onAppear call from presenter to interactor
    func onAppear() async
    /// pass onSearch call from presenter to interactor
    func onSearch(_ userArray : [[UsersBody]], _ searchText : String)
}

//MARK: - Interactor to presenter Protocol
/// pass interactor to presenter request and object
protocol InteractorToPresenterProtocol: AnyObject {
    /// pass userSuccess call from presenter to interactor
    func noticeUsersSuccess(_ userArray : [[UsersBody]])
    /// pass searchSuccess to the presenter from interactor
    func noticeSearchSuccess(_ userArray: [[UsersBody]])
    /// pass failedNotice to the presenter from interactor
    func noticeFetchFailed()
}
