import SwiftUI

struct ToursView: View {
    @StateObject private var viewModel = ToursViewModel()
    @State private var selectedTour: Tour?
    @State private var showBookingView = false

    var body: some View {
        NavigationView {
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
                .navigationTitle("Tours")
                .onAppear {
                    viewModel.fetchTours()
                }
                .background(
                    NavigationLink(destination: BookingView(tour: selectedTour), isActive: $showBookingView) {
                        EmptyView()
                    }
                )
            }
        }
    }
}

#Preview {
    ToursView()
}
//5011054488597827
