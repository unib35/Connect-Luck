import SwiftUI

struct MyEventEditView: View {
    @State var event: MyEventResponse
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isModified: Bool = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var zipCodeError: String?
    @State private var token: String = "" // 토큰을 필요에 따라 설정
    
    @ObservedObject var viewModel = MyEventViewModel()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var body: some View {
        Form {
            Section(header: Text("이벤트 정보")) {
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
                
                HStack {
                    Text("제목")
                    Spacer()
                    TextField("제목", text: $event.title.bound.onChange { isModified = true })
                }
                HStack {
                    Text("내용")
                    Spacer()
                    TextField("내용", text: $event.content.bound.onChange { isModified = true })
                }
                HStack {
                    Text("우편번호")
                    Spacer()
                    TextField("우편번호", text: $event.zipCode.bound.onChange {
                        isModified = true
                        validateZipCode(event.zipCode)
                    })
                    .foregroundColor(zipCodeError == nil ? .primary : .red)
                }
                if let zipCodeError = zipCodeError {
                    Text(zipCodeError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                HStack {
                    Text("주소")
                    Spacer()
                    TextField("주소", text: $event.streetAddress.bound.onChange { isModified = true })
                }
                HStack {
                    Text("세부 주소")
                    Spacer()
                    TextField("세부 주소", text: $event.detailAddress.bound.onChange { isModified = true })
                }
                HStack {
                    Text("매니저 이름")
                    Spacer()
                    TextField("매니저 이름", text: $event.managerName.bound.onChange { isModified = true })
                }
                HStack {
                    Text("시작 날짜")
                    DatePicker("", selection: Binding(
                        get: { dateFormatter.date(from: event.startAt ?? "") ?? Date() },
                        set: { event.startAt = dateFormatter.string(from: $0); isModified = true }
                    ), displayedComponents: .date)
                }
                HStack {
                    Text("종료 날짜")
                    DatePicker("", selection: Binding(
                        get: { dateFormatter.date(from: event.endAt ?? "") ?? Date() },
                        set: { event.endAt = dateFormatter.string(from: $0); isModified = true }
                    ), displayedComponents: .date)
                }
            }
            
            Section {
                Button(action: {
                    saveEvent()
                }) {
                    Text("저장")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isModified && zipCodeError == nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!isModified)
            }
        }
        .navigationTitle("이벤트 수정")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    private func saveEvent() {
        viewModel.updateEvent(event: event, image: inputImage, token: token) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
                // 오류 처리
            }
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
    }
    
    private func validateZipCode(_ zipCode: String?) {
        guard let zipCode = zipCode else {
            zipCodeError = "올바른 우편번호를 입력해주세요."
            return
        }
        
        let regex = "^[0-9]{5}(?:-[0-9]{4})?$" // 예시: 12345 또는 12345-6789
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        if predicate.evaluate(with: zipCode) {
            zipCodeError = nil
        } else {
            zipCodeError = "유효한 우편번호를 입력해주세요."
        }
    }
}

extension Optional where Wrapped == String {
    var bound: String {
        get { self ?? "" }
        set { self = newValue }
    }
}

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: {
                self.wrappedValue = $0
                handler()
            }
        )
    }
}
