import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false // State to track login status

    var body: some View {
        Group {
            if isLoggedIn {
                HomeView(isLoggedIn: $isLoggedIn)
            } else {
                NavigationView {
                    VStack {
                        NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn)) {
                            Text("Login")
                        }
                        .padding()

                        NavigationLink(destination: SignupView(isLoggedIn: $isLoggedIn)) {
                            Text("Create Account")
                        }
                        .padding()
                    }
                    .navigationBarTitle("Welcome")
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
