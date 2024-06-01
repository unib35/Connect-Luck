import SwiftUI
import Kingfisher

struct EventListView: View {
    @ObservedObject var viewModel: EventViewModel
    
    @State private var selectedStatus: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerView
                searchBar
                if viewModel.isLoading {
                    LoadingView()
                    
                } else if let errorMessage = viewModel.errorMessage {
                    Text("오류: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    statusDropdown
                    contentView
                        .padding(.top, 10)
                }
            }
            .customNavigation()
            .onAppear {
                viewModel.fetchEvents()
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("어떤 행사를 찾고 계세요?")
                .font(.system(size: 30).weight(.heavy))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.top, 10)
        }
    }
    
    var contentView: some View {
        ScrollView {
            LazyVStack(spacing: 50) {
                ForEach(viewModel.filteredEvents.filter { selectedStatus == nil || $0.status == selectedStatus }) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        EventCardView(event: event)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 10)
        }
    }
    
    var searchBar: some View {
        HStack {
            TextField("검색", text: $viewModel.searchQuery)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !viewModel.searchQuery.isEmpty {
                            Button(action: {
                                viewModel.searchQuery = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }
    
    var statusDropdown: some View {
        HStack {
            Spacer()
            Menu {
                Button(action: { selectedStatus = nil }) {
                    Text("모든 상태")
                }
                Button(action: { selectedStatus = "BEFORE_APPLICATION" }) {
                    Text("모집 대기")
                }
                Button(action: { selectedStatus = "OPEN_FOR_APPLICATION" }) {
                    Text("모집중")
                }
                Button(action: { selectedStatus = "APPLICATION_FINISHED" }) {
                    Text("모집 마감")
                }
                Button(action: { selectedStatus = "EVENT_START" }) {
                    Text("행사 진행중")
                }
                Button(action: { selectedStatus = "EVENT_END" }) {
                    Text("행사 종료")
                }
            } label: {
                HStack {
                    Text("필터: \(statusText(for: selectedStatus))")
                        .padding(7)
                        .padding(.horizontal, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .foregroundColor(.primary)
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                
            }
        }
    }
    
    func statusText(for status: String?) -> String {
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
            return "모든 상태"
        }
    }
}

#Preview {
    let viewModel = EventViewModel()
    viewModel.events = [
        EventResponse(id: 1, title: "Sample Event 1", content: "Sample Content 1", zipCode: "12345", streetAddress: "123 Main St", detailAddress: "Suite 101", startAt: "2024-05-25", endAt: "2024-05-26", imageURL: "https://example.com/image1.jpg", managerName: "Manager", status: "EVENT_START"),
        EventResponse(id: 2, title: "Sample Event 2", content: "Sample Content 2", zipCode: "12345", streetAddress: "123 Main St", detailAddress: "Suite 101", startAt: "2024-05-27", endAt: "2024-05-28", imageURL: "https://example.com/image2.jpg", managerName: "Manager", status: "EVENT_END")
    ]
    
    return EventListView(viewModel: viewModel)
}
