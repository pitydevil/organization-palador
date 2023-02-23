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
    /// Set task group for all async function on appear for detailViewController
    func onAppear(_ userArray: [UsersBody], _ choosenUser: UsersBody) async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            guard let self = self else { return }

            /// Fetch Usersfrom endpoint
            /// from the given components.
            group.addTask { [self] in
//                await self.fetchUsers()
            }
        }
    }
        
//    //MARK: - Fetch Users Function
//    /// Fetch Users from endpoint
//    func fetchUsers() async {
//        let endpoint = ApplicationEndpoint.getUsers
//        let result = await networkService.request(to: endpoint, decodeTo: [Users].self)
//        switch result {
//        case .success(let response):
//            self.presenter?.noticeUsersSuccess(convertUsers(response))
//        case .failure(_):
//            self.presenter?.noticeFetchFailed()
//        }
//    }
    
    //MARK: - Convert Users to User Hierarchy Function
    /// Return result argument whether scrollview is already the bottom or not
    /// - Parameters:
    ///     - user1DArray: movie type that's gonan be passed onto the fetch movie endpoint
    /// - Returns:
    ///     - enumState: movie type that's gonan be passed onto the fetch movie endpoint
//    private func convertUsers(_ user1DArray : [Users]) -> ([[UsersBody]]){
//        var users2DArray = [[UsersBody]]()
//        for item in user1DArray {
//            let customObject = UsersBody(employeeID: item.employeeID, name: item.name, managerID: item.managerID, isHead: true)
//            var tempUser1DArray = [UsersBody]()
//            var tempLoopObject = customObject
//            tempUser1DArray.append(customObject)
//            while(true) {
//                if tempLoopObject.managerID != nil {
//                    let index = user1DArray.firstIndex(where: {$0.employeeID == tempLoopObject.managerID}) ?? 0
//                    tempLoopObject = UsersBody(employeeID: user1DArray[index].employeeID, name: user1DArray[index].name, managerID: user1DArray[index].managerID, isHead: false)
//                    tempUser1DArray.append(tempLoopObject)
//                }else {
//                    users2DArray.append(tempUser1DArray)
//                    break
//                }
//            }
//        }
//        return users2DArray
//    }
//
//    //MARK: - Convert Users to User Hierarchy Function
//    /// Return result argument whether scrollview is already the bottom or not
//    /// - Parameters:
//    ///     - user1DArray: movie type that's gonan be passed onto the fetch movie endpoint
//    func onSearch(_ userArray: [[UsersBody]], _ searchText : String) {
//        var tempResult = [[UsersBody]]()
//        for item in userArray {
//            let usersBodyHead = item.filter {
//                $0.name.localizedCaseInsensitiveContains(searchText) && $0.isHead == true
//            }
//
//            if !usersBodyHead.isEmpty {
//                for item in usersBodyHead {
//                    if let index = userArray.firstIndex(where: {$0.first?.name ==  item.name}) {
//                        tempResult.append(userArray[index])
//                    }
//                }
//            }
//            presenter?.noticeSearchSuccess(tempResult)
//        }
//    }
}

