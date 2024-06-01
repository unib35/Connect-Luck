import SwiftUI
import Kingfisher

struct FoodTruckMenuCardView: View {
    let menuItem: FoodTruckMenuResponse

    var body: some View {
        HStack {
            if let imageURL = menuItem.imageUrl, let url = URL(string: imageURL) {
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

            VStack(alignment: .leading, spacing: 5) {
                Text(menuItem.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(menuItem.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                Text("₩\(menuItem.price, specifier: "%.0f")")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .padding(.leading, 10)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    Group {
        FoodTruckMenuCardView(menuItem: FoodTruckMenuResponse(
            id: 1,
            name: "아이스 아메리카노",
            description: "시원한 아이스 아메리카노",
            imageUrl: "https://picsum.photos/1600/900",
            price: 4500,
            createdAt: "2024-05-30T18:14:04.787544",
            updatedAt: "2024-05-30T18:14:04.787544"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("아이스 아메리카노")

        FoodTruckMenuCardView(menuItem: FoodTruckMenuResponse(
            id: 2,
            name: "사이다",
            description: "시원한 사이다 (16oz)",
            imageUrl: "https://picsum.photos/1600/900",
            price: 2500,
            createdAt: "2024-05-30T18:14:04.787544",
            updatedAt: "2024-05-30T18:14:04.787544"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("사이다")

        FoodTruckMenuCardView(menuItem: FoodTruckMenuResponse(
            id: 3,
            name: "터키식 디너 롤",
            description: "고소한 빵에 신선한 채소와 양념이 어우러진 디너 롤",
            imageUrl: "https://picsum.photos/1600/900",
            price: 4500,
            createdAt: "2024-05-30T18:14:04.787544",
            updatedAt: "2024-05-30T18:14:04.787544"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("터키식 디너 롤")
    }
}
