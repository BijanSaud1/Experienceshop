import FirebaseFirestore

class FirestoreManager {
    private let db = Firestore.firestore()

    // Save User Info to Firestore
    func saveUserInfo(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(user.id).setData(user.toDictionary()) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Fetch User Info from Firestore
    func fetchUserInfo(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        let userDoc = db.collection("users").document(userId)
        userDoc.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let document = document, document.exists,
                  let data = document.data(),
                  let user = User(from: data) else {
                completion(.failure(NSError(domain: "User Not Found", code: 404, userInfo: nil)))
                return
            }

            completion(.success(user))
        }
    }
}
