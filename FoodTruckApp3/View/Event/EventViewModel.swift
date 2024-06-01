import Foundation
import Combine

class EventViewModel: ObservableObject {
    @Published var events: [EventResponse] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var searchQuery: String = ""
    
    init() {
        fetchEvents()
    }
    
    func fetchEvents() {
        self.isLoading = true
        EventService.shared.fetchEvents { [weak self] events, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.events = events ?? []
                }
            }
        }
    }
    
    var filteredEvents: [EventResponse] {
            if searchQuery.isEmpty {
                return events
            } else {
                return events.filter { event in
                    event.title?.lowercased().contains(searchQuery.lowercased()) ?? false
                }
            }
        }
}
