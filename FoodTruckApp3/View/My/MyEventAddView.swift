import SwiftUI

struct MyEventAddView: View {
    @StateObject var viewModel = MyEventViewModel()
    @State var title: String = ""
    @State var content: String = ""
    @State var zipCode: String = ""
    @State var streetAddress: String = ""
    @State var detailAddress: String = ""
    @State var managerName: String = ""
    @State var startAt: Date = Date()
    @State var endAt: Date = Date()
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("행사 정보")) {
                    TextField("제목", text: $title)
                    TextField("내용", text: $content)
                    TextField("우편번호", text: $zipCode)
                    TextField("주소", text: $streetAddress)
                    TextField("세부 주소", text: $detailAddress)
                    TextField("매니저 이름", text: $managerName)
                    DatePicker("시작 날짜", selection: $startAt, displayedComponents: .date)
                    DatePicker("종료 날짜", selection: $endAt, displayedComponents: .date)
                }
                
                Section(header: Text("사진 추가")) {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("사진 선택")
                    }
                    
                    if let inputImage = inputImage {
                        Image(uiImage: inputImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(8)
                    }
                }
                
                Button(action: {
                    addEvent()
                }) {
                    Text("등록")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("행사 등록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    private func addEvent() {
        guard let token = LoginViewModel.shared.accessToken else {
            alertMessage = "로그인이 필요합니다."
            showAlert = true
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let newEvent = MyEventResponse(
            id: UUID().hashValue,
            title: title,
            content: content,
            zipCode: zipCode,
            streetAddress: streetAddress,
            detailAddress: detailAddress,
            startAt: dateFormatter.string(from: startAt),
            endAt: dateFormatter.string(from: endAt),
            imageUrl: "",
            managerName: managerName,
            status: "EVENT_START"
        )
        
        viewModel.addEvent(event: newEvent, image: inputImage, token: token) { success in
            if success {
                dismiss()
            } else {
                alertMessage = "행사가 등록되었습니다.."
                showAlert = true
            }
        }
    }
}
