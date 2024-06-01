import SwiftUI
import Kingfisher

struct FoodTruckDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FoodTruckViewModel
    let foodTruck: FoodTruckResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            FoodTruckImageView(imageURL: foodTruck.imageUrl)
            ScrollView {
                FoodTruckDetailsView(viewModel: viewModel, foodTruck: foodTruck)
            }
            Spacer()
        }
        .navigationTitle("푸드트럭 정보")
        .customNavigation()
        .onAppear {
            viewModel.fetchMenu(for: foodTruck.id)
        }
    }
}

struct FoodTruckImageView: View {
    let imageURL: String?
    
    var body: some View {
        Group {
            if let imageURL = imageURL, let url = URL(string: imageURL) {
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

struct FoodTruckDetailsView: View {
    @ObservedObject var viewModel: FoodTruckViewModel
    let foodTruck: FoodTruckResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(foodTruck.name)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.bottom, 5)
                .foregroundStyle(.primary)
            
            HStack {
                StarRatingView(rating: foodTruck.avgRating)
                Text("(\(String(format: "%.1f", foodTruck.avgRating)))")
                    .font(.subheadline)
                    .padding(.bottom, 2)
            }
            
            HStack {
                Text("음식 종류: \(foodTruck.foodType)")
                    .font(.subheadline)
                    .foregroundStyle(Color.bkText)
                
                Divider()
                
                Text("리뷰 \(foodTruck.reviewCount)")
                    .font(.subheadline)
                    .foregroundStyle(Color.bkText)
            }
            
            Text("사장님 \(foodTruck.managerName)")
                .font(.subheadline)
                .padding(.bottom, 5)
                .foregroundStyle(Color.primary)
            
            Text(foodTruck.description)
                .font(.body)
                .padding(.bottom, 20)
                .foregroundStyle(Color.primary)
            
            Divider()
                .padding(.bottom, 10)
            
            Text("메뉴")
                .font(.headline)
                .padding(.bottom, 5)
            
            if viewModel.isLoading {
                LoadingView()
            } else if let errorMessage = viewModel.errorMessage {
                Text("오류: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                MenuListView(menuItems: viewModel.menuItems)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct MenuListView: View {
    let menuItems: [FoodTruckMenuResponse]
    
    var body: some View {
        VStack {
            ForEach(menuItems) { menuItem in
                FoodTruckMenuCardView(menuItem: menuItem)
                    .padding(.bottom, 10)
            }
        }
    }
}
