
import Foundation

class SavedNewsViewModel: ObservableObject {
    @Published var savedArticles: [Article] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init() {
        loadFromUserDefaults()
    }
    
    func saveArticle(_ article: Article) {
        if !savedArticles.contains(where: { $0.url == article.url}) {
            savedArticles.append(article)
        }
    }
    
    func removeArticle(_ article: Article) {
        if let index = savedArticles.firstIndex(where: { $0.url == article.url }) {
                    savedArticles.remove(at: index)
                }
    }
    
    func removeArticleIndex(at index: Int) {
            savedArticles.remove(at: index)
        }
    
    private func saveToUserDefaults() {
        do {
            let data = try JSONEncoder()
                .encode(savedArticles)
            UserDefaults.standard.set(data, forKey: "savedArticles")
        } catch {
            print(error)
        }
    }
    
    private func loadFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: "savedArticles") else { return }
        do {
            savedArticles = try JSONDecoder().decode([Article].self, from: data)
        } catch {
            print(error)
        }
    }
}
