//
//  JsonResponseModel.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import Foundation

struct JsonResponseModel: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
