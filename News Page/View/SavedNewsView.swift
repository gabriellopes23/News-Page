
import SwiftUI

struct SavedNewsView: View {
    @EnvironmentObject var savedNewsVM: SavedNewsViewModel
    
    var body: some View {
        List(savedNewsVM.savedArticles.indices, id: \.self) { i in
            let article = savedNewsVM.savedArticles[i]
            
            NavigationLink(destination: {
                NewsPageInformation(
                    imageUrl: article.urlToImage,
                    title: article.title ?? "",
                    author: article.author ?? "",
                    date: article.publishedAt,
                    description: article.description ?? "",
                    content: article.content ?? "",
                    url: article.url,
                    source: (id: article.source.id, name: article.source.name))
                
            }, label: {
                NewsRowView(title: article.title ?? "", description: article.description ?? "", imageUrl: article.urlToImage, category: article.source.name ?? "", date: article.publishedAt)
            })
            .listStyle(.plain)
            .navigationTitle("Saved News")
        }
    }
}

struct IconSavedNewsView: View {
    @EnvironmentObject var savedNewsVM: SavedNewsViewModel
    
    var body: some View {
        NavigationLink(destination: {
            SavedNewsView()
                .environmentObject(savedNewsVM)
        }, label: {
            Image(systemName: "bookmark")
                .foregroundStyle(.red)
        })
        .padding()
    }
}

#Preview {
    IconSavedNewsView()
        .environmentObject(SavedNewsViewModel())
}
