import SwiftUI

struct MainView: View {
    @StateObject var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    @StateObject var savedNewsVM: SavedNewsViewModel = SavedNewsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TitlteView()
                    HStack(spacing: 0) {
                        IconSavedNewsView()
                            .environmentObject(savedNewsVM)
                        IconCategoryView()
                    }
                }
                
                SearchView(newsPageVM: newsPageVM, searchText: "")
                
                NewsListView(newsPageVM: newsPageVM)
                    .environmentObject(savedNewsVM)
                Spacer()
            }
        }
        .onAppear {
            newsPageVM.getNews(query: "latest")
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SavedNewsViewModel())
}
