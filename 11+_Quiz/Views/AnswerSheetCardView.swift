import SwiftUI

struct AnswerSheetCardView: View {
    @Binding var show: Bool
    var question: QuizQuestion
    
    var body: some View {
        VStack {
            Spacer()  // Pushes the content to the bottom

            if show {  // Only show when `show` is true
                VStack {
                    QuestionDetailView(question: question)
                        .padding(.top, 10)  // Top padding for styling
                        .padding(.bottom, 10)  // Bottom padding for styling
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250) // Height of the bottom sheet
                .background(Color.white)  // Background color
                .cornerRadius(20)
                .shadow(radius: 10)
                .transition(.move(edge: .bottom))  // Animate appearance from the bottom
                .animation(.easeInOut)  // Animate show/hide
                .padding(.bottom, tabBarHeight())  // Adjust based on your tab bar height
            }
        }
        .edgesIgnoringSafeArea(.bottom)  // Ignore safe area to allow full view
    }
    
    // Function to estimate the tab bar height.
    private func tabBarHeight() -> CGFloat {
        // Adjust this value based on your tab bar height
        // If using a UITabBar, a typical height is about 49 points
        return 83  // Customize this value to match your tab bar's actual height
    }
}
