//
//  ListTableViewCell.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureUI() {
        titleLabel.numberOfLines = 2
    }
    
    func configureCell(data: JsonResponseModel?) {
        guard let model = data else {
            return
        }
        titleLabel.text = model.title
        idLabel.text = String(model.id)
    }
    
}
