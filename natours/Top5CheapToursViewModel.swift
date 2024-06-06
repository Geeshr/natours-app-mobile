import SwiftUI
import Combine

class Top5CheapToursViewModel: ObservableObject {
    @Published var tours: [Tour] = []
    @Published var errorMessage: String?

    init() {
        fetchTop5CheapTours()
    }

    func fetchTop5CheapTours() {
        NetworkManager.shared.fetchTop5CheapTours { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tours):
                    self.tours = tours
                case .failure(let error):
                    self.errorMessage = "Failed to fetch top 5 cheap tours: \(error.localizedDescription)"
                }
            }
        }
    }

    func deleteTour(id: String) {
        NetworkManager.shared.deleteTour(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.tours.removeAll { $0.id == id }
                case .failure(let error):
                    self.errorMessage = "Failed to delete tour: \(error.localizedDescription)"
                }
            }
        }
    }
}
