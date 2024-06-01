import Foundation
import Combine

class FoodTruckViewModel: ObservableObject {
    @Published var foodTrucks: [FoodTruckResponse] = []
    @Published var menuItems: [FoodTruckMenuResponse] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchQuery: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
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
    
    func fetchMenu(for foodTruckId: Int) {
        isLoading = true
        FoodTruckService.shared.fetchFoodTruckMenu(foodTruckId: foodTruckId) { [weak self] menuItems, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let menuItems = menuItems {
                    self?.menuItems = menuItems
                } else {
                    self?.errorMessage = error?.localizedDescription ?? "메뉴를 불러오는 중 오류가 발생했습니다."
                }
            }
        }
    }
    
    
    var filteredEvents: [FoodTruckResponse] {
           if searchQuery.isEmpty {
               return foodTrucks
           } else {
               return foodTrucks.filter { foodTruck in
                   foodTruck.name.lowercased().contains(searchQuery.lowercased())
               }
           }
       }
       
}
