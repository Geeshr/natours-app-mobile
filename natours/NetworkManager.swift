import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://natours-9mok.onrender.com/api/v1/users/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Login failed"])
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func signup(name: String, email: String, password: String, passwordConfirm: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://natours-9mok.onrender.com/api/v1/users/signup") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["name": name, "email": email, "password": password, "passwordConfirm": passwordConfirm]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Signup failed"])
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://natours-9mok.onrender.com/api/v1/users/logout") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Logout failed"])
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
