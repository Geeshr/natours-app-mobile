import SwiftUI

struct HomeView: View {
    @State private var showMenu = false
    @Binding var isLoggedIn: Bool
    @State private var showToursView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                    Spacer()
                    Text("Welcome to the Home Page!")
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                }

                Spacer()

                if showMenu {
                    VStack(alignment: .leading) {
                        Button(action: {
                            logout()
                        }) {
                            HStack {
                                Image(systemName: "arrow.backward")
                                Text("Logout")
                            }
                            .padding()
                        }

                        Button(action: {
                            showToursView = true
                        }) {
                            HStack {
                                Image(systemName: "globe")
                                Text("All Tours")
                            }
                            .padding()
                        }

                        Spacer()
                    }
                    .frame(width: 200)
                    .transition(.move(edge: .leading))
                    .animation(.default, value: showMenu)
                }

                NavigationLink(destination: ToursView(), isActive: $showToursView) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }

    private func logout() {
        NetworkManager.shared.logout { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    isLoggedIn = false
                }
            case .failure(let error):
                print("Logout failed: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    HomeView(isLoggedIn: .constant(true))
}
