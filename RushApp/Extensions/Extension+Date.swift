//
//  Extension+Date.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 16.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

extension Date {
    
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
   
    
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 {
            return "\(years(from: date)) yıl önce"
        } else if months(from: date)  > 0 {
            return "\(months(from: date)) ay önce"
        } else if weeks(from: date)   > 0 {
            return "\(weeks(from: date)) hafta önce"
        }else if days(from: date)    > 0 {
            return "\(days(from: date)) gün önce"
        }else if hours(from: date)   > 0 {
            return "\(hours(from: date)) saat önce"
        }else if minutes(from: date) > 0 {
            return "\(minutes(from: date)) dakika önce"
        } else if seconds(from: date) > 0 {
            return "\(seconds(from: date)) saniye önce"
        }
        return ""
    }
}
