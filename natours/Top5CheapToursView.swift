import SwiftUI

struct Top5CheapToursViews: View {
    @StateObject private var viewModel = Top5CheapToursViewModel()
    @State private var selectedTour: Tour?
    @State private var showBookingView = false

    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.tours) { tour in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(tour.name)
                                .font(.headline)
                            Text(tour.summary)
                                .font(.subheadline)
                            Text("Price: $\(tour.price)")
                                .font(.subheadline)
                            Text("Difficulty: \(tour.difficulty)")
                                .font(.subheadline)
                            Button(action: {
                                viewModel.deleteTour(id: tour.id)
                            }) {
                                Text("Delete Tour")
                                    .foregroundColor(.red)
                            }
                            Button(action: {
                                selectedTour = tour
                                showBookingView = true
                            }) {
                                Text("Book Tour")
                                    .foregroundColor(.blue)
                            }
                            Divider()
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Top 5 Cheap Tours")
            .onAppear {
                viewModel.fetchTop5CheapTours()
            }
            .background(
                NavigationLink(destination: BookingView(tour: selectedTour), isActive: $showBookingView) {
                    EmptyView()
                }
            )
        }
    }
}

#Preview {
    Top5CheapToursViews()
}
