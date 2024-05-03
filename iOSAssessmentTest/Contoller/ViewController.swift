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
    var pageLimit = 10
    var currentPage = 1
    var refreshControl: UIRefreshControl?
    
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
    
    @objc func loadData() {
        viewModel.fetchListOfRecords(page: currentPage, pageLimit: pageLimit) { [weak self] code in
            guard let currentSelf = self else { return }
            if code == Constants.successCode && currentSelf.viewModel.allData.count != 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    currentSelf.tableView.reloadData()
                }
            } else {
                // handle Api failure
            }
        }
        currentPage = currentPage + 1
    }
    
    
    func fecthNextPageRecords() {
        loadData()
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
}

