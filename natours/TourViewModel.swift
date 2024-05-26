import SwiftUI
import Combine

class ToursViewModel: ObservableObject {
    @Published var tours: [Tour] = []
    @Published var errorMessage: String?

    func fetchTours() {
        guard let url = URL(string: "https://natours-9mok.onrender.com/api/v1/tours") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // Print the raw response to diagnose the issue
                if let rawResponse = String(data: data, encoding: .utf8) {
                    print("Raw response: \(rawResponse)")
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(ToursResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.tours = decodedResponse.data.data
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch tours: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    func deleteTour(id: String) {
        guard let url = URL(string: "https://natours-9mok.onrender.com/api/v1/tours/\(id)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to delete tour: \(error.localizedDescription)"
                }
                return
            }

            self.fetchTours()
        }.resume()
    }
}
