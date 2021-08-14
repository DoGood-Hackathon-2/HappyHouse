//
//  Member.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/15.
//

import Foundation

struct Member: Codable {
    let id: Int
    let nickname: String
    let image: String?
    
    static let EMPTY = Member(id: 0, nickname: "", image: "")
}

struct FamilyList: Codable {
    let message: String
    let memberList: [Member]
}
