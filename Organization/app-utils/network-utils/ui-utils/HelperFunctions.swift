//
//  HelperFunctions.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import UIKit

//MARK: - Segue To Main Function
/// Change UIStoryBoard to main programatically
public func segueToMain() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController =  storyboard.instantiateViewController(withIdentifier: "mainTabbar")
    viewController.modalPresentationStyle = .fullScreen
    return viewController
}

//MARK: - Generic Alert Function
/// Returns UIAlert Controller with given parameter
/// - Parameters:
///     - titlAlert: title alert text for the UIAlertController Title
///     - messageAlert: message alert text for the UIAlertController messageText
///     - buttonText:  button text for the UIAlertController button text
public func genericAlert(titleAlert : String, messageAlert : String, buttonText : String) -> UIAlertController {
    let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
    let cancel = UIAlertAction(title: buttonText, style: .cancel)
    alert.addAction(cancel)
    return alert
}

//MARK: - Change Date Object into String Function
/// Returns string date in dd MMM YYYY format
/// from the given components.
/// - Parameters:
///     - Date: date object that's gonna be converted to string
public func changeDateIntoStringDate(Date : Date) -> String {
    let dateF = DateFormatter()
    dateF.dateFormat = "dd MMM yyyy"
    return dateF.string(from: Date)
}

//MARK: - Change Date Into DD MM
/// Returns string date in dd MMM YYYY format
/// from the given components.
/// - Parameters:
///     - Date: date object that's gonna be converted to string
public func changeDateIntoDDMM(_ Date : Date) -> String {
    let dateF = DateFormatter()
    dateF.dateFormat = "dd MMM"
    return dateF.string(from: Date)
}

//MARK: - Change Date Into DD MM
/// Returns string date in dd MMM YYYY format
/// from the given components.
/// - Parameters:
///     - Date: date object that's gonna be converted to string
public func createTodayObject() -> String{
    let date = Date()
    let dateF = DateFormatter()
    dateF.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateF.string(from: date)
}

//MARK: - Change String Into Date
/// Returns string date in dd MMM YYYY format
/// from the given components.
/// - Parameters:
///     - DateString: string that's converted to date
public func changeDateFromString(dateString : String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let pastDateInvoice: Date? = dateFormatter.date(from: dateString)
    return pastDateInvoice!
}

//MARK: - Error Alert Function
/// Returns Error UIAlert Controller
public func errorAlert() -> UIAlertController {
    let alert = UIAlertController(title: "Reactive Unexpected Error", message: "Please try again later", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Ok", style: .cancel)
    alert.addAction(cancel)
    return alert
}

//MARK: - Error Server Alert Function
/// Returns Error Server UIAlert Controller
public func errorServerAlert() -> UIAlertController {
    let alert = UIAlertController(title: "Telah terjadi kesalahan pada server!", message: "Silahkan coba beberapa saat lagi.", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Ok", style: .cancel)
    alert.addAction(cancel)
    return alert
}
