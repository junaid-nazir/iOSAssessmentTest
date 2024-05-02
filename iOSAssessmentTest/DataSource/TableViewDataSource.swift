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
}
class TableViewDataSource: NSObject {
    
    var jsonResponseViewModel: JsonResponseViewModel?
    weak var delegate: TableViewDataSourceDelegate?
    // MARK: - Initializer
    init(_ data: JsonResponseViewModel) {
        jsonResponseViewModel = data
    }
}

// MARK: - UITableView DataSource and Delegate
extension TableViewDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonResponseViewModel?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
        
        if let data = jsonResponseViewModel?.response?[indexPath.row] {
        cell.configureCell(data: data)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = jsonResponseViewModel?.response?[indexPath.row] {
            delegate?.navigateToVC(data: data)
        }
    }
}
