import Foundation

class QuizLoader {
    func loadQuestionsFromCsv(for subject: String, for topic: String) -> [QuizQuestion] {
        var questions = [QuizQuestion]()
        var resourceName: String = "data";
        
        switch subject.lowercased() {
        case "maths":
            switch topic.lowercased() {
            case "decimals":
                resourceName = "Decimals"
                break;
            case "fractions":
                resourceName = "Fractions"
                break;
            default:
                resourceName = "MathQuestions"
                break;
            }
            
        case "english":
            switch topic.lowercased() {
            case "antonyms":
                resourceName = "Antonyms"
                break;
            case "synonyms":
                resourceName = "Synonyms"
                break;
            default:
                resourceName = "EnglishQuestions"
                break;
            }
        default:
            resourceName = "EnglishQuestions"
        }
        
        //resourceName = "data";
        
        if let path = Bundle.main.path(forResource: "\(resourceName)", ofType: "csv") {
            print("CSV file path: \(path)")
            do {
                let content = try String(contentsOfFile: path)
                let rows = content.split(separator: "\n")
                
                // Start the loop from index 1 to skip the header row
                for index in 1..<rows.count {
                    let row = rows[index]
                    let columns = row.split(separator: ",").map { String($0) }
                    
                    if columns.count == 6 {
                        let question = QuizQuestion(question: columns[0],
                                                    options: Array(columns[1...4]),
                                                    answer: columns[5],
                                                    userAnswer: "Unanwsered",
                                                    skipped: false,
                                                    unanswered: true,
                                                    passed: false,
                                                    failed: false)
                        questions.append(question)
                    }
                }
            } catch {
                print("Error reading CSV file: \(error)")
            }
        }else{
            print("incorrect path")
        }
        return questions
    }
    
    
}



