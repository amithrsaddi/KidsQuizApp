import Foundation

struct QuizQuestion : Hashable{
    var question: String
    var options: [String]
    var answer: String
    var userAnswer: String?
    var skipped: Bool
    var unanswered: Bool
    var passed: Bool
    var failed: Bool
}
