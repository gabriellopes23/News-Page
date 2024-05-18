
import SwiftUI

struct SearchView: View {
    @State var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    @State var searchText = ""
    var body: some View {
        HStack {
            HStack {
                TextField("Search for news", text: $searchText, onCommit: {
                    newsPageVM.getNews(query: searchText)
                })
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.red)
            }
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
            )
        }
        .padding()
    }
}

struct SearchCategory: View {
    @State var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    @State var searchText = ""
    var body: some View {
        HStack {
            HStack {
                TextField("Search for Category", text: $searchText, onCommit: {
                    newsPageVM.getNewsByCategory(category: searchText)
                })
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.red)
            }
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
            )
        }
        .padding()
    }
}



#Preview {
    SearchView()
}
