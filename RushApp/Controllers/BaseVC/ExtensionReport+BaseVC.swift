//
//  ExtensionReport+BaseVC.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 13.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension BaseVC {
    
    @objc func openReportScreen(notification:Notification) {
        
        if let object = notification.object as? (message:String, reportValue:ReportValue, data:Any) {
            
            var id:String = "fmekfmslkefmlksemflksemf"
            
            switch object.reportValue {
            case .comment:
                if let comment = object.data as? Comment {
                    id = comment.commentId
                }
            case .feed:
                if let feed = object.data as? Feed {
                    id = feed.id
                }
            case .lobby:
                if let lobby = object.data as? Lobby {
                    id = lobby.id
                }
            case .user:
                if let user = object.data as? User {
                    id = user.userId
                }
            }
            
            DispatchQueue.main.async {
                let actionSheet = UIAlertController(title: object.message, message: nil, preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction.init(title: "Bu bir spam", style: .default, handler: { (action) in
                    SVProgressHUD.show()
                    self.sendReportRequest(type: .spam, report: id)
                }))
                
                actionSheet.addAction(UIAlertAction.init(title: "Hassas içeriğe sahip bir resim sergiliyor", style: .default, handler: { (action) in
                    SVProgressHUD.show()
                    self.sendReportRequest(type: .naked, report: id)
                }))
                
                actionSheet.addAction(UIAlertAction.init(title: "Taciz ediyor veya zarar veriyor", style: .default, handler: { (action) in
                    SVProgressHUD.show()
                    self.sendReportRequest(type: .harassing, report: id)
                }))
                
                if object.reportValue == .user {
                    actionSheet.addAction(UIAlertAction.init(title: "Bu kullanıcıyı engelle", style: .default, handler: { (action) in
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                            let alert = RushAlertController.createFromStoryboard()
                            alert.createAlert(title: "Uyarı", description: "Kullanıcıyı engellemek istediğinize emin misiniz? Engellediğiniz taktirde bu işlemi Ayarlar'dan geri alabilirsiniz.", positiveTitle: "Engelle", negativeTitle: "İptal", positiveButtonTapped: {
                                //TODO:
                                let request = BlockUserRequest()
                                request.sendRequest(userId: (object.data as! User).userId, username: (object.data as! User).username, successCompletion: { (currentUser) in
                                    
                                    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                                        AnalyticsParameterItemID: "UserBlock",
                                        AnalyticsParameterItemName: "UserBlock Tapped",
                                        AnalyticsParameterContentType: "cont"
                                    ])
                                    
                                    Rush.shared.currentUser = currentUser
                                    if let selectedViewController = self.tabBarController?.selectedViewController as? UINavigationController {
                                        selectedViewController.popToRootViewController(animated: true)
                                    }
                                }, errorCompletion: {
                                    DispatchQueue.main.async {
                                        self.showError(title: "Hata!", description: "Kullanıcı bloklanırken bir sorun oluştu.", doneButtonTapped: {
                                            
                                        })
                                    }
                                })
                                
                            }, negativeButtonTapped: {
                                
                            })
                            
                            if self.tabBarController != nil {
                                self.tabBarController?.present(alert, animated: false, completion: nil)
                            } else {
                                self.navigationController?.present(alert, animated: false, completion: nil)
                            }
                        })
                    }))
                }
                
                actionSheet.addAction(UIAlertAction.init(title: "Kapat", style: .cancel, handler: { (action) in
                    
                }))
                
                self.present(actionSheet, animated: true, completion: nil)
            }
        }
    }
    
    private func sendReportRequest(type:ReportType, report:String){
        let reportRequest = ReportRequest()
        reportRequest.sendReportRequest(type: type, report: report, reportId: report + Rush.shared.currentUser.userId, completionSuccess: {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let rushAlert = RushAlertController.createFromStoryboard()
                rushAlert.createOneButtonAlert(title: "Teşekkürler", description: "Raporunuz işleme alınmıştır en geç 24 saat içinde incelenecektir.", buttonTitle: "Tamam") {
                    
                }
                if self.tabBarController != nil {
                    self.tabBarController?.present(rushAlert, animated: false, completion: nil)
                } else {
                    self.navigationController?.present(rushAlert, animated: false, completion: nil)
                }
            }
            
        }) {
            SVProgressHUD.dismiss()
            self.showError(title: "Hata!", description: "Raporunuz gönderilirken bir sorun oluştu.", doneButtonTapped: {
                
            })
        }
    }
    
    
}
