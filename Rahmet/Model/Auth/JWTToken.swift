//
//  JWTToken.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct JWTToken: Codable {
    var accessToken: String?
    var tokenType: String?
    var expiresIn: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
