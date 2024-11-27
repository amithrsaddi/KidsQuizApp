import SwiftUI

struct WelcomeView: View {
    @ObservedObject var counter : Counter
    
    // Explicit initializer
    init(counter: Counter) {
        self.counter = counter
    }
    
    @State private var selectedValue: String = "10" // Initialize with a default value
    private var options: [String] = ["10", "20", "30", "40", "50"] // Options array
    
    private var mathTopicItems: [Topic] {
        [
            Topic(title: "Decimals", subject: "Maths"),
            Topic(title: "Fractions", subject: "Maths"),
            Topic(title: "Random", subject: "Maths")
        ]
    }
    
    private var englishTopicItems: [Topic] {
        [
            Topic(title: "Synonyms", subject: "English"),
            Topic(title: "Antonyms", subject: "English"),
            Topic(title: "Random", subject: "English")
        ]
    }
    
    private var subjectItems: [(title: String, topics: [Topic], color: Color)] {
        [
            (title: "Maths", topics: mathTopicItems, color: .blue),
            (title: "English", topics: englishTopicItems, color: .green)
        ]
    }
    
    var body: some View {
        VStack {
            Text("Practise Quiz!")
                .font(.largeTitle)
                .padding(.vertical, 40)
            
//            //Spacer()
//            Text("Qquestions Count: \(counter.questionCount)")
//                .font(.title)
//                .padding()
            
            
            Text("Choose Subject:")
                .font(.title)
                .padding()
            
            List {
                ForEach(subjectItems, id: \.title) { item in
                    NavigationLink(destination: SubjectView(topicItems: item.topics, counter: counter)) {
                        HStack {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Image(systemName: "message.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold))
                                )
                            
                            Text(item.title)
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.primary)
                        }
                        //.padding()  // Add padding around the HStack
                        //.background(Color.blue.opacity(0.1))  // Light blue background for each item
                        //.cornerRadius(8)  // Rounded corners
                        .padding(.vertical, 4)  // Additional spacing between items
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}
