//
//  AddressOffice.swift
//  TestMamleev
//
//  Created by Andrey on 17.02.2023.
//

import UIKit
import MapKit

class OfficeViewController: UIViewController {
    
    var completionLocationTapped: VoidCompletion?
    
    private let viewModel: IOfficeViewModel
    private let viewController = UIViewController()
    private var locationManager = CLLocationManager()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private lazy var shortnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var sphone: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.workTime
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var sgrafLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var buttonMap: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "turnRight"), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.callButtonTitle, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(callOffice), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 65.0/255, green: 126.0/255, blue: 71.0/255, alpha: 1.0)
        return button
    }()
    
    init(viewModel: IOfficeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureUI()
        setUpDate()
        configLayout()
        configureLM()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func setUpDate() {
        shortnameLabel.text = viewModel.office.SSHORTNAME
        addressLabel.text = viewModel.office.SSHORTADDRESS
        sphone.text = viewModel.office.SPHONE
        sgrafLabel.text = viewModel.office.SGRAF
    }
    
    private func configLayout() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: -100).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2).isActive = true
        
        view.addSubview(shortnameLabel)
        shortnameLabel.translatesAutoresizingMaskIntoConstraints = false
        shortnameLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20).isActive = true
        shortnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        shortnameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: shortnameLabel.bottomAnchor, constant: 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(sphone)
        sphone.translatesAutoresizingMaskIntoConstraints = false
        sphone.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20).isActive = true
        sphone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sphone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(workTimeLabel)
        workTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        workTimeLabel.topAnchor.constraint(equalTo: sphone.bottomAnchor, constant: 20).isActive = true
        workTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        workTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(sgrafLabel)
        sgrafLabel.translatesAutoresizingMaskIntoConstraints = false
        sgrafLabel.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: 20).isActive = true
        sgrafLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sgrafLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(buttonMap)
        buttonMap.translatesAutoresizingMaskIntoConstraints = false
        buttonMap.widthAnchor.constraint(equalToConstant: 44).isActive = true
        buttonMap.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonMap.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonMap.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20).isActive = true
        
        view.addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureLM() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    @objc func callOffice() {
        viewModel.getPhoneNumber()
    }
}

extension OfficeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        let center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = Constants.title
        mapView.addAnnotation(pin)
        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: true)
    }
}

