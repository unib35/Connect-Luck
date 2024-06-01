import SwiftUI

struct RegisterEmailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = UserRegistrationViewModel()
    
    @State private var isPresentedRegisterPasswordView: Bool = false
    
    @State var email: String = ""
    @State var isEmailValid: Bool = false
    @State var isEmailChecked: Bool = false
    @State var isNextButtonEnabled: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var shakeEmail: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerSection
                emailInputSection
                nextButton
                Spacer()
            }
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .disabled(viewModel.isLoading)
            .onTapGesture { self.dismissKeyboard() }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("이메일 확인"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            .navigationBarBackButtonHidden()
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
            .navigationDestination(isPresented: $isPresentedRegisterPasswordView) {
                RegisterPasswordView(viewModel: viewModel)
            }
        }
    }
    
    private var headerSection: some View {
        Group {
            Text("회원가입")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.bkText)
                .padding(.top, 80)
            Text("로그인에 사용할 이메일을 입력해 주세요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.bkText)
        }
    }
    
    private var emailInputSection: some View {
        Group {
            Text("이메일")
                .padding(.top, 30)
            
            ZStack {
                HStack {
                    TextField("", text: $email)
                        .placeholder(when: email.isEmpty) {
                            Text("아이디(이메일)을 입력하세요.")
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 5)
                        .font(.system(size: 14))
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .onChange(of: email) { newValue in
                            validateEmail(newValue)
                        }
                        .shakeEffect(shakeEmail)
                    Spacer()
                    emailCheckButton
                }
            }
            Divider()
        }
    }
    
    private var emailCheckButton: some View {
        Button(action: {
            checkEmail()
        }) {
            Text(isEmailChecked ? "완료" : "확인")
        }
        .disabled(!isEmailValid || isEmailChecked)
        .buttonStyle(FTAToggleButtonStyle(isEmailValid && !isEmailChecked))
        .frame(width: 50)
    }
    
    private var nextButton: some View {
        Button {
            if !isEmailValid {
                shakeEmail += 1
            }
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
    
    private var loadingOverlay: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
            Text("로딩 중...")
                .foregroundColor(.gray)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
    
    private func validateEmail(_ email: String) {
        isEmailValid = isValidEmail(email)
        isEmailChecked = false
        isNextButtonEnabled = false
    }
    
    private func checkEmail() {
        print("입력 email : \(email)")
        viewModel.checkEmailDuplication(email) { isAvailable in
            if let isAvailable = isAvailable {
                if isAvailable {
                    alertMessage = "사용 가능한 이메일입니다."
                    isNextButtonEnabled = true
                } else {
                    alertMessage = "이미 사용중인 이메일입니다."
                    isNextButtonEnabled = false
                }
            } else {
                alertMessage = "이메일 확인 중 오류가 발생했습니다."
                isNextButtonEnabled = false
            }
            showAlert.toggle()
            isEmailChecked = true
        }
    }
    
    private func proceedToNextView() {
        isPresentedRegisterPasswordView.toggle()
        viewModel.setEmail(email)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    RegisterEmailView()
}
