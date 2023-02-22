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
    
    func showDetailController(navigationController: NavigationController) {
//        router?.pushToDetailScreen(navigationConroller: navigationController, movieIdObject: movieIdObject)
        router?.pushToDetailScreen(navigationConroller: navigationController)
    }
}

extension HomePresenter: InteractorToPresenterProtocol{
   
//    func notifeFetchMoviesSuccess(_ moviesArray: Array<Movies>) {
//        view?.showMovies(moviesArray)
//    }
//
//    func noticeFetchGenresSuccess(_ genresArray: [Genres]) {
//        view?.showGenres(genresArray)
//    }
//
//    func noticeScrollViewPosition(_ result: Bool) {
//        view?.showScrollViewPosition(result)
//    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
}
