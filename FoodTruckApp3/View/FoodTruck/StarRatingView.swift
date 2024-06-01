import SwiftUI

struct StarRatingView: View {
    let rating: Double
    private let maxRating = 5
    
    var body: some View {
        HStack(spacing: 5){
            ForEach(0..<maxRating) { index in
                Image(systemName: starType(index: index))
                    .foregroundColor(.yellow)
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    private func starType(index: Int) -> String {
        let filledStar = "star.fill"
        let halfStar = "star.leadinghalf.filled"
        let emptyStar = "star"
        
        if Double(index) < rating {
            return rating - Double(index) >= 1 ? filledStar : halfStar
        } else {
            return emptyStar
        }
    }
}

#Preview {
    StarRatingView(rating: 3.5)
}
