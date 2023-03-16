//
//  ResoCell.swift
//  TestMamleev
//
//  Created by Andrey on 16.02.2023.
//

import UIKit

class OfficeCell: UITableViewCell {
    
    let date = Date()
    
    private lazy var shortNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var shortAddress: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var toOfficeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "до офиса:"
        label.textColor = .lightGray
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        contentView.addSubview(label)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(office: Office) {
        shortNameLabel.text = office.SSHORTNAME
        shortAddress.text = office.SSHORTADDRESS
        distanceLabel.text = office.SDISTANCE
        
        if let graf = office.GRAF, let dayNumber = Date().dayNumberOfWeek() {
            let startTime = graf[dayNumber].getBeginTime()
            let finishTime = graf[dayNumber].getSendTime()
            let currentDate = NSDate()
            let isOpen = currentDate.isOpen(start: startTime, finish: finishTime)
            statusLabel.textColor = isOpen ? .green : .red
            statusLabel.text =  isOpen ? "Открыт" : "Закрыт"
        }
    }
    
    private func configLayout() {
        shortNameLabel.translatesAutoresizingMaskIntoConstraints = false
        shortNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        shortNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        shortAddress.translatesAutoresizingMaskIntoConstraints = false
        shortAddress.topAnchor.constraint(equalTo: shortNameLabel.bottomAnchor, constant: 8).isActive = true
        shortAddress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        shortAddress.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true        
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        toOfficeLabel.translatesAutoresizingMaskIntoConstraints = false
        toOfficeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        toOfficeLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 5).isActive = true
        
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: toOfficeLabel.trailingAnchor, constant: 5).isActive = true
    }
    
    class func reuseID() -> String {
        NSStringFromClass(OfficeCell.self).components(separatedBy: ".").last ?? ""
    }
}
