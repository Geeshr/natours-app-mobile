import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var isTimerActive = false
    let logoutTime: TimeInterval = 60 * 5 

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
                    .onAppear {
                        startLogoutTimer()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        cancelLogoutTimer()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                        startLogoutTimer()
                    }
                }
            }
        }
    }

    func startLogoutTimer() {
        isTimerActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + logoutTime) {
            if isTimerActive {
                logout()
            }
        }
    }

    func cancelLogoutTimer() {
        isTimerActive = false
    }

    func logout() {
        // Perform logout action here
        isLoggedIn = false
    }
}

#Preview {
    ContentView()
}
//5011054488597827
