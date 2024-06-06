import SwiftUI

struct Top5CheapToursView: View {
    @State private var top5CheapTours: [Tour] = []
    @State private var isLoading = false
    @State private var error: Error?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
            } else if let error = error {
                Text("Failed to load tours: \(error.localizedDescription)")
                    .foregroundColor(.red)
            } else {
                List(top5CheapTours) { tour in
                    VStack(alignment: .leading) {
                        Text(tour.name).font(.headline)
                        Text(tour.summary).font(.subheadline)
                        Text("Price: \(tour.price)").font(.subheadline)
                        Text("Difficulty: \(tour.difficulty)").font(.subheadline)
                    }
                }
            }
        }
        .onAppear(perform: fetchTop5CheapTours)
        .navigationBarTitle("Top 5 Cheap Tours", displayMode: .inline)
    }

    private func fetchTop5CheapTours() {
        isLoading = true
        NetworkManager.shared.fetchTop5CheapTours { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let tours):
                    self.top5CheapTours = tours
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
