import SwiftUI
import Kingfisher

struct MyEventCardView: View {
    let event: MyEventResponse
    
    var body: some View {
        VStack {
            HStack {
                eventImageView
                eventDetails
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
        .frame(maxHeight: 100)
    }
    
    var eventImageView: some View {
        Group {
            if let imageURL = event.imageUrl, let url = URL(string: imageURL) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }
        }
    }
    
    var eventDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(event.title ?? "제목 없음")
                .font(.headline)
                .foregroundColor(Color.primary)
                .lineLimit(1)
            
            Text("\(eventStatusText(status: event.status))")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 10) {
                NavigationLink(destination: MyEventEditView(event: event)) {
                    Text("수정")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.yellow)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    // 행사 상태 변경 액션
                }) {
                    Text("상태 변경")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    // 지원 현황 액션
                }) {
                    Text("지원 현황")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color.green)
                        .cornerRadius(5)
                }
            }
        }
        .padding(.horizontal, 10)
    }
    
    func eventStatusText(status: String?) -> String {
        switch status {
        case "BEFORE_APPLICATION":
            return "모집 대기"
        case "OPEN_FOR_APPLICATION":
            return "모집중"
        case "APPLICATION_FINISHED":
            return "모집 마감"
        case "EVENT_START":
            return "행사진행중"
        case "EVENT_END":
            return "행사종료"
        default:
            return "상태 없음"
        }
    }
}

#Preview {
    NavigationView {
        MyEventCardView(event: MyEventResponse(id: 1, title: "Sample Event", content: "This is a sample event content", zipCode: "12345", streetAddress: "123 Main St", detailAddress: "Suite 101", startAt: "2024-05-25", endAt: "2024-05-26", imageUrl: "https://chrisandpartners.co/wp-content/uploads/2021/11/%EA%B7%B8%EB%A6%BC1.jpg", managerName: "Manager", status: "EVENT_START"))
    }
}
