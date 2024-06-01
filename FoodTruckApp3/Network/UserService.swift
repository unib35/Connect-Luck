import Foundation
import Alamofire

struct UserService {
    static let shared = UserService()
    
    func checkEmailDuplication(_ email: String, completion: @escaping (Bool?, Error?) -> Void) {
        guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("이메일 인코딩 실패")
            completion(nil, NetworkError.responseError)
            return
        }
        
        NetworkService.shared.performRequest("/auth/email-check?email=\(encodedEmail)", method: .post) { (response: EmailCheckResponse?, error) in
            completion(response?.isAvailable, error)
        }
    }
    
    func login(loginRequest: LoginRequestDTO, completion: @escaping (String?, Error?) -> Void) {
        NetworkService.shared.performRequest("/auth/login", method: .post, parameters: loginRequest) { (response: LoginResponse?, error) in
            completion(response?.token, error)
        }
    }
    
    func signUp(user: SignUpRequestDTO, completion: @escaping (String?, Error?) -> Void) {
        NetworkService.shared.performRequest("/auth/signup", method: .post, parameters: user) { (response: SignUpResponseDTO?, error) in
            if let response = response {
                completion(response.token, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
}
