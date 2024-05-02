//
//  ViewController.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import UIKit

class ViewController: UIViewController, TableViewDataSourceDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: TableViewDataSource?
    private let viewModel = JsonResponseViewModel()
    var model: JsonResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCells()
        initDataSource()
        loadData()
    }
    
    func initDataSource() {
        dataSource = TableViewDataSource(viewModel)
        dataSource?.delegate = self
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    
    func registerCells() {
        self.tableView.register(ListTableViewCell.nib(bundleIdentifier: Constants.bundleIdentifier), forCellReuseIdentifier: "ListTableViewCell")
    }
    
    func loadData() {
        viewModel.fetchListOfRecords {[weak self] code in
            guard let currentSelf = self else { return }
            if code == Constants.successCode && currentSelf.viewModel.allData != nil {
                DispatchQueue.main.async {
                    currentSelf.tableView.reloadData()
                }
            } else {
                // handle Api failure
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailView" {
            if let controller = segue.destination as? DetailViewController {
                if let detailModel = sender as? JsonResponseModel{
                    controller.detailModel = detailModel
                }
            }
        }
    }
    
    func navigateToVC(data: JsonResponseModel) {
        performSegue(withIdentifier: "showDetailView", sender: data)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

