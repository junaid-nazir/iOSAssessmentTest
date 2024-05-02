//
//  JsonResponseViewModel.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import Foundation
protocol JsonResponseViewModelDelegate: AnyObject {
    func loadNextPage()
}
class JsonResponseViewModel {
    
    var allData: [JsonResponseModel] = []
    let serviceManager = ServiceManager()
    var errorMessage = ""
    weak var delegate: JsonResponseViewModelDelegate?
    
    func fetchListOfRecords(completionHandler: @escaping(String?) -> Void) {
        serviceManager.fetchRecords { result in
            switch result {
            case .success(let data):
                self.allData = data
                self.delegate?.loadNextPage()
                return completionHandler("200")
            case .failure(_):
                self.allData = []
                return completionHandler("1000")
            }
        }
    }

}

