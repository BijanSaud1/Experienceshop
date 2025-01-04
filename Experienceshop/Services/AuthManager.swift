//
//  nothing.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/3/25.
//

import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var currentUser: FirebaseAuth.User? // Tracks the currently authenticated user

    private let auth = Auth.auth()

    init() {
        listenToAuthState()
    }

    // Listen to Firebase Authentication State
    private func listenToAuthState() {
        auth.addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.currentUser = user
        }
    }

    // Register a new user
    func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }

    // Log in an existing user
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }

    // Log out the current user
    func logout() {
        do {
            try auth.signOut()
            currentUser = nil
        } catch {
            print("Failed to log out: \(error.localizedDescription)")
        }
    }
}
