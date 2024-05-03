//
//  TableViewDataSource.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import Foundation
import UIKit

protocol TableViewDataSourceDelegate: AnyObject {
    func navigateToVC(data: JsonResponseModel)
    func fecthNextPageRecords()
}
class TableViewDataSource: NSObject, JsonResponseViewModelDelegate {
    var jsonResponseViewModel: JsonResponseViewModel?
    weak var delegate: TableViewDataSourceDelegate?
    var newData: [JsonResponseModel] = []
    // MARK: - Initializer
    init(_ data: JsonResponseViewModel) {
        super.init()
        jsonResponseViewModel = data
        jsonResponseViewModel?.delegate = self
    }
    
    
    func loadNextPage() {
        if let unwrappedModels = jsonResponseViewModel {
            for item in unwrappedModels.allData {
                newData.append(item)
            }
        }
    }
}

// MARK: - UITableView DataSource and Delegate
extension TableViewDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
        let data = newData[indexPath.row]
        cell.configureCell(data: data)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = jsonResponseViewModel?.allData[indexPath.row] {
            delegate?.navigateToVC(data: data)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newData.count - 1 {
            delegate?.fecthNextPageRecords()
        }
    }
}
