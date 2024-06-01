import SwiftUI

struct RegisterPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: UserRegistrationViewModel
    
    @State private var isPresentedRegisterPhoneNumberView: Bool = false
    
    @State private var password: String = ""
    @State private var checkPassword: String = ""
    @State private var showPassword = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerSection
                passwordInputSection
                nextButton
                Spacer()
            }
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .disabled(viewModel.isLoading)
            .onTapGesture { self.dismissKeyboard() }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("알림"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("확인")))
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.backward")
                            .bold()
                            .foregroundColor(Color.bkText)
                    }
                }
            }
            .padding(.horizontal, 30)
            .navigationDestination(isPresented: $isPresentedRegisterPhoneNumberView) {
                RegisterNamePhoneView(viewModel: viewModel)
            }
        }
    }
    
    private var headerSection: some View {
        Group {
            Text("회원가입")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.bkText)
                .padding(.top, 80)
            Text("로그인에 사용할 비밀번호를 입력해 주세요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.bkText)
        }
    }
    
    private var passwordInputSection: some View {
        Group {
            Text("비밀번호")
                .padding(.top, 40)
            SecureField("비밀번호를 입력하세요.", text: $password)
                .padding(.top, 5)
                .font(.system(size: 14))
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
            Divider()
            HStack {
                criteriaView(text: "8자리 이상", isValid: password.containsAtLeast8Characters)
                criteriaView(text: "숫자와 영문 포함", isValid: password.containsBothNumberAndLetter)
                criteriaView(text: "특수 문자 포함", isValid: password.containsSpecialCharacter)
            }
            .padding(.top, 5)
            Text("비밀번호 확인")
                .padding(.top, 20)
            SecureField("다시 한 번 비밀번호를 입력하세요.", text: $checkPassword)
                .padding(.top, 5)
                .font(.system(size: 14))
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
            Divider()
            if password.isMatch(checkPassword) && !password.isEmpty {
                HStack {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .clipShape(Circle())
                    Text("비밀번호가 일치합니다")
                        .font(.system(size: 12))
                }
                .foregroundColor(Color.green)
                .padding(.top, 5)
            }
        }
    }
    
    private var nextButton: some View {
        Button {
            if isNextButtonEnabled {
                proceedToNextView()
            }
        } label: {
            Text("다음")
        }
        .buttonStyle(FTAToggleButtonStyle(isNextButtonEnabled))
        .padding(.top, 30)
        .disabled(!isNextButtonEnabled)
    }
    
    private var isNextButtonEnabled: Bool {
        !password.isEmpty && !checkPassword.isEmpty &&
        password == checkPassword &&
        password.containsBothNumberAndLetter &&
        password.containsAtLeast8Characters &&
        password.containsSpecialCharacter
    }
    
    private func criteriaView(text: String, isValid: Bool) -> some View {
        HStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 10, height: 10)
                .clipShape(Circle())
            Text(text)
                .font(.system(size: 12))
        }
        .foregroundColor(isValid ? Color.green : Color.gray)
    }
    
    private func proceedToNextView() {
        isPresentedRegisterPhoneNumberView = true
        viewModel.setPassword(password)
    }
}

extension String {
    var containsAtLeast8Characters: Bool {
        return self.count >= 8
    }
    
    var containsBothNumberAndLetter: Bool {
        let containsLetter = self.range(of: "[A-Za-z]", options: .regularExpression) != nil
        let containsNumber = self.range(of: "[0-9]", options: .regularExpression) != nil
        return containsLetter && containsNumber
    }
    
    var containsSpecialCharacter: Bool {
        let regex = ".*[!&^%$#@()/]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func isMatch(_ otherPassword: String) -> Bool {
        return self == otherPassword
    }
}

#Preview {
    RegisterPasswordView(viewModel: UserRegistrationViewModel())
}
