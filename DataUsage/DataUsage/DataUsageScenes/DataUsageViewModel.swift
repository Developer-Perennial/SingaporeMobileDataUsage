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
    private var yearlyDataUsage = [YearlyDataUsage]()
    private var nwService = DataUsageNetworkService()
    
    public func assignYearlyData(dataUsageRecords : [Records]?)
    {
        guard let dataUsage = dataUsageRecords else {return}
        
        var data: [String: [Records]] = [ : ]
        
        for record in dataUsage {
            let yearQuarter = record.quarter?.components(separatedBy: "-")
            var quartersData = data[yearQuarter?.first ?? ""] ?? [Records]()
            quartersData.append(Records(id: record.id, name: yearQuarter?.last,dataUdage: record.volume_of_mobile_data))
            data[yearQuarter!.first!] = quartersData
        }
        
        for (year, quarters) in data {
            yearlyDataUsage.append(createYearsData(name: year, quarters: quarters))
        }
        yearlyDataUsage.sort { (y1, y2) -> Bool in
            return y1.name! > y2.name!
        }
    }
    
    private func createYearsData(name : String,quarters : [Records]) -> YearlyDataUsage
    {
        let yealyDataUsage =  quarters.reduce(0.0) { (result : Double,record : Records) -> Double in
            guard let valume_of_data = record.volume_of_mobile_data, let dataUsage = Double(valume_of_data) else{ return result}
            return result + dataUsage
        }
        var isDataDecrease = false
        var previousValume = 0.0
        for record in  quarters
        {
            let dataUsage = Double(record.volume_of_mobile_data ?? "0.0") ?? 0.0
            if previousValume > dataUsage{
                isDataDecrease = true
                break
            }
            previousValume = dataUsage
        }
        return YearlyDataUsage(name: name, usedData: yealyDataUsage, isDecresedData: isDataDecrease, isMessageVisiable: false)
    }
}


extension DataUsageViewModel : DataUsageViewModelInputProtocol
{
    func doSomethingOnViewDidLoad() {
        
        delegate?.showActivityIndicator()
        let requestDTO = DataUsageRequestDTO(resourceId: Configuration.resourceID, limit: 500)
        
        let param = Helper.getJSONObject(obj:requestDTO)
        nwService.request(url: ApiPath.MOBILE_DATA_USAGE, method: .get, parameters: param, headers: [:], uRLEncoding: .default) { (result: Result<DataUsageResponseDTO, APIError>) in
            self.delegate?.dismissActivityIndicator()

            switch result {
            case .success(let model):
                self.assignYearlyData(dataUsageRecords: model.result?.records)
                self.delegate?.presentData()
            case .failure(let error):
                self.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
        
        func getScreenTitle() -> String {
            return "Data Usage"
        }
        
        func getNumberOfSection() -> Int {
            return 1
        }
        
        func getNumberOfRow() -> Int {
            return yearlyDataUsage.count
        }
        func getHeaderData() -> (String,String){
            return ("Year","Total data Usage")
        }
        
        func yearlyData(index: Int) -> (String, String, String?) {
            let yearlyInfo = yearlyDataUsage[index]
            let dataUsage = String(format: "%.6f", yearlyInfo.usedData ?? 0.0)
            return (yearlyInfo.name!,dataUsage,"This year data Usage get decrease")
        }
        func getImageStatus(index: Int) -> (Bool,Bool) {
            let yearlyInfo = yearlyDataUsage[index]
            return (yearlyInfo.isDecresedData,yearlyInfo.isMessageVisiable)
        }
        
        func changeImageStatus(section: Int,row : Int)
        {
            yearlyDataUsage[row].changeMessageVisiableStatus()
            delegate?.reloadImageViewCell(section: section, row: row)
        }
}
