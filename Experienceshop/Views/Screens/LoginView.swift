import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoggingIn: Bool = false

    @EnvironmentObject var authManager: AuthManager // Access AuthManager

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Title
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                // Email and Password Fields
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)

                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)

                // Error Message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding(.horizontal, 40)
                }

                // Login Button
                Button(action: loginUser) {
                    if isLoggingIn {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                }
                .disabled(isLoggingIn)

                Spacer()
            }
        }
        .navigationBarTitle("Log In", displayMode: .inline)
    }

    private func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }

        isLoggingIn = true
        errorMessage = ""

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoggingIn = false

            if let error = error {
                errorMessage = "Login failed: \(error.localizedDescription)"
                return
            }

            // Successful login; AuthManager will update the state automatically
        }
    }
}
