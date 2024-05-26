import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                NetworkManager.shared.login(email: email, password: password) { result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            isLoggedIn = true
                        }
                    case .failure(let error):
                        print("Login failed: \(error.localizedDescription)")
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Login")
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}

