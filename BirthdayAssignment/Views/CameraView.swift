//
//  CameraView.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: Data?

    @Environment(\.dismiss) fileprivate var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> CameraCoordinator {
        return CameraCoordinator(picker: self)
    }
}

class CameraCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var picker: CameraView
    
    init(picker: CameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? Data else { return }
        self.picker.selectedImage = selectedImage
        self.picker.dismiss()
    }
}
