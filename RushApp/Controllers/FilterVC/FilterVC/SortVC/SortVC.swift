//
//  SortVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

private let titles = ["En Popüler", "En Güncel"]

class SortVC: BaseVC {

    var applyTapped:(()->Void)?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func dismissTapped(_ sender: Any) {
        
    }
    
}

extension SortVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell") as! SortCell
        cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            Rush.shared.sortType = SortType.popular
        } else {
            Rush.shared.sortType = SortType.date
        }
        self.dismiss()
        applyTapped?()
    }
}
