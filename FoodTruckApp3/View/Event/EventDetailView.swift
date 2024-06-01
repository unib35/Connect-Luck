import SwiftUI
import Kingfisher

struct EventDetailView: View {
    @Environment(\.dismiss) var dismiss
    let event: EventResponse
    
    var body: some View {
        VStack(alignment: .center) {
            EventImageView(event: event)
            
            ScrollView {
                VStack(alignment: .leading) {
                    eventDetailsSection
                    eventAddressSection
                    eventContentSection
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
            
            Spacer()
        }
        .navigationTitle("행사 정보")
        .customNavigation()
    }
    
    var eventDetailsSection: some View {
        Group {
            Text(event.title ?? "제목 없음")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.bottom, 5)
                .foregroundColor(.bk)
            
            Text(eventStatusText(status: event.status))
                .font(.subheadline)
                .padding(.bottom, 2)
            
            Text("시작일: \(formattedDate(event.startAt))")
                .font(.subheadline)
                .padding(.bottom, 2)
            
            Text("종료일: \(formattedDate(event.endAt))")
                .font(.subheadline)
                .padding(.bottom, 10)
            
            Text("행사담당자: \(event.managerName ?? "담당자 없음")")
                .font(.subheadline)
                .padding(.bottom, 5)
                .foregroundColor(.primary)
            
            Divider()
                .padding(.bottom, 20)
        }
    }
    
    var eventAddressSection: some View {
        VStack(alignment: .leading) {
            Text("주소: \(event.streetAddress ?? "주소 없음") \(event.detailAddress ?? "") \(event.zipCode ?? "우편번호 없음")")
                .font(.system(size: 16))
                .padding(.bottom, 5)
        }
    }
    
    var eventContentSection: some View {
        VStack(alignment: .leading) {
            Text(event.content ?? "내용 없음")
                .font(.body)
                .padding(.bottom, 20)
                .foregroundColor(.primary)
        }
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
            return "행사 진행중"
        case "EVENT_END":
            return "행사 종료"
        default:
            return "상태 없음"
        }
    }
    
    func formattedDate(_ dateString: String?) -> String {
        guard let dateString = dateString else { return "정보 없음" }
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return "정보 없음"
    }
}

struct EventImageView: View {
    let event: EventResponse
    
    var body: some View {
        Group {
            if let imageURL = event.imageURL, let url = URL(string: imageURL) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    NavigationView {
        EventDetailView(event: EventResponse(id: 1, title: "Sample Title", content: "ContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContent 1", zipCode: "12345", streetAddress: "123 Main St", detailAddress: "Suite 101", startAt: "2024-05-25T20:50:27.727Z", endAt: "2024-05-26T20:50:27.727Z", imageURL: "https://chrisandpartners.co/wp-content/uploads/2021/11/%EA%B7%B8%EB%A6%BC1.jpg", managerName: "Manager", status: "EVENT_START"))
    }
}
