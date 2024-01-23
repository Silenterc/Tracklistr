//
//  TrackCell.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI

struct TrackCell: View {
    var track: AppTrack
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
                            
                            Text(track.artistNames[0])
                                .font(.custom("Roboto-Light", fixedSize: 8))
                                .truncationMode(.tail)
                        }
                    }
                    HStack {
                        timeInfo(bars: 0, timeInSeconds: 0)
                        
                        Spacer()

                        timeInfo(bars: 96, timeInSeconds: 132)
                        
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(6)
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .frame(width: 10, height: height)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                width = width + value.translation.width
                            })
                        
                        
                        
                    )
            }
            .frame(width: width, height: height)
            .background(Color.gray)
            .cornerRadius(10)
        
    }
    
    private func timeInfo(bars: Int, timeInSeconds: Int) -> some View {
        VStack (alignment: .trailing){
            barsText(bars: bars)
            timeText(timeInSeconds: timeInSeconds)
        }
    }
    
    
    private func barsText(bars: Int) -> Text {
        Text("\(bars)" + (bars == 1 ? " bar" : " bars"))
            .font(.custom("Roboto-Regular", fixedSize: 8))
    }
    
    private func timeText(timeInSeconds: Int) -> Text {
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
    TrackCell(track: AppTrack.mockSolarSystemTrack())
}
