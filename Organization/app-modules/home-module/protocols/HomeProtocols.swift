//
//  HomeProtocols.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit

protocol PassBackTableViewCellObject {
    func passBackTableViewCellObject(_ userArray : [UsersBody], _ userObject: UsersBody)
}

protocol ViewToPresenterProtocol: AnyObject{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func onAppear() async
    func onSearch(_ userArray : [[UsersBody]], _ searchText : String)
    func showDetailController(_ navigationController:NavigationController, _ userArray : [UsersBody], _ userObject: UsersBody)
}

protocol PresenterToViewProtocol: AnyObject{
    func showUsersSuccess(_ userArray: [[UsersBody]])
    func showSearch(_ userArray : [[UsersBody]])
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> ParentTableViewController
    func pushToDetailScreen(_ navigationConroller:NavigationController, _ userArray : [UsersBody], _ userObject: UsersBody)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func onAppear() async
    func onSearch(_ userArray : [[UsersBody]], _ searchText : String)
}

protocol InteractorToPresenterProtocol: AnyObject {
    func noticeUsersSuccess(_ userArray : [[UsersBody]])
    func noticeSearchSuccess(_ userArray: [[UsersBody]])
    func noticeFetchFailed()
}

