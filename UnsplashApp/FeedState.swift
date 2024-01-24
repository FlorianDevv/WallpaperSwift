import SwiftUI

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]?
    @Published var topics: [UnsplashTopic]?
    @Published var topicPhoto: [UnsplashTopicPhoto]?
    func fetchHomeFeed() async {
    guard let url = feedUrl() else {
        print("Invalid URL")
        return
    }

    do {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
        homeFeed = deserializedData
    } catch {
        print("Error: \(error)")
    }
}
    
    func fetchTopics(perpage: Int) async {
            guard let url = topicsUrl(perPage: perpage) else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let topics = try JSONDecoder().decode([UnsplashTopic].self, from: data)
                DispatchQueue.main.async {
                    self.topics = topics
                }
            } catch {
                print("Failed to fetch topics: \(error)")
            }
        }
    
    func fetchTopicsPhoto(slug: String) async {
            guard let url = topicsPhotos(slug: slug) else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let topicsPhoto = try JSONDecoder().decode([UnsplashTopicPhoto].self, from: data)
                DispatchQueue.main.async {
                    self.topicPhoto = topicsPhoto
                }
                print( "topics: \(topicsPhoto)")
            } catch {
                print("Failed to fetch topics: \(error)")
            }
        }
}


