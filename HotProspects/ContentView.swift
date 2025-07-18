//
//  ContentView.swift
//  HotProspects
//
//  Created by Carlos Eduardo Witte on 17/06/25.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    @State private var output: String = "Blah"
    @State private var backgroundColor: Color = .red
    
    var results: String {
        let selected = possibleNumbers.random(6).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    let possibleNumbers = 1...60
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contact", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
    
    func fetchReadings() async {
        output = "Hello, World!"
        
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            // debug
            //            print(readings)
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
