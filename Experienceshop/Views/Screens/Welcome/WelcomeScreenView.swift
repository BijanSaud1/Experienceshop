import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.pink]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Welcome Header
                Text("Welcome to Experienceshop!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                // Brief Description
                Text("Your grocery shopping experience made simple and affordable.")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top)

                Spacer()

                // Login and Register buttons in a vertical stack
                VStack(spacing: 20) {
                    // Login Button
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }

                    // Register Button
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                }

                Spacer()
            }
        }
    }
}
