import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .bkText))
                .scaleEffect(2)
                .padding(.top, 20)
            
            Text("로딩 중...")
                .font(.title) // 원하는 텍스트 크기로 설정
                .foregroundColor(.bkText)
                .padding(.top, 30)
        }
    }
}

#Preview {
    LoadingView()
}
