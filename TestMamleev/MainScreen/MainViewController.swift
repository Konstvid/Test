//
//  ViewController.swift
//  TestMamleev
//
//  Created by Andrey on 16.02.2023.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    private let viewModel: IMaimViewModel
    
    private lazy var listOffice: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(showOfficeReso), for: .touchUpInside)
        button.setTitle(Constants.listOfficeTitle, for: .normal)
        return button
    }()
    
    init(viewModel: IMaimViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        configureUI()
        configLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 65.0/255, green: 126.0/255, blue: 71.0/255, alpha: 1.0)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(listOffice)
    }
    
    func configLayout() {
        listOffice.translatesAutoresizingMaskIntoConstraints = false
        listOffice.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        listOffice.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        listOffice.heightAnchor.constraint(equalToConstant: 60).isActive = true
        listOffice.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc func showOfficeReso() {
        viewModel.getListOffice()
    }
}
