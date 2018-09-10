//
//  FilterVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit


class FilterVC: BaseVC {
    
    var cellTitles = [["10-18","18-22","22-28","28-30+"],["Platform Seçiniz","Oyun Seçiniz"]]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var navigationTitle:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = navigationTitle
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "FilterCellType1", bundle: .main), forCellReuseIdentifier: "FilterCellType1")
        self.tableView.register(UINib.init(nibName: "FilterCellType2", bundle: .main), forCellReuseIdentifier: "FilterCellType2")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushTapped(_ sender: Any) {
        
    }
}
