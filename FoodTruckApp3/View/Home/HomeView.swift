import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
                    VStack(alignment: .leading) {
                        //headerView
                        
                        bannerView
                        iconGridView
                        VStack(alignment: .leading){
                            //profileView
                            eventSectionView
                            
                            foodTruckSectionView
                        }
                        
                        .padding(.horizontal, 20)
                        .background(Color.clear)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        
                        Spacer()
                    }
                }
            }

            .onAppear {
                viewModel.fetchEvents()
                viewModel.fetchFoodTrucks()
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("홈")
                        .foregroundStyle(Color.bkText)
                        .font(.system(size: 22).weight(.heavy))
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MyEventView()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.primary)
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
        
    }
    var headerView: some View {
        HStack {
            Text("홈")
                .font(.system(size: 20).weight(.heavy))
                .foregroundColor(.bkText)
                .padding(.horizontal, 20)
                .padding(.top, 20)
        }
    }
    
    var bannerView: some View {
        TabView {
            ForEach(viewModel.adURLs, id: \.self) { imageUrl in
                ZStack(alignment: .leading) {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .blur(radius: 2.0)
                        .brightness(-0.1)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        Group {
                            Text("푸드트럭 플랫폼")
                                .font(.system(size: 30).weight(.heavy))
                            Text("커넥트럭")
                                .font(.system(size: 50).weight(.black))
                        }
                        .padding(.horizontal, 20)
                    }
                    .foregroundStyle(Color.white)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
        .navigationBarBackButtonHidden(true) //HomeView
    }
    
    var iconGridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
            NavigationLink(destination: EventListView(viewModel: EventViewModel())) {
                VStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.bkText, lineWidth: 1)
                        .frame(width: 70, height: 70)
                        .overlay(
                            VStack {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.bottom, 5)
                                    .tint(Color.bkText)
                                Text("행사")
                                    .font(.caption)
                                    .foregroundColor(Color.bkText)
                            }
                        )
                }
            }
            NavigationLink(destination: FoodTruckListView(viewModel: FoodTruckViewModel())) {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color.gray.opacity(0.1))
                        .stroke(Color.bkText, lineWidth: 1.5)
                        .frame(width: 70, height: 70)
                        .overlay(
                            VStack {
                                Image(systemName: "box.truck")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.bottom, 5)
                                    .tint(Color.bkText)
                                Text("푸드트럭")
                                    .font(.caption)
                                    .foregroundColor(Color.bkText)
                            }
                        )
                }
            }
            NavigationLink(destination: MyPageView(loginViewModel: LoginViewModel.shared)) {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.bkText, lineWidth: 1.5)
                        .overlay(
                            VStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.bottom, 5)
                                    .tint(Color.bkText)
                                Text("마이페이지")
                                    .font(.caption)
                                    .foregroundColor(Color.bkText)
                            }
                        )
                }
            }
            NavigationLink(destination: MyEventView()) {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.bkText, lineWidth: 1.5)
                        
                        .frame(width: 70, height: 70)
                        .overlay(
                            VStack {
                                Image(systemName: "doc.text")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.bottom, 5)
                                    .tint(Color.bkText)
                                Text("지원 현황")
                                    .font(.caption)
                                    .foregroundColor(Color.bkText)
                            }
                            
                        )
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    
    var profileView: some View {
        HStack {
            Image(.profile)
                .frame(width: 52, height: 52)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 7) {
                Text("이름님 반갑습니다")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.bkText)
                Text("상태 메시지 입력")
                    .font(.system(size: 12))
                    .foregroundColor(.grayDeep)
            }
            .padding(.leading, 10)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.leading, 20)
        .accessibilityElement(children: .combine)
        .accessibilityHint(Text("내 프로필을 보려면 이중탭하십시오."))
    }
    
    var eventSectionView: some View {
        Group {
            HStack {
                Text("행사")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                Spacer()
                
                MoreButtonView(destination: AnyView(EventListView(viewModel: EventViewModel())))
                    .padding(.top, 20)
                    .padding(.trailing, 10)
            }
            
            if viewModel.isLoading {
                LoadingView()
            } else if let errorMessage = viewModel.errorMessage {
                errorView(errorMessage: errorMessage)
            } else {
                eventHorizontalListView
            }
        }
    }
    
    var foodTruckSectionView: some View {
        Group {
            HStack {
                Text("푸드트럭")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                Spacer()
                MoreButtonView(destination: AnyView(FoodTruckListView(viewModel: FoodTruckViewModel())))
                    .padding(.top, 20)
                    .padding(.trailing, 10)
                    
                
            }
            
            if viewModel.isLoading {
                LoadingView()
            } else if let errorMessage = viewModel.errorMessage {
                errorView(errorMessage: errorMessage)
            } else {
                foodTruckHorizontalListView
            }
            
        }
    }
    
    func errorView(errorMessage: String) -> some View {
        Text("오류: \(errorMessage)")
            .foregroundColor(.red)
            .padding()
    }
    
    var eventHorizontalListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.events) { event in
                    NavigationLink(destination: EventListView(viewModel: EventViewModel())) {
                        HomeEventCardView(event: event)
                    }
                }
            }
            .padding(.top, 5)
        }
    }
    
    var foodTruckHorizontalListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.foodTrucks) { foodTruck in
                    NavigationLink(destination: FoodTruckListView(viewModel: FoodTruckViewModel())) {
                        HomeFoodTruckCardView(foodTruck: foodTruck)
                    }
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    HomeView()
}
