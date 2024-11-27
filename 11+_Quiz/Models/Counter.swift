import SwiftUI

class Counter: ObservableObject {
    @Published var questionCount: Int = 10
    @Published var timerCount: Int = 5
}





//
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            ViewA() // Start with ViewA
//        }
//    }
//}
//
//struct ViewA: View {
//    var body: some View {
//        NavigationLink(destination: ViewB()) {
//            Text("Go to View B")
//                .padding()
//        }
//        .navigationTitle("View A")
//    }
//}
//
//struct ViewB: View {
//    var body: some View {
//        VStack {
//            NavigationLink(destination: ViewC()) {
//                Text("Go to View C")
//                    .padding()
//            }
//            .navigationTitle("View B")
//        }
//    }
//}
//
//struct ViewC: View {
//    var body: some View {
//        Text("This is View C")
//            .navigationTitle("View C")
//    }
//}
//
//@main
//struct MyApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView() // Main entry point
//        }
//    }
//}
