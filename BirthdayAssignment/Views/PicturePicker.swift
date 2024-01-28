//
//  PicturePicker.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import SwiftUI
import PhotosUI

struct PicturePicker<Content>: View where Content : View {
    
    @Binding var selection: Data?
    var label: () -> Content
    
    @State private var isDialogPresented: Bool = false
    @State private var isCameraPresented: Bool = false
    @State private var isGalleryPresented: Bool = false
    @State private var photoItem: PhotosPickerItem?
    
    var body: some View {
        Button(
            action: { isDialogPresented = true },
            label: label
        )
        .confirmationDialog(
            "Choose a method",
            isPresented: $isDialogPresented,
            actions: {
                Button("Take a photo", action: { isCameraPresented = true })
                Button("Choose from gallery", action: { isGalleryPresented = true })
            }
        )
        .fullScreenCover(isPresented: $isCameraPresented) {
            #if targetEnvironment(simulator)
            VStack {
                Text("Camera cannot be presented on a simulator")
                Button("Dismiss", action: { isCameraPresented = false })
            }
            #else
            CameraView(selectedImage: $selection)
            #endif
        }
        .photosPicker(
            isPresented: $isGalleryPresented,
            selection: $photoItem,
            matching: .not(.videos)
        )
        .onChange(of: photoItem) {
            Task {
                selection = try? await photoItem?.loadTransferable(type: Data.self)
            }
        }
    }
}
