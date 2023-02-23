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
    /// Set task group for all async function on appear for ParentViewController
    /// - Parameters:
    ///     - userArray: userBodyArray sa the original Array, that's gonna be divided for the subordinate and manager
    ///     - choosenUser: selectedUserBody object from the user
    func onAppear(_ userArray: [UsersBody], _ choosenUser: UsersBody) async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            guard let self = self else { return }

            /// Split originalArray to 2 separate dataset
            /// from the given components.
            group.addTask {
                self.splitUserArray(userArray, choosenUser)
            }
        }
    }
        
    //MARK: - Split Users Array Function
    /// Split originalArray to manager and subordinate array
    /// - Parameters:
    ///     - userArray: an array of userBody that's gonna be divided into 2 dataset
    ///     - choosenUser: selectedUserObject
    func splitUserArray(_ userArray : [UsersBody], _ choosenUser : UsersBody) {
        /// Get user object position index on the originalArray
        let index = userArray.firstIndex(where: {$0.employeeID == choosenUser.employeeID}) ?? 0
        /// Intialize temporary containerArray for the managerList
        var tempManagerArray = [UsersBody]()
        /// Intialize temporary containerArray for the subordinateList
        var tempSubordinateArray = [UsersBody]()
        /// Check whether the index is on the first element or at the end of the array
        if index != 0 && index != userArray.count - 1 {
            /// append all of the manager object from index + 1 to the very last item in the original object
            for x in index+1...userArray.count - 1 {
                tempManagerArray.append(userArray[x])
            }
            /// append all of the subordinate object from the first item to the index object.
            for x in 0...index - 1 {
                tempSubordinateArray.append(userArray[x])
            }
        }else {
            ///if the selected object at the first index
            if index == 0 {
                /// append userObject from index 1 to the last as the managerArray
                for x in 1...userArray.count - 1 {
                    tempManagerArray.append(userArray[x])
                }
            }else {
                /// append userObject from index 0 to the last-1 as the subordinateArray
                for x in 0...userArray.count - 2 {
                    tempSubordinateArray.append(userArray[x])
                }
            }
        }
        /// notify presenter to pass back the computedManger Array
        presenter?.noticeManagersSuccess(tempManagerArray)
        /// notify presenter to pass back the computedSubordinate Array
        presenter?.noticeSubordinatesSuccess(tempSubordinateArray)
    }
}

