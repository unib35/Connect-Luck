import SwiftUI

struct MoreButtonView: View {
    var destination: AnyView
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 5){
                Text("더보기")
                    .font(.system(size: 14))
                    .foregroundColor(Color.bkText)
                    
                Image(systemName: "chevron.right.2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .tint(Color.bkText)
            }
        }
    }
}
