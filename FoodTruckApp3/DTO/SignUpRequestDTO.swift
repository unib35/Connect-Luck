struct SignUpRequestDTO: Encodable {
    let name: String
    let email: String
    let phone: String
    let password: String
}

struct SignUpResponseDTO: Decodable {
    let token: String
}
