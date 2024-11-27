import Foundation

class ScoreSummary: ObservableObject {
    @Published var score: Int
    @Published var questions: [QuizQuestion] = []
    
    init(score: Int,  questions: [QuizQuestion]) {
        self.score = score
        self.questions = questions
    }
}
