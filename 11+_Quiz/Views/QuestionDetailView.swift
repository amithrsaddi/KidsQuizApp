import SwiftUI

struct QuestionDetailView: View {
    var question: QuizQuestion // Assuming QuizQuestion model is defined elsewhere
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Q: \(question.question)")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(nil) // Allow unlimited lines
                .multilineTextAlignment(.leading) // Left align multiline textHI 
            
            ForEach(Array(question.options.enumerated()), id: \.element) { index, option in
                let prefix = String(UnicodeScalar("a".unicodeScalars.first!.value + UInt32(index))!)
                Text("\(prefix). \(option)")
                    .padding(.leading)
                    .foregroundColor(.black)
            }
            
            //Divider() // Optional: Adds a visual separation line
              //  .padding(.vertical, 10)
            
            // Display user answer
            // (Add your existing answer display and correctness check here)
            AnswerDetailView(question: question)
                .padding(.horizontal)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
        .padding(.bottom, 10)
    }
}
