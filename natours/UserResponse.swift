import Foundation

struct UserResponse: Codable {
    let status: String
    let token: String?
    let data: UserData?
    
    struct UserData: Codable {
        let user: User
    }
    
    struct User: Codable {
        let id: String
        let email: String
    }
}
