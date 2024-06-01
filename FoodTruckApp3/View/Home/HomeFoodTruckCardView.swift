import SwiftUI
import Kingfisher

struct HomeFoodTruckCardView: View {
    let foodTruck: FoodTruckResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = foodTruck.imageUrl, let url = URL(string: imageUrl) {
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
            
            Text(foodTruck.name)
                .font(.headline)
                .lineLimit(2)
            Text(foodTruck.description)
                .font(.subheadline)
                .lineLimit(2)
            HStack {
                Text("평점: \(foodTruck.avgRating, specifier: "%.1f") (\(foodTruck.reviewCount) 리뷰)")
                    .font(.subheadline)
                Spacer()
                Text(foodTruck.foodType)
                    .font(.caption)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
            }
        }
        .foregroundColor(Color.bkText)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

#Preview {
    HomeFoodTruckCardView(foodTruck: FoodTruckResponse(id: 1, name: "Sample Food Truck", description: "Delicious burgers and more", imageUrl: "https://example.com/image.jpg", managerName: "Manager", foodType: "BURGER", reviewCount: 10, avgRating: 4.5))
}
