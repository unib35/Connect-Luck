//
//  Festival.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/26/24.
//

import Foundation

struct MyEventResponse: Identifiable, Codable {
    let id: Int
    var title: String?
    var content: String?
    var zipCode: String?
    var streetAddress: String?
    var detailAddress: String?
    var startAt: String?
    var endAt: String?
    var imageUrl: String?
    var managerName: String?
    var status: String?
}


typealias MyEventList = [MyEventResponse]
