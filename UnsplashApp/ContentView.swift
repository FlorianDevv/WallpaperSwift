//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Florian PICHON on 23/01/2024.
//

import SwiftUI
extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
//let imageURLs: [String] = [
//    "https://images.unsplash.com/photo-1683009427666-340595e57e43?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MXwxfGFsbHwxfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1563473213013-de2a0133c100?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwyfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1490349368154-73de9c9bc37c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwzfHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1495379572396-5f27a279ee91?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw0fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1560850038-f95de6e715b3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw1fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MXwxfGFsbHw2fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1547327132-5d20850c62b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw3fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1492724724894-7464c27d0ceb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw4fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1475694867812-f82b8696d610?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHw5fHx8fHx8MXx8MTcwMzc1OTU1MXw&ixlib=rb-4.0.3&q=80&w=1080",
//    "https://images.unsplash.com/photo-1558816280-dee9521ff364?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzYyNDN8MHwxfGFsbHwxMHx8fHx8fDF8fDE3MDM3NTk1NTF8&ixlib=rb-4.0.3&q=80&w=1080"
//]

struct UnsplashTopic: Codable, Identifiable {
    let id: String
    let slug: String
    let cover_photo: UnsplashCoverPhotoUrls?
    let urls: UnsplashPhoto?
    
}

struct UnsplashTopicPhoto: Codable, Identifiable {
    let id: String?
    let slug: String
    let urls: UnsplashPhotoUrls?
    
}


struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    let author: User?
    let urls: UnsplashPhotoUrls
}
enum CodingKeys: String, CodingKey {
        case id
        case slug
        case title
        case author = "user"
        case url = "urls"
    }

struct UnsplashCoverPhotoUrls: Codable{
    let urls: UnsplashPhotoUrls
}


struct User: Codable {
    let name: String
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
struct ContentView: View {
    let columns = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    @StateObject var feedState = FeedState()

    var body: some View {
        NavigationView {
            ScrollView {
                Button(action: {
                    Task {
                        await feedState.fetchHomeFeed()
                        await feedState.fetchTopics(perpage: 3)
                    }
                }, label: {
                    Text("Load...")
                })
                // topic buttons navigation
                HStack {
                    if let topics = feedState.topics {
                        ForEach(topics) { topic in
                            NavigationLink(destination: (TopicView(slug: topic.slug))) {
                                VStack {
                                    AsyncImage(url: URL(string: topic.cover_photo!.urls.small)) { phase in
                                        if let image = phase.image {
                                            image.centerCropped().frame(width: 100, height:50)
                                        } else if phase.error != nil {
                                            Color.red
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .cornerRadius(12)
                                   
                                    Button(action: {
                                        
                                    }, label: {
                                        Text(topic.slug)
                                    })
                                }
                            }
                        }
                        .padding(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        ForEach(0..<3) { _ in
                            VStack {
                                Rectangle()
                                    .frame(width: 100, height: 50)
                                Text("Placeholder")
                            }
                            .redacted(reason: .placeholder)
                        }
                        .padding(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                if let homeFeed = feedState.homeFeed {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(homeFeed, id: \.id) { photo in
                            NavigationLink(destination: DetailView(photo: photo)) {
                                AsyncImage(url: URL(string: photo.urls.regular)) { phase in
                                    if let image = phase.image {
                                        image.centerCropped().frame(height: 150)
                                    } else if phase.error != nil {
                                        Color.red
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .cornerRadius(12)
                                
                                
                            }
                        }
                    }
                    .padding(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(0..<12) { _ in
                            RoundedRectangle(cornerRadius: 12)
                                .frame(height: 150)
                        }
                    }
                    .padding(.horizontal)
                    .redacted(reason: .placeholder)
                }
                    
            }
            
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    ContentView()
}
