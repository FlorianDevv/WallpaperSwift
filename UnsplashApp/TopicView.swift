import SwiftUI

struct TopicView: View {
    let columns = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    @StateObject var feedState = FeedState()
    let slug: String

    var body: some View {
        ScrollView {
            Button(action: {
                Task {
                    await feedState.fetchTopicsPhoto(slug: slug)
                }
            }, label: {
                Text("Load...")
            })
            if let topics = feedState.topicPhoto {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(topics) { topic in
                        NavigationLink(destination: DetailViewTopic(photo: topic)) {
                            VStack {
                                
                                    AsyncImage(url: URL(string: topic.urls!.regular)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(height: 150)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                }
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
        .navigationTitle(slug)
    }
}
#Preview {
    TopicView(slug: "test")
}
