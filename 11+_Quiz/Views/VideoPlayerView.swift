import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let player: AVPlayer

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.play()  // Start playing the video automatically
            }
            .onDisappear {
                player.pause() // Pause the video when the view disappears
            }
    }
}
