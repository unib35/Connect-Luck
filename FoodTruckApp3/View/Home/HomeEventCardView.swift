import SwiftUI
import Kingfisher

struct HomeEventCardView: View {
    let event: EventResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageURL = event.imageURL, let url = URL(string: imageURL) {
                KFImage(url)
                
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 150)
                    .cornerRadius(8)
            }
            Text(event.title ?? "제목 없음")
                .font(.headline)
                .foregroundColor(Color.primary)
                .lineLimit(2)
            
            Text(event.streetAddress ?? "주소 없음")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("시작일: \(formattedDate(event.startAt))")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.2))
                        Text(eventStatusText(status: event.status))
                            .font(.system(size: 12))
                            .foregroundColor(.primary)
                            .padding(5)
                    }
                    .frame(width: 80, height: 25, alignment: .leading)

                }
                
                
            }
            .padding(.vertical, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
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

#Preview {
    HomeEventCardView(event: EventResponse(id: 1, title: "Sample Event", content: "Sample Content", zipCode: "12345", streetAddress: "123 Main St", detailAddress: "Suite 101", startAt: "2024-05-25", endAt: "2024-05-26", imageURL: "https://example.com/image.jpg", managerName: "Manager", status: "EVENT_START"))
}
