//
//  RushReviewAlertController.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 6.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class RushReviewAlertController: BaseVC {
    
    private var positiveTapped:(()->Void)!
    private var negativeTapped:(()->Void)!
    @IBOutlet weak var reviewSuccessBackView: GradientView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
    }
    
    func createReviewAlert(positiveButtonTapped:@escaping ()->Void, negativeButtonTapped:@escaping ()->Void) {
        self.positiveTapped = positiveButtonTapped
        self.negativeTapped = negativeButtonTapped
    }
    
    @IBAction func negativeButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.negativeTapped()
    }
    @IBAction func positiveButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.reviewSuccessBackView.alpha = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.dismiss(animated: false, completion: nil)
                self.positiveTapped()
            })
        }

    }
}
