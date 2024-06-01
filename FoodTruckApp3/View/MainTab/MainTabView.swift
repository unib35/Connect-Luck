import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: MainTabType = .home
    @StateObject private var loginViewModel = LoginViewModel.shared // Assuming you have a LoginViewModel for managing login state

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label(MainTabType.home.title, systemImage: MainTabType.home.imageName)
                }
                .tag(MainTabType.home)
                .customNavigation()

            EventListView(viewModel: EventViewModel())
                .tabItem {
                    Label(MainTabType.event.title, systemImage: MainTabType.event.imageName)
                }
                .tag(MainTabType.event)
                .customNavigation()

            FoodTruckListView(viewModel: FoodTruckViewModel())
                .tabItem {
                    Label(MainTabType.foodtruck.title, systemImage: MainTabType.foodtruck.imageName)
                }
                .tag(MainTabType.foodtruck)
                .customNavigation()

            MyEventView()
                .tabItem {
                    Label(MainTabType.application.title, systemImage: MainTabType.application.imageName)
                }
                .tag(MainTabType.application)
                .customNavigation()
        }
        .environmentObject(loginViewModel) // Provide loginViewModel as an environment object if needed
        .navigationBarBackButtonHidden(true) //HomeView
    }
}

#Preview {
    MainTabView()
}
