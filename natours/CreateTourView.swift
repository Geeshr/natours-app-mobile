import SwiftUI

struct CreateTourView: View {
    @State private var name: String = ""
    @State private var duration: Int?
    @State private var price: Int?
    @State private var maxGroupSize: Int?
    @State private var difficulty: String = ""
    @State private var summary: String = ""
    @State private var errorMessage: String?
    @State private var showSuccessMessage = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create a New Tour")
                .font(.largeTitle)
                .padding(.bottom, 20)

            Group {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Duration (days)", value: $duration, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Price ($)", value: $price, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Max Group Size", value: $maxGroupSize, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Difficulty", text: $difficulty)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Summary", text: $summary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                createTour()
            }) {
                Text("Create Tour")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            if showSuccessMessage {
                Text("Tour created successfully!")
                    .foregroundColor(.green)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Create Tour", displayMode: .inline)
    }

    struct TourCreateRequest: Codable {
        let name: String
        let duration: Int
        let price: Int
        let maxGroupSize: Int
        let difficulty: String
        let summary: String
    }
    private func createTour() {
        guard let duration = duration, let price = price, let maxGroupSize = maxGroupSize else {
            errorMessage = "Please fill in all fields correctly."
            return
        }

        let newTour = TourCreateRequest(name: name, duration: duration, price: price, maxGroupSize: maxGroupSize, difficulty: difficulty, summary: summary)

        NetworkManager.shared.createTour(tour: newTour) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.showSuccessMessage = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to create tour: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    CreateTourView()
}
