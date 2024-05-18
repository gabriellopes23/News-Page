
import SwiftUI

struct NewsListView: View {
    @StateObject var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    @EnvironmentObject var savedNewsVM: SavedNewsViewModel
    
    var body: some View {
        NavigationView {
            List(newsPageVM.newsPageMode.articles.indices, id: \.self) { i in
                let article = newsPageVM.newsPageMode.articles[i]
                
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
                    .environmentObject(savedNewsVM)
                }, label: {
                    NewsRowView(title: article.title ?? "", description: article.description ?? "", imageUrl: article.urlToImage, category: article.source.name ?? "", date: article.publishedAt)
                })
            }
            .listStyle(.plain)
        }
        .environmentObject(savedNewsVM)
    }
    
}

struct NewsPageInformation: View {
    @StateObject var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    @StateObject var savedNewsVM: SavedNewsViewModel = SavedNewsViewModel()
    @State var isSaved: Bool = false
    
    let imageUrl: String?
    let title: String?
    let author: String?
    let date: String
    let description: String
    let content: String
    let url: String
    let source: (id: String?, name: String?)
    
    var dateString: String {
        date.formattedDateFromISO8601()
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineSpacing(-3)
                    
                    HStack {
                        Text(author ?? "")
                        Text(dateString)
                    }
                    .font(.caption)
                    .fontWeight(.thin)
                }
                
                ImageUrl(newsPageVM: newsPageVM, imageUrl: imageUrl, width: 320, height: 200)
                
                Text(description)
                    .font(.footnote)
                
                Text(content)
                
                Link(
                    destination: URL(string: url)!, label: {
                        Text("For more Information, Click Here")
                            .padding(8)
                            .overlay(
                                Capsule()
                                    .stroke(lineWidth: 2))
                    })
                
            }
            .padding()
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    let article = Article(
                        source: Source(id: source.id, name: source.name),
                        author: author,
                        title: title,
                        description: description,
                        url: url,
                        urlToImage: imageUrl,
                        publishedAt: date,
                        content: content)
                    savedNewsVM.saveArticle(article)
                    if isSaved {
                        savedNewsVM.removeArticle(article)
                    } else {
                        savedNewsVM.saveArticle(article)
                    }
                    isSaved.toggle()
                }, label: {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(.red)
                })
            }
        }
        .onAppear {
            checkIfArticleIsSaved()
        }
    }
    
    private func checkIfArticleIsSaved() {
        let article = Article(
            source: Source(id: source.id, name: source.name),
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: imageUrl,
            publishedAt: date,
            content: content)
        isSaved = savedNewsVM.savedArticles.contains(where: { $0.url == article.url })
    }
}

#Preview {
    NewsPageInformation(
        imageUrl: "https://media.wired.com/photos/6631a1936dc0c77846852ed5/191:100/w_1280,c_limit/Crypto-Money-Laundering-Security-GettyImages-1543076825.jpg",
        title: "A Vast New Dataset Could Supercharge the AI Hunt for Crypto Money Laundering",
        author: "Andy Greenberg",
        date: "2024-05-01T13:00:00Z",
        description: "Blockchain analysis firm Elliptic, MIT, and IBM, have released a new AI detection model—and the 200-million-transaction dataset it's trained on—that aims to spot the “shape” of Bitcoin money laundering.",
        content: "As a test of their resulting AI tool, the researchers checked its outputs with one cryptocurrency exchangewhich the paper doesn't nameidentifying 52 suspicious chains of transactions that had all ult… [+3279 chars]",
        url: "https://www.wired.com/story/ai-crypto-tracing-model-money-laundering/", source: (id: "wired", name: "wired"))
    .environmentObject(SavedNewsViewModel())
}
