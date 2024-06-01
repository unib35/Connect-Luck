import Foundation

struct FoodTruckResponse: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String?
    let managerName: String
    let foodType: String
    let reviewCount: Int
    let avgRating: Double
}

struct FoodTruckMenuResponse: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String?
    let price: Double
    let createdAt: String
    let updatedAt: String
}
