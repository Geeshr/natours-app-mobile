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
                        Spacer()
                        Text("Welcome to Natours!")
                            .font(.headline)
                            .padding(.top, 10)

                        Text("Login or Sign up to book a tour")
                            .font(.headline)
                            .padding(.top, 10)

                  

                        NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn)) {
                            Text("Login")
                                .font(.title2)
                                .padding(.top, 20)

                             
                              
                        }


                        NavigationLink(destination: SignupView(isLoggedIn: $isLoggedIn)) {
                            Text("Create Account")
                                .font(.title2)
                               
                        }
                        .padding()
                        
                        Spacer()
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
