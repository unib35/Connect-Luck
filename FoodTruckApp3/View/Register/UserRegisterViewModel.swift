//
//  UserRegisterViewModel.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/28/24.
//

import SwiftUI
import Combine

class UserRegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailAvailable: Bool = false
    @Published var emailCheckResult: String? = nil
    
    
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var name: String = ""
    
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    
    
    
    
    private var cancellables: Set<AnyCancellable> = []
    
    func setEmail(_ email : String){
        self.email = email
    }
    
    func setPassword(_ password : String){
        self.password = password
    }
    
    func setPhoneNumber(_ phoneNumber : String){
        self.phoneNumber = phoneNumber
    }
    
    func setName(_ name: String){
        self.name = name
    }
    
    
    func checkEmailDuplication(_ email: String, completion: @escaping (Bool?) -> Void) {
        UserService.shared.checkEmailDuplication(email) { isAvailable, error in
            if let error = error {
                // 에러 처리
                print(error.localizedDescription)
                self.alertMessage = "이메일 중복 확인 실패(서버 에러)"
                completion(nil) // 에러 발생 시 nil 반환
            } else if let isAvailable = isAvailable {
                // 결과 반환
                if isAvailable {
                    self.alertMessage = "사용 가능한 이메일입니다."
                } else {
                    self.alertMessage = "이미 사용중인 이메일입니다."
                }
                completion(isAvailable)
            } else {
                // 예상치 못한 상황 처리
                completion(nil)
            }
        }
    }
    
    func signUp(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let requestDto = SignUpRequestDTO(name: name, email: email, phone: phoneNumber, password: password)
        
        UserService.shared.signUp(user: requestDto) { [weak self] token, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let token = token {
                    self?.alertMessage = "회원가입이 완료되었습니다."
                    completion(true)
                } else {
                    self?.alertMessage = error?.localizedDescription ?? "회원가입 중 오류가 발생했습니다."
                    completion(false)
                }
                self?.showAlert = true
            }
        }
    }
}
