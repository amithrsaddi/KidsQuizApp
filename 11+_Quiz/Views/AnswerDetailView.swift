import SwiftUI

struct AnswerDetailView: View {
    var question: QuizQuestion
    
    var body: some View {
        VStack(alignment: .leading){
            HStack()  {
                if let userAnswer = question.userAnswer {
                    Text(userAnswer == question.answer ? "✓" : "✗")
                        .foregroundColor(userAnswer == question.answer ? .green : .red)
                        .fontWeight(.bold)
                    Text("Your Answer: ")
                        .font(.subheadline)
                        .foregroundColor(.black) +
                    Text(userAnswer)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else {
                    Text("Your Answer: ")
                        .font(.subheadline).foregroundColor(.black) +
                    Text("Skipped")
                        .font(.subheadline)
                        .fontWeight(.bold).foregroundColor(.black)
                }
            }
            
            HStack  {
                Text("✓")
                    .foregroundColor(.green)
                
                Text("Correct: ")
                    .font(.subheadline).foregroundColor(.blue) +
                Text(question.answer)
                    .font(.subheadline)
                    .fontWeight(.bold).foregroundColor(.blue)
            }
        }.padding(.top, 20)
    }
}
