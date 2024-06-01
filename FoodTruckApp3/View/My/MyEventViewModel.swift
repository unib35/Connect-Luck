import SwiftUI
import Alamofire
import Combine

class MyEventViewModel: ObservableObject {
    @Published var events: [MyEventResponse] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMyEvents(token: String) {
        isLoading = true
        errorMessage = nil
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        MyEventService.shared.fetchMyEvents(token: token, completion: { [weak self] events, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let events = events {
                    self?.events = events
                    
                } else {
                    self?.errorMessage = error?.localizedDescription ?? "Failed to fetch my events"
                }
            }
        })
    }
    
    func updateEvent(event: MyEventResponse, image: UIImage?, token: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        errorMessage = nil
        
        MyEventService.shared.updateEvent(event: event, image: image, token: token) { [weak self] response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let _ = response {
                    completion(true)
                } else {
                    self?.errorMessage = error?.localizedDescription ?? "Failed to update event"
                    completion(false)
                }
            }
        }
    }
    
    func addEvent(event: MyEventResponse, image: UIImage?, token: String, completion: @escaping (Bool) -> Void) {
            isLoading = true
            errorMessage = nil
            
            MyEventService.shared.addEvent(event: event, image: image, token: token) { [weak self] response, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let _ = response {
                        completion(true)
                    } else {
                        self?.errorMessage = error?.localizedDescription ?? "Failed to add event"
                        completion(false)
                    }
                }
            }
        }
    

}
    
    
    
    
    
    
    
    
