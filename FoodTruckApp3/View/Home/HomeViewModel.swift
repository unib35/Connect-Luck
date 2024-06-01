import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var events: [EventResponse] = []
    @Published var foodTrucks: [FoodTruckResponse] = []
    @Published var adURLs: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchEvents()
        fetchAdvertisements()
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
    
    func fetchAdvertisements() {
        AdvertisementService.shared.fetchAdvertisements { [weak self] adURLs, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    print(#fileID, #function, #line, "- comment")
                } else {
                    self?.adURLs = adURLs ?? []
//                    self?.adURLs = ["https://i.ibb.co/8z8DR9r/image.png"]
                }
            }
        }
    }
    
    func fetchFoodTrucks() {
            self.isLoading = true
            self.errorMessage = nil
            
            FoodTruckService.shared.fetchFoodTrucks { [weak self] foodTrucks, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let foodTrucks = foodTrucks {
                        self?.foodTrucks = foodTrucks
                    } else {
                        self?.errorMessage = error?.localizedDescription ?? "Failed to fetch food trucks"
                    }
                }
            }
        }
}
