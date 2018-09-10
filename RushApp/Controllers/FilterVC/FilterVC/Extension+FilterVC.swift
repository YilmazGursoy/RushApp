//
//  Extension+FilterVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

extension FilterVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCellType1") as! FilterCellType1
            cell.arrangeCell(title: cellTitles[indexPath.section][indexPath.row], index: indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCellType2") as! FilterCellType2
            return cell
        }
    }
    
    
    //MARK: DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 2
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 43))
        headerView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        let label = UILabel(frame: CGRect.init(x: 15, y: 0, width: tableView.frame.size.width, height: 43))
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.51)
        if section == 0 {
            label.text = "Yaş Aralığı"
        } else {
            label.text = "Oyun"
        }
        headerView.addSubview(label)
        return headerView
    }
    
}
