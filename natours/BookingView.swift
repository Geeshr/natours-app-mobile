import SwiftUI

struct BookingView: View {
    @State private var name = ""
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var bookingSuccess = false
    @State private var errorMessage: String?
    
    let tour: Tour?

    var body: some View {
        VStack {
            if bookingSuccess {
                Text("Booking Successful!")
                    .font(.largeTitle)
                    .padding()
            } else {
                if let tour = tour {
                    Form {
                        Section(header: Text("Tour Information")) {
                            Text("Tour: \(tour.name)")
                            Text("Price: $\(tour.price)")
                        }
                        
                        Section(header: Text("Personal Information")) {
                            TextField("Name", text: $name)
                        }
                        
                        Section(header: Text("Card Information")) {
                            TextField("Card Number", text: $cardNumber)
                                .keyboardType(.numberPad)
                            TextField("Expiry Date (MM/YY)", text: $expiryDate)
                            SecureField("CVV", text: $cvv)
                                .keyboardType(.numberPad)
                        }
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        Button(action: bookTour) {
                            Text("Book Tour")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .navigationTitle("Book Tour")
                } else {
                    Text("No tour selected.")
                        .font(.largeTitle)
                        .padding()
                }
            }
        }
        .padding()
    }

    private func bookTour() {
        guard let tour = tour else { return }
        
        let bookingData: [String: Any] = [
            "name": name,
            "cardNumber": cardNumber,
            "expiryDate": expiryDate,
            "cvv": cvv,
            "tourId": tour.id
        ]

        let url = URL(string: "https://natours-9mok.onrender.com/api/v1/bookings")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: bookingData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Booking failed: \(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Booking failed. Invalid response."
                }
                return
            }

            if httpResponse.statusCode == 201 {
                DispatchQueue.main.async {
                    self.bookingSuccess = true
                }
            } else {
                let responseString = String(data: data ?? Data(), encoding: .utf8)
                DispatchQueue.main.async {
                    self.errorMessage = "Booking failed. Response: \(responseString ?? "No response")"
                    self.errorMessage = "Response Status Code: \(httpResponse.statusCode)"
                }
            }
        }.resume()
    }

    
}

#Preview {
    BookingView(tour: nil)
}
