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
}

extension Member: Equatable {
    static func == (lhs: Member, rhs: Member) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Member {

    static let EMPTY = Member(id: 0, nickname: "", image: "")
    
    static let members = [Member(id: 1, nickname: "공주", image: "daughter_profile"),
                          Member(id: 2, nickname: "마마님", image: "mother_profile"),
                          Member(id: 3, nickname: "대장", image: "father_profile")]
}


struct FamilyList: Codable {
    let message: String
    let memberList: [Member]
}
