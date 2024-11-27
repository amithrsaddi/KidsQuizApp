import SwiftUI
import AVKit

struct QuizView: View {
    @ObservedObject var counter : Counter
    let quizSubject: String
    let quizTopic: String
    
    init(quizSubject: String, quizTopic: String, counter: Counter) {
        self.quizSubject = quizSubject
        self.quizTopic = quizTopic
        self.counter = counter
        
        timeRemaining = counter.timerCount * 60
    }
    
    @State private var questions: [QuizQuestion] = []
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var isCompleted = false
    @State private var selectedAnswer: String?
    @State private var timeRemaining: Int
    @State private var isAborted = false // State to control navigation
    @State private var questionsAnswered = 0
    @State private var questionsSkipped = 0
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        
        VStack {
            if isCompleted {
                let scoreSummary = ScoreSummary(score: score, questions: questions)
                if isAborted {
                    Text("😢")
                        .font(.system(size: 160))
                        .transition(.scale)
                        .onAppear {
                            // Trigger thumbs down animation
                        }
                } else {
                    Text("🎆")
                        .font(.system(size: 160))
                        .transition(.scale)
                        .onAppear {
                            // Trigger fireworks animation
                        }
                }
                
                
                NavigationLink(destination: SummaryView(scoreSummary: scoreSummary, title: isAborted ? "Quiz Aborted!" : "Quiz Completed!", counter: counter)) {
                    VStack(alignment: .center, spacing: 10) {
                        Text(isAborted ? "Quiz Aborted!" : "Quiz Completed!")
                            .padding(.leading, 10)
                            .font(.system(size: 42))
                            .fontWeight(.bold)
                            .foregroundColor(isAborted ? .red : .green)
                        Text("Tap here to show summary")
                            .padding(.leading, 10)
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.vertical, 5)
                }
            } else {
                if currentQuestionIndex < questions.count {
                    HStack {
                        Text("\(quizSubject) Quiz")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(currentQuestionIndex + 1) of \(questions.count)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    ProgressView(value: Float(currentQuestionIndex + 1), total: Float(questions.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    
                    Text("\(currentQuestionIndex + 1). \(questions[currentQuestionIndex].question)")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                        .padding(.leading, 25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 15)
                        .padding(.bottom, 15)
                        .onTapGesture {
                            alertMessage = questions[currentQuestionIndex].question
                            showAlert = true
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Question"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    
                    VStack(spacing: 10) {
                        ForEach(questions[currentQuestionIndex].options, id: \.self) { answer in
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
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 2)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                if currentQuestionIndex > 0 {
                                    currentQuestionIndex -= 1 // Go to the previous question
                                    selectedAnswer = questions[currentQuestionIndex].userAnswer // Load the user's answer if it exists
                                    selectAnswer(selectedAnswer ?? "")
                                }
                            }) {
                                Text("Previous")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(currentQuestionIndex == 0 ? Color.gray : Color.blue)
                                    .cornerRadius(8)
                            }
                            .disabled(currentQuestionIndex == 0) // Disable if on the first question
                            
                            Button(action: {
                                // Handle the next action only if an answer is selected
                                if let selectedAnswer = selectedAnswer {
                                    selectAnswer(selectedAnswer)
                                    moveToNextQuestion() // Move to the next question on tapping
                                }
                            }) {
                                Text("Next")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedAnswer == nil ? Color.gray : Color.orange)
                                    .cornerRadius(8)
                            }
                            .disabled(selectedAnswer == nil) // Disable button if no answer is selected
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    
                    HStack {
                        abortButtonView
                        Spacer()
                        if currentQuestionIndex < questions.count - 1 {
                            skipButtonView
                        }
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    Text("Time Remaining: \(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
                        .font(.system(size: 24))
                        .padding(.top, 50)
                }
            }
        }
        .padding()
        .onAppear {
            loadQuestions()  // Load questions when the view appears
            startTimer()
        }
    }
    
    var abortButtonView: some View {
        Button(action: {
            isAborted = true
            abortTest()
        }) {
            Text("Abort Test")
                .font(.system(size: 18))
                .padding(8)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(5)
        }
    }
    
    var skipButtonView: some View {
        Button(action: skipQuestion) {
            Text("Skip Question")
                .font(.system(size: 18))
                .padding(8)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(5)
        }
        .padding(.trailing, 10)
    }
    
    func loadQuestions() {
        // Load questions based on the quiz type
        let allquestions = Parser().loadQuestionsFromJson(for: quizSubject, for: quizTopic)
        let uniqueQuestions = Array(Set(allquestions))
        let shuffledQuestions = uniqueQuestions.shuffled()
        questions = Array(shuffledQuestions.prefix(counter.questionCount))
    }
    
    func skipQuestion() {
        questions[currentQuestionIndex].userAnswer = "Skipped"
        questions[currentQuestionIndex].skipped = true;
        questions[currentQuestionIndex].unanswered = false
        currentQuestionIndex += 1  // Move to the next question
        questionsSkipped += 1
    }
    
    func selectAnswer(_ answer: String) {
        selectedAnswer = answer
        if (answer == questions[currentQuestionIndex].answer) {
            score += 1
            questions[currentQuestionIndex].passed = true
            questions[currentQuestionIndex].failed = false
        } else {
            questions[currentQuestionIndex].failed = true
            questions[currentQuestionIndex].passed = false
        }
        questions[currentQuestionIndex].userAnswer = answer
        questionsAnswered += 1
        questions[currentQuestionIndex].unanswered = false
    }
    
    func abortTest(){
        isCompleted = true
    }
    
    func moveToNextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex >= questions.count {
            isCompleted = true
        } else {
            selectedAnswer = questions[currentQuestionIndex].userAnswer // Load the next question's answer
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                isCompleted = true
            }
        }
    }
}

