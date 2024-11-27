import Foundation

class Parser {
    func loadQuestionsFromJson(for subject: String, for topic: String) -> [QuizQuestion] {
        var questions = [QuizQuestion]()
        let resourceName: String = "data"
        
        if let path = Bundle.main.path(forResource: resourceName, ofType: "json") {
            print("JSON file path: \(path)")
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonQuestions = try JSONDecoder().decode([JsonQuestion].self, from: data)
                
                for jsonQuestion in jsonQuestions {
                    if jsonQuestion.subject.lowercased() == subject.lowercased() &&
                        jsonQuestion.topic.lowercased() == topic.lowercased() {
                        
                        let question = QuizQuestion(
                            question: jsonQuestion.question.question,
                            options: [
                                jsonQuestion.question.option1,
                                jsonQuestion.question.option2,
                                jsonQuestion.question.option3,
                                jsonQuestion.question.option4,
                            ],
                            answer: jsonQuestion.question.correct_answer,
                            userAnswer: "Unanswered",
                            skipped: false,
                            unanswered: true,
                            passed: false,
                            failed: false
                        )
                        
                        questions.append(question)
                    }
                }
            } catch {
                print("Error reading JSON file: \(error)")
            }
        } else {
            print("Incorrect path")
        }
        
        return questions
    }
}

struct JsonQuestion: Codable {
    let id: String
    let subject: String
    let topic: String
    let question: QuestionDetails
    let user_answer: String
    let imageUrl: String?
}

struct QuestionDetails: Codable {
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let correct_answer: String
}

