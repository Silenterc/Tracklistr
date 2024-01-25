//
//  TrackCell.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI
import SwiftData
struct TrackCell: View {
    @State var viewModel: TrackCellVM
    var body: some View {
        VStack(){
            HStack {
                resizeBarLeft()
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 3) {
                        Image(systemName: "play.square.fill")
                            .resizable()
                            .frame(width: 31, height: 31)
                            .cornerRadius(10)
                        VStack(alignment: .leading){
                            Text(viewModel.track.name)
                                .font(.custom(UIConstants.Font.regular, fixedSize: 12))
                                .truncationMode(.tail)
                            
                            Text(viewModel.track.artistNames.joined(separator: ","))
                                .font(.custom(UIConstants.Font.light, fixedSize: 8))
                                .truncationMode(.tail)
                        }
                    }
                    HStack {
                        timeInfo(timeInBars: viewModel.track.startTimeBars)
                        
                        Spacer()
                        
                        timeInfo(timeInBars: viewModel.track.endTimeBars)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(6)
                resizeBarRight()
            }
            .frame(width: viewModel.width, height: viewModel.height, alignment: .leading)
            
            .background(Color.cellBackground)
            .cornerRadius(10)
        }
        //NEED TO SOMEHOW PLAY WITH THE ALIGNMENT HERE SO ITS LEADING WHEN FROM THE LEFT AND TRAILING WHEN FROM THE RIGHT AND ALSO NEED TO KEEP THE WIDTH OF THE VIEW THE SAME UNTIL THE RESIZE COMPLETES AND THEN SOMEHOW CALCULATE THE OFFSET AND PLACE IT TO THE LEFT OR RIGHT SO IT STAYS IN THE SAME PLACE
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    private func resizeBarRight() -> some View {
        Rectangle()
            .fill(.ultraThickMaterial)
            .frame(width: 10, height: viewModel.height)
            .gesture(
                LongPressGesture()
                    .sequenced(before: DragGesture()
                        .onChanged({ value in
                            viewModel.changeWidth(change: value.translation.width)
                    }))
            )
    }
    
    private func resizeBarLeft() -> some View {
        Rectangle()
            .fill(.ultraThickMaterial)
            .frame(width: 10, height: viewModel.height)
            .gesture(
                LongPressGesture()
                    .sequenced(before: DragGesture()
                        .onChanged({ value in
                            viewModel.changeWidth(change: -value.translation.width)
                    }))
            )
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
        let timeInSeconds = Double(bars) * (60.0/viewModel.track.bpm!) * 4.0
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

    return TrackCell(viewModel: .init(track: track, width: 192, height: 62)).modelContainer(container)
}


