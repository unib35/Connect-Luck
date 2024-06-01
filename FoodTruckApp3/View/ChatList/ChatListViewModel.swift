import SwiftUI
import Combine

class ChatListViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchMyUser()
        fetchUsers()
    }
    
    func fetchMyUser() {
        // 여기서 사용자 정보를 가져오는 로직을 추가합니다.
        // 예를 들어, API를 호출하거나 로컬 데이터를 로드할 수 있습니다.
        //self.myUser = sampleMyUser
    }
    
    func fetchUsers() {
        // 여기서 사용자 목록을 가져오는 로직을 추가합니다.
        // 예를 들어, API를 호출하거나 로컬 데이터를 로드할 수 있습니다.
        //self.users = sampleUsers
    }
    

}
