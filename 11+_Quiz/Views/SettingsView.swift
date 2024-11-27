import SwiftUI

struct SettingsView: View {
    @State private var selectedValue: String = "10" // Default selection
    @State private var selectedTimeValue: String = "5" // Default selection
    @State private var options: [String] = ["10", "20", "30", "40", "50"] // Example options
    @State private var timerOptions: [String] = ["5", "10", "15", "20", "25"] // Example options
    @ObservedObject var counter: Counter // Assuming you have a Counter class that you want to update
    
    var body: some View {
        VStack(spacing: 20) { // Add spacing between the elements
            Text("Select No of Questions:")
                .font(.title3)
                .padding(.leading, 20) // Add left indentation
            
            Picker("Select a value", selection: $selectedValue) {
                ForEach(options, id: \.self) { value in
                    Text(value).tag(value)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedValue) { newValue in
                // Safely update the questions count
                if let count = Int(newValue) {
                    counter.questionCount = count
                    print(counter.questionCount)
                }
            }
            
            Text("Select Time:")
                .font(.title3)
                .padding(.leading, 20) // Add left indentation
            
            Picker("Select a value", selection: $selectedTimeValue) {
                ForEach(timerOptions, id: \.self) { value in
                    Text(value).tag(value)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedTimeValue) { newValue in
                // Safely update the timer count
                if let count = Int(newValue) {
                    counter.timerCount = count
                    print(counter.timerCount)
                }
            }
        }
        .padding() // Optional: Add outer padding if needed
        .frame(maxHeight: .infinity, alignment: .top) // Align content to the top

        //.navigationBarTitle("Settings", displayMode: .inline)
    }
}

