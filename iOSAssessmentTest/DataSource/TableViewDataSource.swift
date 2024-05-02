//
//  TableViewDataSource.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject {
    
    var jsonResponseViewModel: JsonResponseViewModel?
    // MARK: - Initializer
    init(_ data: JsonResponseViewModel) {
        jsonResponseViewModel = data
    }
}

// MARK: - UITableView DataSource and Delegate
extension TableViewDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
