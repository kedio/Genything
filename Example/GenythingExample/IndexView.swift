import SwiftUI
import Genything

private enum Destination: String, CaseIterable, Identifiable {
    case phoneBook
    case businessList
    case genLibs
    case shapeDrawing
    
    var id: String {
        rawValue
    }
    
    var title: String {
        rawValue.capitalized
    }
}

struct IndexView: View {
    var body: some View {
        NavigationView {
            List {
                SeededSection(title: "Seed: 0", random: false)
                SeededSection(title: "Seed: random", random: true)
            }
            .navigationTitle("Examples")
        }
    }
}

struct SeededSection: View {
    let title: String
    let random: Bool

    var body: some View {
        Section(header: Text(title)) {
            ForEach(Destination.allCases) { destination in
                NavigationLink(destination: {
                    switch destination {
                        case .phoneBook: PhoneBook(random: random)
                        case .businessList: BusinessListView(random: random)
                        case .genLibs: GenLibsView(random: random)
                        case .shapeDrawing: ShapeDrawing(random: random)
                    }
                }) {
                    Text(destination.title)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
