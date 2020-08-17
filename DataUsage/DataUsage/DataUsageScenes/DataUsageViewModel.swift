//
//  DataUsageViewModel.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation


protocol BaseViewModel: class {
    func doSomethingOnViewDidLoad()
    func getScreenTitle() -> String
}

protocol DataUsageViewModelOutputProtocol: class {
    func presentData()
    func showError(message: String)
    func reloadImageViewCell(section:Int,row : Int)
    func showActivityIndicator()
    func dismissActivityIndicator()
}

protocol DataUsageViewModelInputProtocol: BaseViewModel {
    
    var delegate: DataUsageViewModelOutputProtocol? { get set }
    
    func getNumberOfSection() -> Int
    func getNumberOfRow() -> Int
    func getHeaderData() -> (String,String)
    func yearlyData(index: Int) -> (String,String,String?)
    func getImageStatus(index: Int) -> (Bool,Bool)
    func changeImageStatus(section: Int,row : Int)
}

class DataUsageViewModel
{
    weak var delegate: DataUsageViewModelOutputProtocol?
    
    
}


extension DataUsageViewModel : DataUsageViewModelInputProtocol
{
    func doSomethingOnViewDidLoad() {
        delegate?.showActivityIndicator()
    }
       
    func getScreenTitle() -> String {
        return "Data Usage"
    }
    
    func getNumberOfSection() -> Int {
        return 1
    }
    
    func getNumberOfRow() -> Int {
        return 10
    }
    func getHeaderData() -> (String,String){
        return ("Year","Total data Usage")
    }
    
    func yearlyData(index: Int) -> (String, String, String?) {
        return ("Test","2.2222","This year data Usage get decrease")
    }
    func getImageStatus(index: Int) -> (Bool,Bool) {
        return (false,false)
    }
    
    func changeImageStatus(section: Int,row : Int)
    {
        delegate?.reloadImageViewCell(section: section, row: row)
    }
}
