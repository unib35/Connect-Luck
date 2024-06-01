import Foundation
import Alamofire
import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case responseError
}

struct NetworkService {
    static let shared = NetworkService()
    
    private let hostURL = "https://connect-luck.store/api"
    
    func createURL(withPath path: String) throws -> URL {
        let urlString: String = "\(hostURL)\(path)"
        guard let url = URL(string: urlString) else { throw NetworkError.responseError }
        return url
    }
    
    func performRequest<T: Decodable>(_ endpoint: String, method: HTTPMethod, parameters: Encodable? = nil, headers: HTTPHeaders? = nil, completion: @escaping (T?, Error?) -> Void) {
        guard let url = try? createURL(withPath: endpoint) else {
            print(#fileID, #function, #line, "URL 생성 실패")
            completion(nil, NetworkError.responseError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                print(#fileID, #function, #line, "JSON 데이터 생성 실패")
                completion(nil, error)
                return
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(decodedData, nil)
                    } catch {
                        print("Fail To Decode: \(error)")
                        completion(nil, error)
                    }
                case .failure(let error):
                    print("error: \(error)")
                    completion(nil, error)
                }
            }
    }
    
    func performRequestWithToken<T: Decodable>(_ endpoint: String, method: HTTPMethod, token: String, parameters: Encodable? = nil, completion: @escaping (T?, Error?) -> Void) {
        guard let url = try? createURL(withPath: endpoint) else {
            print(#fileID, #function, #line, "URL 생성 실패")
            completion(nil, NetworkError.responseError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                print(#fileID, #function, #line, "JSON 데이터 생성 실패")
                completion(nil, error)
                return
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(decodedData, nil)
                    } catch {
                        print("Fail To Decode: \(error)")
                        completion(nil, error)
                    }
                case .failure(let error):
                    print("error: \(error)")
                    completion(nil, error)
                }
            }
    }
    
    func uploadRequest<T: Decodable>(_ url: String, method: HTTPMethod, parameters: [String: String], headers: HTTPHeaders?, image: UIImage?, completion: @escaping (T?, Error?) -> Void) {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append(Data(value.utf8), withName: key)
                }
                if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }, to: url, method: method, headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
}
