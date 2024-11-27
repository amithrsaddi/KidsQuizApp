import SwiftUI

struct ExamView: View {
    // Define your items
    let timers: [TimerItem] = [
        TimerItem(title: "Mock Exam 1", duration: 7 * 24 * 60 * 60),
        TimerItem(title: "Mock Exam 2", duration: 14 * 24 * 60 * 60),
        TimerItem(title: "Mock Exam 3", duration: 21 * 24 * 60 * 60)
    ]
    
    @State private var remainingTimes: [TimeInterval]

    // Alert state variables
    @State private var showAlert = false
    @State private var selectedTimerTitle: String = ""
    @State private var selectedRemainingTime: TimeInterval = 0
    
    init() {
        // Initialize the remaining times
        self._remainingTimes = State(initialValue: timers.map { $0.duration })
    }
    
    var body: some View {
        List {
            ForEach(timers.indices, id: \.self) { index in
                HStack {
                    Text(timers[index].title)
                        
                    Spacer()
                    Text("\(formatTime(remainingTimes[index]))")
                        .font(.headline)
                        .foregroundColor(remainingTimes[index] > 0 ? .green : .red)
                }
                .onTapGesture {
                    // Handle item tap to show alert
                    selectedTimerTitle = timers[index].title
                    selectedRemainingTime = remainingTimes[index]
                    showAlert = true
                }
            }.padding(.horizontal, 10)
        }
        .onAppear(perform: startTimers)
        .onDisappear(perform: stopTimer)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(selectedTimerTitle),
                message: Text("Remaining time: \(formatTime(selectedRemainingTime))"),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle("Mock Exam")
        .padding(.top, 20)
    }
    
    private func formatTime(_ seconds: TimeInterval) -> String {
        let days = Int(seconds) / (24 * 60 * 60)
        let hours = (Int(seconds) % (24 * 60 * 60)) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        return "\(days)d \(hours)h \(minutes)m"
    }

    private func startTimers() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            for index in remainingTimes.indices {
                if remainingTimes[index] > 0 {
                    remainingTimes[index] -= 1
                }
            }
        }
    }
    
    private func stopTimer() {
        // Placeholder for stopping the timer if needed
    }
}

struct TimerItem: Identifiable {
    let id = UUID()
    let title: String
    let duration: TimeInterval
}

