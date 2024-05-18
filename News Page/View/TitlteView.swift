
import SwiftUI

struct TitlteView: View {
    var body: some View {
        HStack(spacing: 3) {
            Text("GSL")
                .foregroundStyle(.red)
            Text("NEWS")
            
            Spacer()
        }
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding()
    }
}

#Preview {
    TitlteView()
}
