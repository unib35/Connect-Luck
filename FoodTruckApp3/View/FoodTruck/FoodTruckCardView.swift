import SwiftUI
import Kingfisher

struct FoodTruckCardView: View {
    let foodTruck: FoodTruckResponse
    
    var body: some View {
        HStack {
            foodTruckImageView
            foodTruckDetails
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    var foodTruckImageView: some View {
        Group {
            if let imageURL = foodTruck.imageUrl, let url = URL(string: imageURL) {
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
    
    var foodTruckDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(foodTruck.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            Text(foodTruck.foodType)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                StarRatingView(rating: foodTruck.avgRating)
                Text("(\(String(format: "%.1f", foodTruck.avgRating)))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text("리뷰 수: \(foodTruck.reviewCount)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.leading, 10)
    }
}

#Preview {
    FoodTruckCardView(foodTruck: FoodTruckResponse(id: 1, name: "Sample Food Truck", description: "Delicious food truck", imageUrl: "https://example.com/image.jpg", managerName: "Manager", foodType: "Burger", reviewCount: 10, avgRating: 4.5))
}
