import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistering: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.pink]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                // Input Fields
                Group {
                    TextField("First Name", text: $firstName)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    TextField("Last Name", text: $lastName)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    TextField("Address", text: $address)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }

                // Error Message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding(.horizontal, 40)
                }

                // Register Button
                Button(action: registerUser) {
                    if isRegistering {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
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

    private func registerUser() {
        guard !firstName.isEmpty, !lastName.isEmpty, !phoneNumber.isEmpty, !address.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        isRegistering = true
        errorMessage = ""

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                isRegistering = false
                errorMessage = "Registration failed: \(error.localizedDescription)"
                return
            }

            guard let userId = authResult?.user.uid else {
                isRegistering = false
                errorMessage = "Failed to retrieve user ID."
                return
            }

            let user = User(
                id: userId,
                firstName: firstName,
                lastName: lastName,
                address: address,
                phoneNumber: phoneNumber,
                email: email
            )

            let firestore = Firestore.firestore()
            firestore.collection("users").document(userId).setData(user.toDictionary()) { error in
                isRegistering = false
                if let error = error {
                    errorMessage = "Failed to save user info: \(error.localizedDescription)"
                } else {
                    errorMessage = "Registration successful!"
                }
            }
        }
    }

    
}
