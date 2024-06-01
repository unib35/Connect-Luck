import SwiftUI

struct MyEventView: View {
    @StateObject var viewModel = MyEventViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerView
                if viewModel.isLoading {
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("오류: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 50) {
                            ForEach(viewModel.events) { event in
                                MyEventCardView(event: event)
                            }
                            
                        }
                        .padding(.top, 10)
                    }
                    // 행사 등록 버튼
                    NavigationLink(destination: MyEventAddView()) {
                        Text("행사 등록")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.bkText)
                            .cornerRadius(10)
                            .padding()
                    }.padding(.bottom, 20)
                }
            }
            .customNavigation()
            .onAppear {
                fetchEvents()
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("내가 올린 행사")
                .font(.system(size: 30).weight(.heavy))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.top, 10)
        }
    }
    
    private func fetchEvents() {
        guard let token = LoginViewModel.shared.accessToken else {
            viewModel.errorMessage = "로그인이 필요합니다."
            return
        }
        viewModel.fetchMyEvents(token: token)
    }
}

#Preview {
    MyEventView()
}
