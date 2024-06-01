import Foundation
import Alamofire

struct EventService {
    static let shared = EventService()
    
    func fetchEvents(completion: @escaping (EventList?, Error?) -> Void) {
        NetworkService.shared.performRequest("/event", method: .get) { (response: EventList?, error) in
            completion(response, error)
        }
    }
    
    func fetchMyEvents(token: String, completion: @escaping (EventList?, Error?) -> Void) {
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            NetworkService.shared.performRequest("/event/my", method: .get, headers: headers) { (response: EventList?, error) in
                completion(response, error)
                print(response ?? "NO response")
            }
            
    }
    
}
