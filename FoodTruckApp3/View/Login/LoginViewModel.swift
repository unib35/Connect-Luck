import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var accessToken: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []

    private init() { }
    
    func login(completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            self.alertMessage = "이메일과 비밀번호를 입력해 주세요."
            self.showAlert = true
            completion(false)
            return
        }
        
        self.isLoading = true
        
        let loginRequestDTO = LoginRequestDTO(email: email, password: password)
        
        UserService.shared.login(loginRequest: loginRequestDTO) { [weak self] token, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let token = token {
                    self?.alertMessage = "로그인 성공."
                    self?.accessToken = token
                    self?.isLoggedIn = true
                    print("로그인성공: \(self?.accessToken)")
                    
                    completion(true)
                } else {
                    self?.alertMessage = "아이디와 비밀번호를 확인해 주세요."
                    print("로그인실패 - \(error?.localizedDescription ?? "알 수 없는 오류"))")
                    self?.showAlert = true
                    completion(false)
                }
            }
        }
    }
    
    func logout() {
        self.isLoggedIn = false
        self.accessToken = nil
    }
}
