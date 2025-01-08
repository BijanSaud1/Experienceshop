import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager // Access AuthManager

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer() // Pushes content to the center

                    // Title
                    Text("Welcome to Experience App")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)

                    // Sub-text below the welcome message
                    Text("Your grocery shopping experience made simple and affordable.")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    Spacer() // Pushes the content upward to be vertically centered

                    if let user = authManager.currentUser {
                        // Logged-in user: Show "Continue" button
                        VStack(spacing: 20) {
                            Text("Hello, \(user.email ?? "User")!")
                                .foregroundColor(.white)
                                .font(.headline)

                            NavigationLink(destination: MainView()) {
                                Text("Continue to Application")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 40)
                            }

                            Button(action: authManager.logout) {
                                Text("Log Out")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 40)
                            }
                        }
                    } else {
                        // Not logged-in: Show "Log In" and "Register" buttons
                        VStack(spacing: 20) {
                            NavigationLink(destination: LoginView()) {
                                Text("Log In")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 40)
                            }

                            NavigationLink(destination: RegisterView()) {
                                Text("Register")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 40)
                            }
                        }
                    }

                    Spacer() // Pushes everything to the center
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthManager()) // Pass the AuthManager without mock data
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light) // You can change it to .dark for dark mode
    }
}
