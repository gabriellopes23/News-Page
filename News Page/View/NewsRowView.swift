
import SwiftUI

struct NewsRowView: View {
    @State var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    let title: String
    let description: String
    let imageUrl: String?
    let category: String
    let date: String
    
    var dateString: String {
        date.formattedDateFromISO8601()
    }
    
    var body: some View {
        /*HStack(spacing: 5) {
            ImageUrl(imageUrl: imageUrl, width: 80, height: 80)
            
            VStack(spacing: 9) {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .lineSpacing(-1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(description)
                    .font(.caption2)
                    .lineLimit(2)
            }
            .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
        */
        
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(category.capitalized)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
                
                Text(dateString)
                    .font(.subheadline)
            }
            Spacer()
            ImageUrl(newsPageVM: newsPageVM, imageUrl: imageUrl, width: 100, height: 100)
        }
        .padding(.horizontal)
        
    }
}

struct ImageUrl: View {
    @State var newsPageVM: NewsPageViewModel = NewsPageViewModel()
    var imageUrl: String?
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if let imageUrlString = imageUrl,
           let imageUrl = URL(string: imageUrlString) {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: width, height: height)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: width, height: height)
                        .aspectRatio(contentMode: .fill)
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    NewsRowView(title: "A Vast New Dataset Could Supercharge the AI Hunt for Crypto Money Laundering", description: "Blockchain analysis firm Elliptic, MIT, and IBM, have released a new AI detection model—and the 200-million-transaction dataset it's trained on—that aims to spot the “shape” of Bitcoin money laundering.", imageUrl: "https://media.wired.com/photos/6631a1936dc0c77846852ed5/191:100/w_1280,c_limit/Crypto-Money-Laundering-Security-GettyImages-1543076825.jpg", category: "werid", date: "2024-05-01T13:00:00Z")
    
}
