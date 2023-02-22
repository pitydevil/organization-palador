//
//  HomeIntractor.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import RxCocoa
import RxSwift

class HomeInteractor : PresenterToInteractorProtocol {

    //MARK: - OBJECT DECLARATION
    private let networkService    : NetworkServicing
    var presenter: InteractorToPresenterProtocol?
//    let discoverMoviesArrayObject   = BehaviorRelay<[Movies]>(value: [])

    //MARK: - INIT OBJECT DECLARATION
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: - OnAppear Function
    /// Set task group for all async function on appear for detailViewController
    func onAppear() async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            guard let self = self else { return }
            
            /// Fetch Upcoming Movie from endpoint
            /// from the given components.
            group.addTask { [self] in
//                await self.fetchMovies(genreObject, false)
            }
            
            /// Fetch Top Rated  Movie from endpoint
            /// from the given components.
            group.addTask { [self] in
//                await self.fetchGenres()
            }
        }
    }
    
    //MARK: - Fetch Genres
    /// Fetch Genres
    /// from given components.
//    func fetchGenres() async {
//        let endpoint = ApplicationEndpoint<Any>.getGenres
//        let result = await networkService.request(to: endpoint, decodeTo: Genre.self)
//        switch result {
//        case .success(let response):
//            self.presenter?.noticeFetchGenresSuccess(response.genres)
//        case .failure(_):
//            self.presenter?.noticeFetchFailed()
//        }
//    }
    
//    //MARK: - Fetch Movies
//    /// Fetch Movies
//    /// from given components.
//    /// - Parameters:
//    ///     - enumState: movie type that's gonan be passed onto the fetch movie endpoint
//    func fetchMovies(_ genreObject: GenreBody,_ resetArgs : Bool) async{
//        let endpoint = ApplicationEndpoint.getDiscover(genreObject)
//        let result = await networkService.request(to: endpoint, decodeTo: Response<[Movies]>.self)
//        switch result {
//        case .success(let response):
//            if let movies = response.results {
//                if resetArgs {
//                    discoverMoviesArrayObject.accept([])
//                }
//                var appendedMovies = discoverMoviesArrayObject.value
//                appendedMovies.append(contentsOf: movies)
//                discoverMoviesArrayObject.accept(appendedMovies)
//                self.presenter?.notifeFetchMoviesSuccess(appendedMovies)
//            }
//        case .failure(_):
//            self.presenter?.noticeFetchFailed()
//        }
//    }
}

