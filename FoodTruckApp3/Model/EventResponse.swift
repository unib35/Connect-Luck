//
//  Festival.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/26/24.
//

import Foundation

struct EventResponse: Codable, Identifiable {
    let id: Int?
    let title, content, zipCode, streetAddress: String?
    let detailAddress, startAt, endAt: String?
    let imageURL: String?
    let managerName, status: String?

    enum CodingKeys: String, CodingKey {
        case id, title, content, zipCode, streetAddress, detailAddress, startAt, endAt
        case imageURL = "imageUrl"
        case managerName, status
    }
}

typealias EventList = [EventResponse]
