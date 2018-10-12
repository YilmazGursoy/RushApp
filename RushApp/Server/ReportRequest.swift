//
//  ReportRequest.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 13.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class ReportRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.RushAppReport
    }
    
    func sendReportRequest(type:ReportType, report:String, reportId:String, completionSuccess:@escaping()->Void, completionFailed:@escaping()->Void) {
        let parameters:[String:Any] = ["type":type.rawValue,
                                       "report":report,
                                       "reportId":reportId]
        
        self.requestWith(functionName: LambdaConstants.RushAppReport, andParameters: parameters) { (response:AnyObject?, error:Error?) -> (Void) in
            if response != nil {
                completionSuccess()
            } else {
                completionFailed()
            }
        }
    }
}
