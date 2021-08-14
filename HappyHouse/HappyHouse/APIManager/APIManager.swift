//
//  APIManager.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/15.
//

import Foundation

class APIManager {
    static let baseURL = "http://3.38.92.134/api/"
        
    /// [GET] api/{memberId}/family
    static func getFamilyList(_ memberId: Int) -> String {
        return baseURL + "\(memberId)/family"
    }
}
