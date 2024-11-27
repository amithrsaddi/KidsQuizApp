import SwiftUI

struct ContentView: View {
    
    @ObservedObject var counter = Counter()
    var body: some View {
        TabView {
            NavigationView {
                WelcomeView(counter: counter)
            }
            .tabItem {
                Image(systemName: "doc.text.fill")
                Text("Practise")
            }
            
            NavigationView {
                ExamView()
            }
            .tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Exam")
            }
            
            NavigationView {
                HistoryView()
            }
            .tabItem {
                Image(systemName: "clock")
                Text("History")
            }
        
            
            NavigationView {
                SettingsView(counter: counter)
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
        .accentColor(.blue) // Customize active tab color
    }
}
