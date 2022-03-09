//
//  User.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct User: Codable, Hashable {
    var email: String?
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var verifiedEmailAt: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case email, id
        case verifiedEmailAt = "email_verified_at"
    }
}
