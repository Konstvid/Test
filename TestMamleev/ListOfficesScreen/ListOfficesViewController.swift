//
//  OfficeReso.swift
//  TestMamleev
//
//  Created by Andrey on 16.02.2023.
//

import UIKit

class ListOfficesViewController: UIViewController {
    
    private let viewModel: ListOfficesViewModel
    private let dataSource = ListOfficesDataSource()
    private let items = ["Списком", "На карте"]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .gray
        searchBar.searchTextField.textColor = .black
        searchBar.tintColor = .black
        searchBar.delegate = self
        view.addSubview(searchBar)
        return searchBar
    }()
    
    private lazy var listOfficesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(OfficeCell.self, forCellReuseIdentifier: OfficeCell.reuseID())
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var segmentedControll: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        view.addSubview(control)
        return control
    }()
    
    init(viewModel: ListOfficesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        dataSource.offices = viewModel.offices
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return(true)
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(red: 65.0/255, green: 126.0/255, blue: 71.0/255, alpha: 1.0)
        title = "Офисы РECO-Гарантия"
        setLeftBarButtonItem()
        setRightBarButtonItem()
    }
    
    private func setLeftBarButtonItem(){
        let leftButton = UIButton(type: .custom)
        leftButton.frame = CGRect(x: 0.0, y: 0.0, width: 24, height: 24)
        leftButton.setImage(UIImage(named:"backButton"), for: .normal)
        
        leftButton.tintColor = .white
        leftButton.addTarget(self, action: #selector(returnMainController), for: .touchUpInside)
        
        let leftBarItem = UIBarButtonItem(customView: leftButton)
        let width = leftBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        width?.isActive = true
        let height = leftBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        height?.isActive = true
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    private func setRightBarButtonItem(){
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: 0.0, y: 0.0, width: 24, height: 24)
        rightButton.setImage(UIImage(named:"funnel"), for: .normal)
        
        rightButton.tintColor = .white
        rightButton.addTarget(self, action: #selector(actionFilter), for: .touchUpInside)
        
        let rightBarItem = UIBarButtonItem(customView: rightButton)
        let width = rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        width?.isActive = true
        let height = rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        height?.isActive = true
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    private func configLayout() {
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.topAnchor.constraint(equalTo: view.topAnchor, constant: 50 + safeAreaInsets.top).isActive = true
        segmentedControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        segmentedControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        segmentedControll.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 20).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        listOfficesTableView.translatesAutoresizingMaskIntoConstraints = false
        listOfficesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        listOfficesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listOfficesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listOfficesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func returnMainController() {
        viewModel.popViewController()
    }
    
    @objc private func actionFilter() {
        print("actionFilter")
    }
}

extension ListOfficesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            dataSource.offices = viewModel.offices
        } else {
            let filteredArray = viewModel.offices.filter {
                guard let SSHORTNAME = $0.SSHORTNAME else { return false }
                return SSHORTNAME.localizedCaseInsensitiveContains(searchText)
            }
            dataSource.offices = filteredArray
        }
        listOfficesTableView.reloadData()
    }
}

extension ListOfficesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offise = viewModel.offices[indexPath.row]
        viewModel.showOfficeViewController(office: offise)
    }
}
