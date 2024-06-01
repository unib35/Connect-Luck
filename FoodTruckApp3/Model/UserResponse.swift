//
//  UserResponse.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/26/24.
//

import Foundation

// MARK: - User
struct UserResponse: Codable {
    let createdAt, updatedAt: String?
    let roles: [String]?
    let id: Int?
    let email, password, name, phone: String?
    let reviews: [ReviewResponse]?
}

// MARK: - Review
struct ReviewResponse: Codable {
    let createdAt, updatedAt: String?
    let id: Int?
    let content: String?
    let rating: Int?
    let imageURL: String?
    let reply: String?

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id, content, rating
        case imageURL = "imageUrl"
        case reply
    }
}

struct LoginResponse: Codable {
    let token: String?
}

struct EmailCheckResponse: Codable {
    let isAvailable: Bool?
}

struct SignUpResponse: Decodable {
    let success: Bool
}
