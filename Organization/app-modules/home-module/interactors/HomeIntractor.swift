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
    /// Network Service Object for endpoint
    private let networkService    : NetworkServicing
    
    /// Presentor Object to notify interactor result to the presenter
    var presenter: InteractorToPresenterProtocol?

    //MARK: - INIT OBJECT DECLARATION
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: - OnAppear Function
    /// Set task group for all async function on appear for ParentViewController
    func onAppear() async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            guard let self = self else { return }
            /// Fetch Users from endpoint
            /// from the given components.
            group.addTask {
                await self.fetchUsers()
            }
        }
    }
    
    //MARK: - Fetch Users Function
    /// Fetch Users from endpoint
    func fetchUsers() async {
        /// Tell the network service to do getUsers Endpoint
        let endpoint = ApplicationEndpoint.getUsers
        /// Determine the endpoint query result object type and the request type.
        let result = await networkService.request(to: endpoint, decodeTo: [Users].self)
        switch result {
            case .success(let response):
                /// Call convertUser function to determine the user hierarchy function, and give back the computed result to the presenter.
                self.presenter?.noticeUsersSuccess(convertUsers(response))
            case .failure(_):
                /// Tell the presenter the endpoint fetching function has encountered a problem
                self.presenter?.noticeFetchFailed()
        }
    }
    
    //MARK: - Convert Users to User Hierarchy Function
    /// Determine user's hierarchy
    /// - Parameters:
    ///     - user1DArray: user1DArray as the result from the endpoint
    /// - Returns:
    ///     - user2DArray: a 2d array of user that already contains the organization hierarchy
    private func convertUsers(_ user1DArray : [Users]) -> ([[UsersBody]]){
        /// Initialize empty2D array for the computed result
        var users2DArray = [[UsersBody]]()
        
        /// for loop as many as the user1DArray count
        for item in user1DArray {
            /// Convert the users object into userBody object so we can mark which object is the head.
            let customObject = UsersBody(employeeID: item.employeeID, name: item.name, managerID: item.managerID, isHead: true)
            /// Intialialize temporary1DObject to accomodate temporary computed object
            var tempUser1DArray = [UsersBody]()
            /// Initialize temporaryLoopObject as the main pointer for the while function
            var tempLoopObject = customObject
            /// append the initial pointer to the computed1DArray
            tempUser1DArray.append(customObject)
            
            /// Figure out the organization structure for it's object
            while(true) {
                /// check whether the tempLoopObject has a managerID or not
                if tempLoopObject.managerID != nil {
                    /// find userBody object where it's employeeID Equals to the currentLoopObject EmployeeID
                    let index = user1DArray.firstIndex(where: {$0.employeeID == tempLoopObject.managerID}) ?? 0
                    
                    /// Initialize user body object to be appended to the temp1DArray and act as the next succesor for the currentLoopObject
                    tempLoopObject = UsersBody(employeeID: user1DArray[index].employeeID, name: user1DArray[index].name, managerID: user1DArray[index].managerID, isHead: false)
                    /// append the tempLoopObject to our temporaryUser1DObject
                    tempUser1DArray.append(tempLoopObject)
                }else {
                    /// append the temporary1DUserArray to the finalUser2DArray object.
                    users2DArray.append(tempUser1DArray)
                    break
                }
            }
        }
        return users2DArray
    }
    
    //MARK: - onSearch Function
    /// Return filteredUserBody Array based on the searchText from the searchBarObject
    /// - Parameters:
    ///     - userArray: original copy of the 2DUserBody tableView datasource array
    ///     - searchText: writtenText from the user hand typing text on the searchBar
    func onSearch(_ userArray: [[UsersBody]], _ searchText : String) {
        /// initialize temp2DArray result as the container for the computed filtered array.
        var tempResult = [[UsersBody]]()
        
        /// for loop as many the userArray so we can find every posibilies in the datasource Array
        for item in userArray {
            /// find the userBody object that matches the user's written text, and  query the head of the array as our primary query.
            let usersBodyHead = item.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) && $0.isHead == true
            }

            /// check whether userBodyHeadArray is nil or not.
            if !usersBodyHead.isEmpty {
                /// get the rest of the user object organization based on the filtered primaryObject.
                for item in usersBodyHead {
                    if let index = userArray.firstIndex(where: {$0.first?.name ==  item.name}) {
                        /// append the matched object to the temporary2DResultarray
                        tempResult.append(userArray[index])
                    }
                }
            }
            /// give back the filteredResult to the presenter.
            presenter?.noticeSearchSuccess(tempResult)
        }
    }
}
