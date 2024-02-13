//
//  TrackCell.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI
import SwiftData
import AsyncDownSamplingImage
/// View representing a Track which is placed on the TracklistView
struct TrackCell: View {
    @State var viewModel: TrackCellVM
    var body: some View {
        VStack(){
            HStack(spacing: 0) {
                resizeBarLeft()
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 3) {
                        LazyVStack {
                            // Used AsyncDownSamplingImage library: https://github.com/fummicc1/AsyncDownSamplingImage.git
                            AsyncDownSamplingImage(url: viewModel.track.imageUrl, downsampleSize: CGSize(width: 100, height: 100)){
                                image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                            } placeholder: {
                                ProgressView()
                            } fail: { error in
                                EmptyView()
                                
                            }
                        }
                        .frame(width: 32, height: 32)
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
                        timeInfo(timeInBars: viewModel.track.startTimeBars!)
                        
                        Spacer()
                        
                        timeInfo(timeInBars: viewModel.track.endTimeBars!)
                        
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
    /// Bar on the right side of the track cell, which can be dragged horizontally to make the cell bigger or smaller
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
    /// Bar on the left side of the track cell, which can be dragged horizontally to make the cell bigger or smaller
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
    
    /// Information about the current duration of the track
    private func timeInfo(timeInBars: UInt) -> some View {
        VStack (alignment: .trailing){
            // BPM MUST BE THE SAME AS FOR THE PLAYLIST
            barsText(bars: timeInBars)
            timeText(bars: timeInBars)
        }
    }
    
    /// Information about the current curation of the track in bars
    private func barsText(bars: UInt) -> Text {
        Text("\(bars)" + (bars == 1 ? " bar" : " bars"))
            .font(.custom("Roboto-Regular", fixedSize: 8))
    }
    /// Information about the current duration of the track in mm:ss
    private func timeText(bars: UInt) -> Text {
        let timeInSeconds = bars.getTime(bpm: viewModel.track.bpm!, timeUnit: .seconds)
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
    let track = Track.mockSolarSystemTrack()
    container.mainContext.insert(track)

    return TrackCell(viewModel: .init(track: track, width: 192, height: 62)).modelContainer(container)
}


