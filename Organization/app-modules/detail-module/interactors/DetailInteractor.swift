//
//  DetailInteractor.swift
//  Organization
//
//  Created by Mikhael Adiputra on 23/02/23.
//

import RxCocoa
import RxSwift

class DetailInteractor : PresenterToInteractorProtocolDetail {
    
    //MARK: - Object Declaration
    var presenter: InteractorToPresenterProtocolDetail?
    
    //MARK: - OnAppear Function
    /// Fetch Users from endpoint
    /// - Parameters:
    ///     - user1DArray: movie type that's gonan be passed onto the fetch movie endpoint
    func onAppear(_ userArray: [UsersBody], _ choosenUser: UsersBody) async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            guard let self = self else { return }

            /// Fetch Usersfrom endpoint
            /// from the given components.
            group.addTask {
                self.splitUserArray(userArray, choosenUser)
            }
        }
    }
        
    //MARK: - Split Users Array Function
    /// Fetch Users from endpoint
    /// - Parameters:
    ///     - user1DArray: movie type that's gonan be passed onto the fetch movie endpoint
    func splitUserArray(_ userArray : [UsersBody], _ choosenUser : UsersBody) {
        let index = userArray.firstIndex(where: {$0.employeeID == choosenUser.employeeID}) ?? 0
        var tempManagerArray = [UsersBody]()
        var tempSubordinateArray = [UsersBody]()
        if index != 0 && index != userArray.count - 1 {
            for x in index+1...userArray.count - 1 {
                tempManagerArray.append(userArray[x])
            }
            
            for x in 0...index - 1 {
                tempSubordinateArray.append(userArray[x])
            }
            presenter?.noticeManagersSuccess(tempManagerArray)
            presenter?.noticeSubordinatesSuccess(tempSubordinateArray)
        }else {
            if index == 0 {
                for x in 1...userArray.count - 1 {
                    tempManagerArray.append(userArray[x])
                }
            }else {
                for x in 0...userArray.count - 2 {
                    tempSubordinateArray.append(userArray[x])
                }
            }
            presenter?.noticeManagersSuccess(tempManagerArray)
            presenter?.noticeSubordinatesSuccess(tempSubordinateArray)
        }
    }
}

