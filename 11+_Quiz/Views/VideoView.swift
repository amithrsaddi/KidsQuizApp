import SwiftUI
import AVKit

struct VideoView: View {
    // Replace with your video URL
    let videoURL = Bundle.main.url(forResource: "firework", withExtension: "mp4")!
    @State private var player = AVPlayer()

    var body: some View {
        ZStack {
            VideoPlayerView(player: player)
                .onAppear {
                    player = AVPlayer(url: videoURL)
                }

            // Overlay Button
            VStack {
                Spacer()
                Button(action: {
                    // Action for the button
                    print("Button Tapped")
                }) {
                    Text("Overlay Button")
                        .font(.title)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40) // Padding from the bottom
            }
        }
    }
}
