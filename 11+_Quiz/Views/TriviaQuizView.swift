import SwiftUI


struct TriviaQuizView: View {
    @State private var selectedAnswer: String? = "Apple"
    
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Trivia Quiz")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Spacer()
                Text("1 out of 10")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Progress Bar
            ProgressView(value: 0.1)
                .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                .padding(.horizontal)
                .padding(.vertical, 10)
            
            // Question
            Text("Which company was established on April 1st, 1976 by Steve Jobs, Steve Wozniak and Ronald Wayne?")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.bottom, 20)
            
            // Options
            VStack(spacing: 10) {
                ForEach(["Apple", "Atari", "Microsoft", "Commodore"], id: \.self) { answer in
                    Button(action: {
                        selectedAnswer = answer
                    }) {
                        HStack {
                            Text(answer)
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                            if selectedAnswer == answer {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Next Button
            Button(action: {
                // Handle next action
            }) {
                Text("Next")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(UIColor.systemOrange).opacity(0.2).edgesIgnoringSafeArea(.all))
    }
}
