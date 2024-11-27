
import SwiftUI

struct SubjectView: View {
    @ObservedObject var counter : Counter
    var topicItems: [Topic]
    
    init(topicItems: [Topic], counter: Counter) {
        self.topicItems = topicItems
        self.counter = counter
    }
    
    var body: some View {
        VStack {
            Text(topicItems.first?.subject ?? "Subject")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Choose topic")
                .font(.title)
                .padding()
            
            List {
                ForEach(topicItems) { item in
                    NavigationLink(destination: QuizView(quizSubject: item.subject, quizTopic: item.title, counter: counter)) {
                        HStack {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold))
                                )
                            
                            Text(item.title)
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(PlainListStyle())
            //.navigationTitle("Topics")
        }
    }
}


