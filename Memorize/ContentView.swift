import SwiftUI

struct ContentView: View {
    @State var emojis1 = ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀" ] + ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀"]
    @State var emojis2 = ["🍎", "🍔", "🍟", "🍓", "🍿", "🍙", "🎂", "🧋"] + ["🍎", "🍔", "🍟", "🍓", "🍿", "🍙", "🎂", "🧋"]
    @State var emojis3 = ["✈️", "🚃", "🚕", "⛴️", "🚲", "🏍️", "🛺", "🏎️"] + ["✈️", "🚃", "🚕", "⛴️", "🚲", "🏍️", "🛺", "🏎️"]
    
    @State var cardCount = 16
    @State var themeNo = 3
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.system(size: 36))
                .foregroundStyle(.blue)
                .bold()
            cards
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))]) {
                Themes(content: "wineglass", label: "Halloween", highlight: themeNo == 1 ? true: false)
                    .onTapGesture {
                        themeNo = 1
                        emojis1.shuffle()
                    }
                Themes(content: "fork.knife.circle", label: "Food", highlight: themeNo == 2 ? true: false)
                    .onTapGesture {
                        themeNo = 2
                        emojis2.shuffle()
                    }
                Themes(content: "car", label: "Vehicles", highlight: themeNo == 3 ? true: false)
                    .onTapGesture {
                        themeNo = 3
                        emojis3.shuffle()
                    }
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .imageScale(.large)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 10) {
            ForEach(0..<cardCount, id: \.self) {
                index in CardView(content: themeNo == 1 ? emojis1[index]: themeNo == 2 ? emojis2[index]: emojis3[index]).aspectRatio(2/3, contentMode: .fit)
               
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 30)
        .foregroundColor(.blue)
    }
}

struct Themes: View {
    let content: String
    let label: String
    let highlight: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image(systemName: content)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 30))
                .frame(height: 30)
            Text(label)
                .font(.system(size: 20))
        }
        .frame(minWidth: 100)
        .foregroundColor(highlight ? .blue : colorScheme == .light ? .black : .white
        )
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base
                Text(content).font(.largeTitle).hidden()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
