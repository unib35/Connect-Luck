import Foundation
import Alamofire
import SwiftUI

struct MyEventService {
    static let shared = MyEventService()
    
    func fetchMyEvents(token: String, completion: @escaping (MyEventList?, Error?) -> Void) {
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            NetworkService.shared.performRequest("/event/my", method: .get, headers: headers) { (response: MyEventList?, error) in
                completion(response, error)
                print("test::: \(response)" ?? "NO response")
            }
        }
    
    func updateEvent(event: MyEventResponse, image: UIImage?, token: String, completion: @escaping (MyEventResponse?, Error?) -> Void) {
        let url = "https://connect-luck.store/api/event/\(event.id)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        let parameters: [String: String] = [
            "title": event.title.bound,
            "content": event.content.bound,
            "zipCode": event.zipCode.bound,
            "streetAddress": event.streetAddress.bound,
            "detailAddress": event.detailAddress.bound,
            "startAt": event.startAt.bound + "T00:00:00Z",
            "endAt": event.endAt.bound + "T23:59:59Z"
        ]
        
        NetworkService.shared.uploadRequest(url, method: .patch, parameters: parameters, headers: headers, image: image, completion: completion)
    }
    
    func addEvent(event: MyEventResponse, image: UIImage?, token: String, completion: @escaping (MyEventResponse?, Error?) -> Void) {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            
            AF.upload(
                multipartFormData: { multipartFormData in
                    if let title = event.title {
                        multipartFormData.append(Data(title.utf8), withName: "title")
                    }
                    if let content = event.content {
                        multipartFormData.append(Data(content.utf8), withName: "content")
                    }
                    if let zipCode = event.zipCode {
                        multipartFormData.append(Data(zipCode.utf8), withName: "zipCode")
                    }
                    if let streetAddress = event.streetAddress {
                        multipartFormData.append(Data(streetAddress.utf8), withName: "streetAddress")
                    }
                    if let detailAddress = event.detailAddress {
                        multipartFormData.append(Data(detailAddress.utf8), withName: "detailAddress")
                    }
                    if let startAt = event.startAt {
                        multipartFormData.append(Data(startAt.utf8), withName: "startAt")
                    }
                    if let endAt = event.endAt {
                        multipartFormData.append(Data(endAt.utf8), withName: "endAt")
                    }
                    
                    if let managerName = event.managerName {
                        multipartFormData.append(Data(managerName.utf8), withName: "managerName")
                    }
                    
                    if let status = event.status {
                        multipartFormData.append(Data(status.utf8), withName: "status")
                    }
                    
                    
                    
                    if let imageData = image?.jpegData(compressionQuality: 0.8) {
                        multipartFormData.append(imageData, withName: "image", fileName: "event.jpg", mimeType: "image/jpeg")
                    }
                },
                to: "https://api.example.com/events",
                headers: headers
            ).responseDecodable(of: MyEventResponse.self) { response in
                switch response.result {
                case .success(let event):
                    completion(event, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    
    
}


