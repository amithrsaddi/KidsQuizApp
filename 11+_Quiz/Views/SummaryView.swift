import SwiftUI

struct SummaryView: View {
    @ObservedObject var scoreSummary: ScoreSummary
    @ObservedObject var counter : Counter
    let title: String
    
    init(scoreSummary: ScoreSummary, title: String, counter: Counter) {
        self.scoreSummary = scoreSummary
        self.title = title
        self.counter = counter
    }
    
    private var items: [ListItem] {
        [
            ListItem(iconColor: .green, title: "Passed", count: scoreSummary.questions.filter { $0.passed }.count),
            ListItem(iconColor: .red, title: "Failed", count: scoreSummary.questions.filter { $0.failed }.count),
            ListItem(iconColor: .gray, title: "Skipped", count: scoreSummary.questions.filter { $0.skipped }.count),
            ListItem(iconColor: .yellow, title: "Unanswered", count: scoreSummary.questions.filter { $0.unanswered }.count),
            ListItem(iconColor: .cyan, title: "All", count: scoreSummary.questions.count)
        ]
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Score: \(scoreSummary.score)/\(scoreSummary.questions.count)")
                .font(.title3)
                .fontWeight(.bold)
            
            List(items) { item in
                NavigationLink(destination: ScoreSummaryView(questions: filteredQuestions(for: item.title), item: item)) {
                    HStack {
                        Circle()
                            .fill(item.iconColor)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "list.bullet")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                            )
                        
                        Text(item.title)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(item.count)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
            HStack{
                NavigationLink(destination: WelcomeView(counter: counter)) {
                    Text("Restart Quiz")
                        .padding(.leading, 10)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.leading, 10)
                        .fontWeight(.bold)
                }
                .padding()
                .opacity(0.8)
                .cornerRadius(10)
                .shadow(radius: 10)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.vertical, 5)
            }.padding(50)
        }
       //.navigationTitle("Summary") // Add navigation title to the VStack
    }
    
    private func filteredQuestions(for title: String) -> [QuizQuestion] {
        switch title {
        case "Passed":
            return scoreSummary.questions.filter { $0.passed }
        case "Failed":
            return scoreSummary.questions.filter { $0.failed }
        case "Skipped":
            return scoreSummary.questions.filter { $0.skipped }
        case "Unanswered":
            return scoreSummary.questions.filter { $0.unanswered }
        default: // "All"
            return scoreSummary.questions
        }
    }
}

struct ListItem: Identifiable {
    let id = UUID()
    let iconColor: Color
    let title: String
    let count: Int
}

