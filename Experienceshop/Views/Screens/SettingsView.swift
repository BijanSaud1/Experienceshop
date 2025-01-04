import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SettingsView: View {
    @EnvironmentObject var authManager: AuthManager

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var email: String = ""
    @State private var errorMessage: String = ""
    @State private var isUpdating: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .padding()

            VStack(spacing: 15) {
                TextField("First Name", text: $firstName)
                    .textFieldStyle()

                TextField("Last Name", text: $lastName)
                    .textFieldStyle()

                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle()

                TextField("Address", text: $address)
                    .textFieldStyle()

                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textFieldStyle()
                    .disabled(true)
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }

            Button(action: updateUserInfo) {
                if isUpdating {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Update Information")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)

            Button(action: {
                authManager.logout()
            }) {
                Text("Log Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .onAppear(perform: loadUserInfo)
    }

    private func loadUserInfo() {
        guard let userId = authManager.currentUser?.uid else { return }
        let firestore = Firestore.firestore()

        firestore.collection("users").document(userId).getDocument { snapshot, error in
            if let error = error {
                errorMessage = "Failed to load user info: \(error.localizedDescription)"
                return
            }

            guard let data = snapshot?.data(),
                  let user = User(from: data) else {
                errorMessage = "Failed to load user info."
                return
            }

            firstName = user.firstName
            lastName = user.lastName
            phoneNumber = user.phoneNumber
            address = user.address
            email = user.email
        }
    }

    private func updateUserInfo() {
        guard let userId = authManager.currentUser?.uid else { return }
        isUpdating = true

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
            isUpdating = false
            if let error = error {
                errorMessage = "Failed to update user info: \(error.localizedDescription)"
            } else {
                errorMessage = "User information updated successfully!"
            }
        }
    }
}

extension View {
    func textFieldStyle() -> some View {
        self
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .padding(.horizontal, 40)
    }
}
