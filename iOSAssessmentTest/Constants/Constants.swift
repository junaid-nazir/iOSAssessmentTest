//
//  Constants.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import Foundation
import UIKit

public struct Constants {
    static let bundleIdentifier = "com.junaid.iOSAssessmentTest"
    static let successCode = "200"
    static let failureCode = "1000"
}

extension UIView {

    public class func nib(_ nibNameOrNil: String? = nil, bundleIdentifier: String) -> UINib? {
        guard let bundle = Bundle(identifier: bundleIdentifier) else { return nil }
        let name = nibNameOrNil ?? getNibName
        return UINib(nibName: name, bundle: bundle)
    }

    public class var getNibName: String {
        let name: String = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
}
