//
//  JsonResponseViewModel.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import Foundation
class JsonResponseViewModel {
    
    var response: [JsonResponseModel]?
    let serviceManager = ServiceManager()
    var errorMessage = ""
    
    func fetchListOfRecords(completionHandler: @escaping(String?) -> Void) {
        serviceManager.fetchRecords { result in
            switch result {
            case .success(let data):
                self.response = data
                return completionHandler("200")
            case .failure(_):
                self.response = nil
                return completionHandler("1000")
            }
        }
    }
    
    
    func getErrorMessage(error: ApiError) {
        switch error {
        case .apiOperationFailed(let errorMessage):
            self.errorMessage = errorMessage
        case .decodingError(let errorMessage):
            self.errorMessage = errorMessage
        }
    }

}

