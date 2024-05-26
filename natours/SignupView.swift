import SwiftUI

struct SignupView: View {
    @Binding var isLoggedIn: Bool
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Confirm Password", text: $passwordConfirm)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Create Account") {
                NetworkManager.shared.signup(name: name, email: email, password: password, passwordConfirm: passwordConfirm) { result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            isLoggedIn = true
                        }
                    case .failure(let error):
                        print("Signup failed: \(error.localizedDescription)")
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Create Account")
    }
}

#Preview {
    SignupView(isLoggedIn: .constant(false))
}
