//
//  Comment.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/3/24.
//

import Foundation

struct Comment: Identifiable, Codable {
    var id = UUID()
    let user: User
    let timestamp: Date
    let commentString: String
}

struct User: Codable {
    let profileImage: String // Emoji for simplicity
    let userName: String
}
