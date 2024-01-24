//
//  DetailView.swift
//  UnsplashApp
//
//  Created by Florian PICHON on 24/01/2024.
//
import SwiftUI

struct DetailView: View {
    let photo: UnsplashPhoto
    @State private var isDownloading = false

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.urls.raw)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Color.red
                } else {
                    ProgressView()
                }
            }
            Text("Author: \(photo.author?.name ?? "Unknown")")
                .font(.title)
                .padding()
            Button(action: downloadImage) {
                if isDownloading {
                    ProgressView()
                } else {
                    Text("Telecharger")
                    Image(systemName: "square.and.arrow.down")
                        .padding()
                        .foregroundColor(.white)
                        
                }
            }
        }
        .navigationTitle("Detail")
    }

    func downloadImage() {
        guard let url = URL(string: photo.urls.raw) else { return }
        isDownloading = true
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            DispatchQueue.main.async {
                isDownloading = false
            }
        }.resume()
    }
}
