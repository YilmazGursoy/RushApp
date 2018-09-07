//
//  FriendSelectionVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

//TODO:Make this code below to dynamic

class FriendSelectionVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "FriendSelectionCell", bundle: .main), forCellReuseIdentifier: "FriendSelectionCell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
    }
    
}


extension FriendSelectionVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendSelectionCell") as! FriendSelectionCell
        return cell
    }
    
}
