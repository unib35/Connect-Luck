import Foundation

struct AdvertisementService {
    static let shared = AdvertisementService()
    
    func fetchAdvertisements(completion: @escaping ([String]?, Error?) -> Void) {
        NetworkService.shared.performRequest("/ad", method: .get) { (response: [String]?, error) in
            completion(response, error)
        }
    }
}
