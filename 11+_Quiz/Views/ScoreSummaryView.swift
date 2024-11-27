import SwiftUI

struct ScoreSummaryView: View {
    var questions: [QuizQuestion]
    var item: ListItem
    @State private var expandedQuestion: Int?
    @State private var showBottomSheet = false
    @State private var selectedQuestion: QuizQuestion?
    
    var body: some View {
        ZStack { // Use ZStack to overlay the bottom sheet
            VStack {
                Text("\(item.title)")
                    .font(.title)
                    .foregroundColor(item.iconColor)
                    .fontWeight(.bold)
                    .padding()
                
                List {
                    ForEach(questions.indices, id: \.self) { index in
                        let question = questions[index]
                        VStack(alignment: .leading) {
                            HStack {
                                Rectangle()
                                    .fill(item.iconColor)
                                    .opacity(0.2)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(systemName: expandedQuestion == index ? "minus" : "plus")
                                        //.foregroundColor(.black)
                                            .font(.system(size: 24, weight: .bold))
                                    )
                                
                                Text("\(index + 1). \(question.question)")
                                    .font(.headline)
                                //.foregroundColor(.black)
                            }
                            
                            //                            if expandedQuestion == index {
                            //                                // You can keep or remove this part if you don't want expandable questions.
                            //                                Text(question.answer) // or any other details if required
                            //                                    .font(.subheadline)
                            //                            }
                        }
                        .onTapGesture {
                            selectedQuestion = question
                            showBottomSheet.toggle()
                        }
                        .padding(.bottom, 5)
                    }
                    .padding(.vertical, 2)
                }
            }
            .listStyle(PlainListStyle())
            //.navigationTitle("Topics")
        }
        .edgesIgnoringSafeArea(.bottom) // Make sure your bottom sheet goes to the edge of the screen
        .overlay( // Overlay the bottom sheet when it's shown
            Group {
                if showBottomSheet, let selectedQuestion = selectedQuestion {
                    AnswerSheetCardView(show: $showBottomSheet, question: selectedQuestion)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showBottomSheet)
                        .zIndex(1)
                        .onTapGesture {
                            // Dismiss the bottom sheet when tapping outside
                            withAnimation {
                                showBottomSheet = false
                            }
                        }
                        //.edgesIgnoringSafeArea(.bottom)
                }
            }
        )
    }
}







//import SwiftUI
//
//struct ScoreSummaryView: View {
//    var questions: [QuizQuestion]
//    var item: ListItem
//    @State private var expandedQuestion: Int?
//    @State private var showBottomSheet = false
//
//    var body: some View {
//
//        VStack {
//            Text("\(item.title)")
//                .font(.title)
//                .foregroundColor(item.iconColor)
//                .fontWeight(.bold)
//                .padding()
//
//            List {
//                ForEach(questions.indices, id: \.self) { index in
//                    let question = questions[index]
//                    VStack (alignment: .leading) {
//                        HStack {
//                            Rectangle()
//                                .fill(item.iconColor) // Set the fill color of the rectangle
//                                .opacity(0.2) // Set slight opacity
//                                .frame(width: 30, height: 30)
//                                .overlay(
//                                    Image(systemName: expandedQuestion == index ? "minus" : "plus")
//                                        .foregroundColor(.black) // Change Chevron color to gray
//                                        .font(.system(size: 24, weight: .bold))
//                                )
//                                .onTapGesture {
//                                    expandedQuestion = (expandedQuestion == index) ? nil : index
//                                }
//
//
//                            Text("\(index + 1). \(question.question)")
//                                .font(.headline)
//                                .foregroundColor(.black) // Text color
//
//                            Spacer() // Allows room for the chevron to be placed on the right side
//                        } .onTapGesture {
//                            expandedQuestion = (expandedQuestion == index) ? nil : index
//                        }
//ad
//                        Button(action: {
//                            withAnimation {
//                                showBottomSheet.toggle()
//                            }
//                        }) {
//                            Text("Show Information")
//                                .font(.headline)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//
//                        if expandedQuestion == index {
//                            HStack () {
//                                VStack (alignment: .leading){
//                                    Text("Q: \(question.question)")
//                                        .font(.subheadline)
//                                        .fontWeight(.bold)
//                                        .padding(.bottom, 5)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                                    ForEach(Array(question.options.enumerated()), id: \.element) { index, option in
//                                        let prefix = String(UnicodeScalar("a".unicodeScalars.first!.value + UInt32(index))!)
//                                        Text("\(prefix). \(option)")
//                                            .padding(.leading)
//                                    }
//
//                                    Spacer()
//
//                                    HStack {
//                                        //
//                                        if let userAnswer = question.userAnswer {
//                                            Text(userAnswer == question.answer ? "✓" : "✗")
//                                                .foregroundColor(userAnswer == question.answer ? .green : .red)
//                                                .fontWeight(.bold)
//                                            Text("Your Answer: ")
//                                                .font(.subheadline) +
//                                            Text(userAnswer)
//                                                .font(.subheadline)
//                                                .fontWeight(.bold)
//                                        } else {
//                                            Text("Your Answer: ")
//                                                .font(.subheadline).foregroundColor(.gray) +
//                                            Text("Skipped")
//                                                .font(.subheadline)
//                                                .fontWeight(.bold).foregroundColor(.gray)
//                                        }
//
//
//                                    }
//                                    .padding(.horizontal)
//                                    HStack  {
//                                        Text("✓")
//                                            .foregroundColor(.green)
//
//                                        Text("Correct: ")
//                                            .font(.subheadline).foregroundColor(.blue) +
//                                        Text(question.answer)
//                                            .font(.subheadline)
//                                            .fontWeight(.bold).foregroundColor(.blue)
//                                    }
//                                    .padding(.horizontal)
//                                }
//
//                            }
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(8)
//                            .shadow(radius: 1)
//                            .padding(.bottom, 10)
//                        }
//                    }
//                    .padding(.bottom, 5)
//
//                    // Bottom sheet
//                    if showBottomSheet {
//                        BottomSheetView(show: $showBottomSheet)
//                            .transition(.move(edge: .bottom))
//                            .animation(.easeInOut, value: showBottomSheet)
//                    }
//                }
//                .padding(.vertical, 2)
//            }
//        }
//        .listStyle(PlainListStyle())
//        .navigationTitle("Topics")
//    }
//}
//
//
//struct ContentView2: View {
//    @State private var showBottomSheet = false
//
//    var body: some View {
//        ZStack {
//            // Main content of the screen
//            VStack {
//                Text("Main Screen")
//                    .font(.largeTitle)
//                    .padding()
//
//                Button(action: {
//                    withAnimation {
//                        showBottomSheet.toggle()
//                    }
//                }) {
//                    Text("Show Information")
//                        .font(.headline)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//
//            // Bottom sheet
//            if showBottomSheet {
//                BottomSheetView(show: $showBottomSheet)
//                    .transition(.move(edge: .bottom))
//                    .animation(.easeInOut, value: showBottomSheet)
//            }
//        }
//        .edgesIgnoringSafeArea(.all) // Ignore safe areas to allow the bottom sheet to cover it
//    }
//}
//
