import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel.shared
    @State private var isPresentedHomeView: Bool = false

    var body: some View {
        NavigationStack {
            if viewModel.isLoggedIn {
                HomeView()
            } else {
                VStack(alignment: .leading) {
                    Group {
                        Text("로그인")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color.bkText)
                            .padding(.top, 80)
                        
                        Text("커넥트럭에 로그인하세요.")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.bkText)
                    }.padding(.horizontal, 30)
                    
                    Group {
                        Text("이메일")
                            .padding(.top, 40)
                        
                        TextField("이메일을 입력하세요.", text: $viewModel.email)
                            .padding(.top, 5)
                            .font(.system(size: 14))
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        Divider()
                        
                        Text("비밀번호")
                            .padding(.top, 40)
                        
                        SecureField("비밀번호를 입력하세요.", text: $viewModel.password)
                            .padding(.top, 5)
                            .font(.system(size: 14))
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        
                        Divider()
                    }.padding(.horizontal, 30)
                    
                    Button(action: {
                        viewModel.login { success in
                            if success {
                                isPresentedHomeView = true
                            }
                        }
                    }) {
                        Text("로그인")
                    }
                    .buttonStyle(FTAButtonStyle(textColor: Color.bkText))
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                    .disabled(viewModel.isLoading)
                    
                    FindStack
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .blur(radius: viewModel.isLoading ? 3 : 0)
                .disabled(viewModel.isLoading)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("알림"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("확인")))
                }
                .navigationDestination(isPresented: $isPresentedHomeView) {
                    MainTabView()
                }
                .onChange(of: viewModel.isLoggedIn) { isLoggedIn in
                    if isLoggedIn {
                        isPresentedHomeView = true
                    }
                }
            }
        }
    }
    
    var FindStack: some View {
        HStack (alignment: .center) {
            Spacer()
            Button {
                // Implement the find ID action
            } label: {
                Text("아이디 찾기")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.bkText)
            }
            Spacer()
            Divider()
                .frame(height: 20)
            Spacer()
            Button {
                // Implement the find password action
            } label: {
                Text("비밀번호 찾기")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.bkText)
            }
            Spacer()
        }.padding(.horizontal, 10)
    }
}

#Preview {
    LoginView()
}
