//
//  RushAlertController.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class RushAlertController: BaseVC {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var positiveButtonOutlet: UIButton!
    @IBOutlet weak var negativeButtonOutlet: UIButton!
    
    private var positiveTapped:(()->Void)!
    private var negativeTapped:(()->Void)!
    
    private var alertTitle:String!
    private var alertMessage:String!
    private var positiveTitle:String!
    private var negativeTitle:String!
    private var isOneButton:Bool = false
    
    @IBOutlet weak var secondButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = alertTitle
        self.descriptionLabel.text = alertMessage
        self.positiveButtonOutlet.setTitle(positiveTitle, for: .normal)
        self.negativeButtonOutlet.setTitle(negativeTitle, for: .normal)
        self.secondButtonConstraint.constant = isOneButton ? 0 : 49
    }
    
    func createOneButtonAlert(title:String, description:String, buttonTitle:String, buttonTapped:@escaping()->Void) {
        isOneButton = true
        self.alertTitle = title
        self.alertMessage = description
        self.positiveTitle = buttonTitle
        self.positiveTapped = buttonTapped
    }
    
    func createAlert(title:String, description:String, positiveTitle:String, negativeTitle:String, positiveButtonTapped:@escaping ()->Void, negativeButtonTapped:@escaping ()->Void) {
        self.alertTitle = title
        self.alertMessage = description
        self.positiveTitle = positiveTitle
        self.negativeTitle = negativeTitle
        self.positiveTapped = positiveButtonTapped
        self.negativeTapped = negativeButtonTapped
    }
    
    @IBAction func negativeButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.negativeTapped()
    }
    @IBAction func positiveButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.positiveTapped()
    }
}
