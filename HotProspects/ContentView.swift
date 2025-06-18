//
//  ContentView.swift
//  HotProspects
//
//  Created by Carlos Eduardo Witte on 17/06/25.
//

import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    @State private var output: String = "Blah"
    
    var body: some View {
        List(users, id:\.self, selection: $selection) { user in
            Text(user)
        }
        
        if !selection.isEmpty {
            Text("You selected: \(selection.formatted())")
        }
        
        Text(output)
            .task {
                await fetchReadings()
            }
        
        EditButton()
    }
    
    func fetchReadings() async {
        output = "Hello, World!"
        
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            print(readings)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        do {
            output = try result.get()
        } catch {
            output = "Error \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
