import SwiftUI

struct FoodTruckListView: View {
    @ObservedObject var viewModel = FoodTruckViewModel()
    
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
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.filteredEvents, id: \.self) { foodTruck in
                                NavigationLink(destination: FoodTruckDetailView(viewModel: viewModel, foodTruck: foodTruck)) {
                                    FoodTruckCardView(foodTruck: foodTruck)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .customNavigation()
            .onAppear {
                viewModel.fetchFoodTrucks()
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("푸드트럭을 찾아보세요!")
                .font(.system(size: 30).weight(.heavy))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
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
}

#Preview {
    FoodTruckListView()
}
