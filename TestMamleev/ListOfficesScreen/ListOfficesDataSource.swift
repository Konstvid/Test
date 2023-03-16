//
//  ListOfficesDataSource.swift
//  TestMamleev
//
//  Created by Andrey on 18.02.2023.
//

import UIKit

class ListOfficesDataSource: NSObject {
    
    var offices = [Office]()
}

extension ListOfficesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(offices.count)
        return offices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OfficeCell.reuseID(), for: indexPath) as! OfficeCell
        cell.setUp(office: offices[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
