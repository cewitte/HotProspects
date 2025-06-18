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
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    let possibleNumbers = 1...60
    
    
    var body: some View {
        Image(.example)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
        
        List(users, id:\.self, selection: $selection) { user in
            Text(user)
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Deleting")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
        
        Text("Hello, color!")
            .padding()
            .background(backgroundColor)
        
        Text("Change Color")
            .padding()
            .contextMenu {
                Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                    backgroundColor = .red
                }
                
                Button("Green") {
                    backgroundColor = .green
                }
                
                Button("Blue") {
                    backgroundColor = .blue
                }
            }
        
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
        
        Text(results)
        
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
