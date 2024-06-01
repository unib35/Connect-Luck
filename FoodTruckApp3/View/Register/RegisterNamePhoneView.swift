import SwiftUI

struct RegisterNamePhoneView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = UserRegistrationViewModel()
    @StateObject var loginViewModel = LoginViewModel.shared
    
    @State private var isPresentedLoginView: Bool = false
    
    @State var name: String = ""
    @State var phone: String = ""
    
    @State var isNameValid: Bool = false
    @State var isPhoneValid: Bool = false
    @State var isNextButtonEnabled: Bool = false
    
    @State private var shakeName: Int = 0
    @State private var shakePhone: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerSection
                nameInputSection
                phoneInputSection
                nextButton
                Spacer()
            }
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .disabled(viewModel.isLoading)
            .onTapGesture { self.dismissKeyboard() }
            
            if viewModel.isLoading {
                loadingOverlay
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("알림"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("확인")))
        }
        .onTapGesture { self.dismissKeyboard() }
        .navigationDestination(isPresented: $isPresentedLoginView) {
            LoginView(viewModel: loginViewModel)
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
    }
    
    private var headerSection: some View {
        Group {
            Text("회원가입")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.bkText)
                .padding(.top, 80)
            Text("이름과 전화번호를 입력해 주세요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.bkText)
        }
        .padding(.horizontal, 30)
    }
    
    private var nameInputSection: some View {
        Group {
            Text("이름")
                .padding(.top, 30)
            TextField("", text: $name)
                .placeholder(when: name.isEmpty) {
                    Text("이름을 입력하세요.")
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
                .font(.system(size: 14))
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .onChange(of: name) { newValue in
                    isNameValid = !newValue.isEmpty
                    updateNextButtonState()
                }
                .shakeEffect(shakeName)
            Divider()
        }
        .padding(.horizontal, 30)
    }
    
    private var phoneInputSection: some View {
        Group {
            Text("전화번호")
                .padding(.top, 30)
            TextField("", text: $phone)
                .placeholder(when: phone.isEmpty) {
                    Text("전화번호를 입력하세요.")
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
                .font(.system(size: 14))
                .keyboardType(.numberPad)
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .onChange(of: phone) { newValue in
                    isPhoneValid = isValidPhone(newValue)
                    updateNextButtonState()
                }
                .shakeEffect(shakePhone)
            Divider()
        }
        .padding(.horizontal, 30)
    }
    
    private var nextButton: some View {
        NavigationLink(destination: LoginView(viewModel: loginViewModel), isActive: $isPresentedLoginView) {
            Button {
                if !isNameValid {
                    shakeName += 1
                }
                if !isPhoneValid {
                    shakePhone += 1
                }
                if isNextButtonEnabled {
                    viewModel.setName(name)
                    viewModel.setPhoneNumber(phone)
                    viewModel.signUp { success in
                        if success {
                            isPresentedLoginView.toggle()
                        }
                    }
                }
            } label: {
                Text("회원가입 완료")
            }
            .buttonStyle(FTAToggleButtonStyle(isNextButtonEnabled))
            .padding(.horizontal, 30)
            .padding(.top, 30)
            .disabled(!isNextButtonEnabled)
        }
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
    
    private func updateNextButtonState() {
        isNextButtonEnabled = isNameValid && isPhoneValid
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegEx = #"^\d{10,15}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePredicate.evaluate(with: phone)
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    RegisterNamePhoneView()
}
