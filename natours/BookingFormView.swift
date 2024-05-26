import SwiftUI

struct BookingFormView: View {
    var tourId: String?

    var body: some View {
        Text("Booking form for tour: \(tourId ?? "Unknown")")
            .padding()
            .navigationBarTitle("Book Tour", displayMode: .inline)
    }
}

#Preview {
    BookingFormView(tourId: "12345")
}
