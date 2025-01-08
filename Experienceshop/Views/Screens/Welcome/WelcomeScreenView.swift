import SwiftUI

struct WelcomeView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Subtle Background Gradient with slight blur effect
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.orange.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 10) // Adding blur effect for a soft feel

                VStack {
                    Spacer()

                    // Welcome Header with a shadow for visibility
                    Text("Welcome to Experienceshop!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                        .shadow(radius: 5)

                    // Brief Description with added padding and shadow
                    Text("Your grocery shopping experience made simple and affordable.")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top)
                        .shadow(radius: 5)

                    Spacer()

                    // Buttons in a vertical stack
                    VStack(spacing: 20) {
                        // Login Button with shadow
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                                .shadow(radius: 10)
                                .padding(.horizontal, 40)
                        }

                        // Register Button with shadow
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                                .shadow(radius: 10)
                                .padding(.horizontal, 40)
                        }
                    }

                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .previewDevice("iPhone 14 Pro") // Optional: Choose the device for the preview
            .preferredColorScheme(.light) // Preview in light mode for testing
    }
}
