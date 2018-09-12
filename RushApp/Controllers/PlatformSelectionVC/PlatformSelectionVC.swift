//
//  PlatformSelectionVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class PlatformSelectionVC: BaseVC {
    
    var selectedPlatform:(Platform)->Void = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension PlatformSelectionVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConstants.constantPlatforms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlatformCell")
        (cell?.viewWithTag(12) as! UILabel).text = AppConstants.constantPlatforms[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlatform(Platform.getPlatformFromString(type: AppConstants.constantPlatforms[indexPath.row]))
        self.pop()
    }
    
}
