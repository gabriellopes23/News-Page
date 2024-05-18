
import Foundation
import Observation


class NewsPageViewModel: ObservableObject {
    @Published var newsPageMode: NewsPageModel = NewsPageModel.defaultNewsPage()
    
    private var apiKey = ""
    
    func getNews(query: String) {
        let urlString = "https://newsapi.org/v2/everything?q=\(query)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            do {
                let newNewsPageModel = try jsonDecoder.decode(NewsPageModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.newsPageMode = newNewsPageModel
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getNewsByCategory(category: String) {
        let urlString = "https://newsapi.org/v2/top-headlines?category=\(category)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            do {
                let newNewsPageModel = try jsonDecoder.decode(NewsPageModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.newsPageMode = newNewsPageModel
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
