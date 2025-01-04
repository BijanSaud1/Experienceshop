//
//  ActivityView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/3/25.
//
import SwiftUI
import UIKit

struct ActivityContentView: View {
    @State private var image: UIImage? = nil
    @State private var isPickerPresented: Bool = false
    @State private var recognizedItem: String = "No item recognized yet."

    var body: some View {
        VStack {
            Text("Capture an Item")
                .font(.largeTitle)
                .padding()

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("No Image Captured")
                    .foregroundColor(.gray)
            }

            Button(action: { isPickerPresented = true }) {
                Text("Take Photo")
            }
            .padding()

            Text("Recognized Item: \(recognizedItem)")
                .padding()

            Spacer()
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(selectedImage: $image, onImageRecognized: recognizeItem)
        }
    }

    private func recognizeItem(image: UIImage?) {
        guard let image = image else { return }
        // Use ML model or Firebase Vision to recognize the item
        recognizedItem = "Sample Item Name" // Replace with ML output
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    let onImageRecognized: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
                parent.onImageRecognized(uiImage)
            }
            picker.dismiss(animated: true)
        }
    }
}

