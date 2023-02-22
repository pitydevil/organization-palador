//
//  HomeProtocols.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit

protocol ViewToPresenterProtocol: AnyObject{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func onAppear() async
    func showDetailController(navigationController:NavigationController)
}

protocol PresenterToViewProtocol: AnyObject{
//    func showMovies(_ moviesArray:Array<Movies>)
//    func showGenres(_ genre:Array<Genres>)
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> HomeViewController
    func pushToDetailScreen(navigationConroller:NavigationController)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func onAppear() async
}

protocol InteractorToPresenterProtocol: AnyObject {
//    func notifeFetchMoviesSuccess(_ moviesArray:Array<Movies>)
    func noticeFetchFailed()
}

