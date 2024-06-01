import SwiftUI
import Kingfisher

struct EventCardView: View {
    let event: EventResponse
    
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
            if let imageURL = event.imageURL, let url = URL(string: imageURL) {
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
            
            Text(event.streetAddress ?? "주소 없음")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            Text("\(eventStatusText(status: event.status))")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(event.content ?? "내용 없음")
                .font(.body)
                .lineLimit(2)
                .foregroundColor(.bkText)
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
    EventCardView(event: EventResponse(id: 1, title: "Sample Event", content: "This is a sample event content", zipCode: "12345", streetAddress: "123 Main St", detailAddress: "Suite 101", startAt: "2024-05-25", endAt: "2024-05-26", imageURL: "https://chrisandpartners.co/wp-content/uploads/2021/11/%EA%B7%B8%EB%A6%BC1.jpg", managerName: "Manager", status: "EVENT_START"))
}
