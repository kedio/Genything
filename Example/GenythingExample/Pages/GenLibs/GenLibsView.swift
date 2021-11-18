import SwiftUI
import Trickery
import Genything

let generator = GenLibsScriptGenerator().generator

private func generateScript(context: Context) -> String {
    generator.generate(context: context)
}

struct GenLibsView: View {
    private let random: Bool

    @State var context: Context = .default
    @State var text: String = ""

    init(random: Bool = false) {
        self.random = random
    }

    var body: some View {
        VStack {
            Text(text)
                .padding(.vertical)
            Button("Again") {
                text = generateScript(context: context)
            }.padding(.vertical)
        }
        .padding()
        .navigationTitle("Gen-Libs")
        .onAppear {
            context = random ? .random : .default
            text = generateScript(context: context)
        }
    }
}

struct GenLibsView_Previews: PreviewProvider {
    static var previews: some View {
        GenLibsView()
    }
}


