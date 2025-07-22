//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Carlos Eduardo Witte on 22/07/25.
//

import SwiftUI

struct EditProspectView: View {
    
    @State var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            Form {
                Section(footer: Text("Changes are saved automatically.")) {
                    TextField("Name", text: $prospect.name)
                    TextField("Email", text: $prospect.emailAddress)
                }
            }
            .navigationTitle("Edit " + prospect.name)
        }
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "Test", emailAddress: "test@test.com"))
}
