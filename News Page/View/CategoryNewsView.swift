
import SwiftUI

struct CategoriesView: View {
    let categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    var body: some View {
        NavigationView {
            List(categories, id: \.self) { category in
                NavigationLink(destination: CategoryNewsView(category: category)) {
                    Text(category.capitalized)
                }
            }
            .navigationTitle("Explore Categories")
        }
    }
}

struct CategoryNewsView: View {
    var category: String
    @StateObject var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    
    var body: some View {
        VStack {
                   List(newsPageVM.newsPageMode.articles) { article in
                       NewsRowView(
                        newsPageVM: newsPageVM,
                        title: article.title ?? "",
                        description: article.description ?? "",
                        imageUrl: article.urlToImage,
                        category: article.source.name ?? "",
                        date: article.publishedAt)
                   }
               }
               .onAppear {
                   newsPageVM.getNewsByCategory(category: category)
               }
               .navigationTitle(category.capitalized)
    }
}

extension Article: Identifiable {
    var id: String {
        return url
    }
}

struct IconCategoryView: View {
    @StateObject var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    
    var body: some View {
        NavigationLink(destination: {
            CategoriesView()
        }, label: {
            Image(systemName: "square.grid.2x2")
                .foregroundStyle(.red)
        })
        .padding()
    }
}

//#Preview {
//    CategoryView(category: NewsPageModel.defaultNewsPage())
//}
