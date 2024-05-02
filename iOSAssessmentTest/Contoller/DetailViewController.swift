//
//  DetailViewController.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var userIdLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    var detailModel: JsonResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        guard let data = detailModel else {
            return
        }
        titleLabel.numberOfLines = 0
        userIdLabel.text = String(data.userId)
        titleLabel.text = data.title
        bodyLabel.text = data.body
    }


}
