import SwiftUI
import Trickery
import Genything

struct Contact: Identifiable {
    let id: UUID = UUID()
    let name: String
    let phoneNumber: String
}

struct PhoneBookCell: View {
    let contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.name)
                .font(.title)
            Text(contact.phoneNumber)
                .font(.subheadline)
        }
    }
}

struct PhoneBook: View {
    private let random: Bool
    private let contactGen = Gen.zip(
        Fake.PersonNames.full,
        Fake.PhoneNumbers.formatted
    ) {
        Contact(name: $0, phoneNumber: $1)
    }

    @State var context: Context = .default
    @State var data: [Contact] = []

    init(random: Bool = false) {
        self.random = random
    }
    
    var body: some View {
        List {
            ForEach(data){ contact in
                PhoneBookCell(contact: contact)
            }
        }
        .navigationTitle("Contacts")
        .onAppear {
            context = random ? .random : .default
            data = contactGen.take(count: 50, context: context)
        }
    }
}

struct PhoneBook_Previews: PreviewProvider {
    static var previews: some View {
        PhoneBook()
    }
}


