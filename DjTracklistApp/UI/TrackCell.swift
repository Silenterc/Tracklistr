//
//  TrackCell.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI
import SwiftData
struct TrackCell: View {
    @State var track: AppTrack
    @State private var width: CGFloat = 192
    @State private var height: CGFloat = 62
    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 3) {
                        Image(systemName: "play.square.fill")
                            .resizable()
                            .frame(width: 31, height: 31)
                            .cornerRadius(10)
                        VStack(alignment: .leading){
                            Text(track.name)
                                .font(.custom("Roboto-Regular", fixedSize: 12))
                                .truncationMode(.tail)
                            
                            Text(track.artistNames.joined(separator: ","))
                                .font(.custom("Roboto-Light", fixedSize: 8))
                                .truncationMode(.tail)
                        }
                    }
                    HStack {
                        timeInfo(timeInBars: track.startTimeBars)
                        
                        Spacer()

                        timeInfo(timeInBars: track.endTimeBars)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(6)
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .frame(width: 10, height: height)
                    .gesture(
                        LongPressGesture()
                            .sequenced(before: DragGesture()
                                .onChanged({ value in
                                    let change = value.translation.width
                                    let newWidth = width + change
                                    width = newWidth >= 0 ? newWidth : 0
                            }))
                    )
            }
            .frame(width: width, height: height)
            .background(Color.cellBackground)
            .cornerRadius(10)
        
    }

    private func timeInfo(timeInBars: Int) -> some View {
        VStack (alignment: .trailing){
            // BPM MUST BE THE SAME AS FOR THE PLAYLIST
            barsText(bars: timeInBars)
            timeText(bars: timeInBars)
        }
    }
    
    
    private func barsText(bars: Int) -> Text {
        Text("\(bars)" + (bars == 1 ? " bar" : " bars"))
            .font(.custom("Roboto-Regular", fixedSize: 8))
    }
    
    private func timeText(bars: Int) -> Text {
        let timeInSeconds = Double(bars) * (60.0/track.bpm!) * 4.0
        let timeInterval = TimeInterval(timeInSeconds)
            
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        var formattedString: String = "00:00"
        if let formattedOutput = formatter.string(from: timeInterval) {
            formattedString = formattedOutput
        }
        return Text(formattedString)
                    .font(.custom("Roboto-Regular", fixedSize: 8))
    }
        
        
    
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let track = AppTrack.mockSolarSystemTrack()
    container.mainContext.insert(track)

    return TrackCell(track: track).modelContainer(container)
}


