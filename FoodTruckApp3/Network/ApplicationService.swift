import Foundation
import Alamofire

struct ApplicationService {
    static let shared = ApplicationService()
    
    func fetchApplications(eventId: Int, token: String, completion: @escaping ([ApplicationResponse]?, Error?) -> Void) {
        let endpoint = "/application/event-manager?eventId=\(eventId)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        NetworkService.shared.performRequest(endpoint, method: .get, headers: headers) { (response: [ApplicationResponse]?, error) in
            completion(response, error)
        }
    }
}
