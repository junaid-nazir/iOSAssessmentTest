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
    func reloadData()
}
class TableViewDataSource: NSObject, JsonResponseViewModelDelegate {

    var jsonResponseViewModel: JsonResponseViewModel?
    weak var delegate: TableViewDataSourceDelegate?
    var limit = 20
    var index = 0
    var totalItems = 0
    var newData: [JsonResponseModel] = []
    var isLoadingData = false
    // MARK: - Initializer
    init(_ data: JsonResponseViewModel) {
        super.init()
        jsonResponseViewModel = data
        jsonResponseViewModel?.delegate = self
    }
    
    
    func loadNextPage() {
        while index < limit {
            if let data = jsonResponseViewModel?.allData[index] {
                newData.append(data)
                index = index + 1
            }
        }
        loadTable()
    }
    
    func loadTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.reloadData()
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
        // If user scrolls to the bottom, load next page
        if indexPath.row == newData.count - 1 {
            let index = newData.count - 1
            if index+20 > (jsonResponseViewModel?.allData.count ?? 0) {
                limit = (jsonResponseViewModel?.allData.count ?? 0)
            } else {
                limit = index +  20
            }
            loadNextPage()
        }
    }
}
