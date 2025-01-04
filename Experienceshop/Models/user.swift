//
//  nothing.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/3/25.
//
struct User {
    let id: String
    let firstName: String
    let lastName: String
    let address: String
    let phoneNumber: String
    let email: String

    // Custom initializer to convert from Firestore dictionary
    init?(from dictionary: [String: Any]) {
        guard
            let id = dictionary["id"] as? String,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let address = dictionary["address"] as? String,
            let phoneNumber = dictionary["phoneNumber"] as? String,
            let email = dictionary["email"] as? String
        else {
            return nil
        }

        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.phoneNumber = phoneNumber
        self.email = email
    }

    // Explicit memberwise initializer
    init(id: String, firstName: String, lastName: String, address: String, phoneNumber: String, email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.phoneNumber = phoneNumber
        self.email = email
    }

    // Convert User instance to Firestore dictionary
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "address": address,
            "phoneNumber": phoneNumber,
            "email": email
        ]
    }
}
