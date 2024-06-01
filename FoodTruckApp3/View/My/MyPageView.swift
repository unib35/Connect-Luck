import SwiftUI

struct MyPageView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    @State private var isPresentedLoginView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("마이페이지")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    loginViewModel.logout()
                    isPresentedLoginView = true // 로그아웃 후 로그인 화면으로 이동
                }) {
                    Text("로그아웃")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isPresentedLoginView) {
                LoginView(viewModel: loginViewModel)
                    .navigationBarBackButtonHidden(true) // 로그인 화면에서 뒤로 가기 버튼 숨김
            }
        }.customNavigation()
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(loginViewModel: LoginViewModel.shared)
    }
}
