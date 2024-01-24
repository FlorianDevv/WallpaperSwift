//
//  DetailView.swift
//  UnsplashApp
//
//  Created by Florian PICHON on 24/01/2024.
//

import SwiftUI
struct DetailViewTopic: View {
    let photo: UnsplashTopicPhoto

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.urls!.raw)) { phase in
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
            
//            Text("Author: \(photo.author?.name ?? "Unknown")")
//                .font(.title)
//                .padding()
        }
        .navigationTitle("Detail")
    }
}
