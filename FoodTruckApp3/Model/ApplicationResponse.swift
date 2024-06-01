// ApplicationResponse.swift
import Foundation

struct ApplicationResponse: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let updatedAt: String
    let status: String
    let comment: String
    let event: EventResponse
    let foodTruckId: Int
    let foodTruckManager: Manager

    struct Manager: Codable {
        let id: Int
        let email: String
        let name: String
        let phone: String
    }
}
