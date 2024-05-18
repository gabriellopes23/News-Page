import Foundation


// MARK: - NewsPageModel
struct NewsPageModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
      
    
    static func defaultNewsPage() -> NewsPageModel {
        return NewsPageModel(
            status: "Ok",
            totalResults: 14408,
            articles: [Article(
                source: Source(id: "wired", name: "Wired"),
                author: "Andy Greenberg",
                title: "A Vast New Dataset Could Supercharge the AI Hunt for Crypto Money Laundering",
                description: "Blockchain analysis firm Elliptic, MIT, and IBM, have released a new AI detection model—and the 200-million-transaction dataset it's trained on—that aims to spot the “shape” of Bitcoin money laundering.",
                url: "https://www.wired.com/story/ai-crypto-tracing-model-money-laundering/",
                urlToImage: "https://media.wired.com/photos/6631a1936dc0c77846852ed5/191:100/w_1280,c_limit/Crypto-Money-Laundering-Security-GettyImages-1543076825.jpg",
                publishedAt: "2024-05-01T13:00:00Z",
                content: "As a test of their resulting AI tool, the researchers checked its outputs with one cryptocurrency exchangewhich the paper doesn't nameidentifying 52 suspicious chains of transactions that had all ult… [+3279 chars]")])
    }
}

struct Article: Codable {
    let source: Source
    let author, title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    var id: String?
    var name: String?
}
