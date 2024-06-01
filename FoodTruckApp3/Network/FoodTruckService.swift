import Foundation
import Alamofire

struct FoodTruckService {
    static let shared = FoodTruckService()
    
    func fetchFoodTrucks(completion: @escaping ([FoodTruckResponse]?, Error?) -> Void) {
        NetworkService.shared.performRequest("/food-truck", method: .get) { (response: [FoodTruckResponse]?, error) in
            completion(response, error)
        }
    }
    
    func fetchFoodTruckMenu(foodTruckId: Int, completion: @escaping ([FoodTruckMenuResponse]?, Error?) -> Void) {
            NetworkService.shared.performRequest("/food-truck/\(foodTruckId)/menu", method: .get) { (response: [FoodTruckMenuResponse]?, error) in
                completion(response, error)
            }
        }
}
