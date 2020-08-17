//
//  ViewController.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import UIKit

struct NibNames
{
    static let TABLE_VIEW_CELL = "DataUsageTableViewCell"
    static let TABLE_VIEW_SECTION_HEADER = "SectionHeaderView"
}

class DataUsageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : DataUsageViewModelInputProtocol = DataUsageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableNib()
        viewModel.delegate = self
        viewModel.doSomethingOnViewDidLoad()
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        self.navigationItem.title = viewModel.getScreenTitle()
    }
    
    private func registerTableNib() {
        tableView.register(UINib(nibName: NibNames.TABLE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: NibNames.TABLE_VIEW_CELL)
        tableView.register(UINib(nibName: NibNames.TABLE_VIEW_SECTION_HEADER, bundle: nil), forHeaderFooterViewReuseIdentifier: NibNames.TABLE_VIEW_SECTION_HEADER)
    }
}

extension DataUsageViewController : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSection()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : SectionHeaderView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: NibNames.TABLE_VIEW_SECTION_HEADER) as? SectionHeaderView ?? SectionHeaderView(reuseIdentifier: NibNames.TABLE_VIEW_SECTION_HEADER)
        
        let headerInfo = viewModel.getHeaderData()
        headerView.configureHeader(title: headerInfo.0, valueTitle:headerInfo.1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: NibNames.TABLE_VIEW_CELL) as? DataUsageTableViewCell ??
            DataUsageTableViewCell(style: .default, reuseIdentifier: NibNames.TABLE_VIEW_CELL)
        
        let cellData = viewModel.yearlyData(index: indexPath.row)
        let imageStatus = viewModel.getImageStatus(index: indexPath.row)
        cell.setYearData(name: cellData.0, dataUsage: cellData.1, messge: cellData.2)
        cell.setupClickableImage(isClickable: imageStatus.0, isExpanded: imageStatus.1)
        cell.delegate = self
        return cell
    }
}

extension DataUsageViewController : DataUsageViewModelOutputProtocol
{
    func presentData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {

    }
    
    func showActivityIndicator() {
    }
    
    func dismissActivityIndicator() {
        
    }
    
    func reloadImageViewCell(section: Int, row: Int) {
        let indexPath = IndexPath(row: row, section: section)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension DataUsageViewController : DataUsageTableViewCellDelegate
{
    func imageViewClicked(cell: DataUsageTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return}
        viewModel.changeImageStatus(section: indexPath.section, row: indexPath.row)
    }
}
