//
//  ViewController.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: TableViewDataSource?
    private let viewModel = JsonResponseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCells()
        initDataSource()
        loadData()
    }
    
    func initDataSource() {
        dataSource = TableViewDataSource(viewModel)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    
    func registerCells() {
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
    }
    
    func loadData() {
        viewModel.fetchListOfRecords {[weak self] code in
            guard let currentSelf = self else { return }
            if code == Constants.successCode && currentSelf.viewModel.response != nil {
                DispatchQueue.main.async {
                    currentSelf.tableView.reloadData()
                }
            } else {
                // handle Api failure
            }
        }
    }
    
}

