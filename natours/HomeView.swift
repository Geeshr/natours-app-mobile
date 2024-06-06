import SwiftUI

struct HomeView: View {
    @State private var showMenu = false
    @Binding var isLoggedIn: Bool
    @State private var showToursView = false
    @State private var showTop5CheapToursView = false
    @State private var showCreateTourView = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Home Page!")
                    .font(.largeTitle)
                    .padding()

                Spacer()

                VStack(alignment: .leading) {
                    NavigationLink(destination: ToursView(), isActive: $showToursView) {
                        HomeOptionView(imageName: "globe", title: "All Tours", width: 200, height: 200)
                    }

                    NavigationLink(destination: Top5CheapToursView(), isActive: $showTop5CheapToursView) {
                        HomeOptionView(imageName: "star", title: "Top 5 Cheap Tours", width: 200, height: 200)
                    }

                    NavigationLink(destination: CreateTourView(), isActive: $showCreateTourView) {
                        HomeOptionView(imageName: "plus.circle", title: "Create Tour", width: 200, height: 200)
                    }

                    Button(action: {
                        logout()
                    }) {
                        HomeOptionView(imageName: "arrow.backward", title: "Logout", width: 200, height: 200)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()

                Spacer()
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

struct HomeOptionView: View {
    let imageName: String
    let title: String
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
            Text(title)
                .font(.title)
                .padding([.bottom], 10)
        }
        .frame(width: width, height: height)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    HomeView(isLoggedIn: .constant(true))
}
