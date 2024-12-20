//
//  TrackCell.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI
import SwiftData
import AsyncDownSamplingImage
import Marquee
/// View representing a Track which is placed on the TracklistView
struct TrackCell: View {
    @State var viewModel: TrackCellVM
    @State var animateSliding: Bool = false
    var body: some View {
        
        HStack(spacing: 0) {
            resizeBarLeft()
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 0) {
                    if !viewModel.shorterUI {
                        VStack {
                            if let imageUrl = viewModel.track.imageUrl {
                                // Used AsyncDownSamplingImage library: https://github.com/fummicc1/AsyncDownSamplingImage.git
                                AsyncDownSamplingImage(url: imageUrl, downsampleSize: CGSize(width: 100, height: 100)){
                                    image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIConstants.shared.track.image.width, height: UIConstants.shared.track.image.height)
                                } placeholder: {
                                    ProgressView()
                                } fail: { error in
                                    EmptyView()
                                }
                            } else {
                                Image(systemName: "opticaldisc.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIConstants.shared.track.image.width, height: UIConstants.shared.track.image.height)
                            }
                        }
                        .cornerRadius(10)
                        // width maybe viewModel.width / 6
                        .frame(width: UIConstants.shared.track.image.width, height: UIConstants.shared.track.image.height)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        GeometryReader { proxy in
                            SlidingText(geometryProxy: proxy, text: viewModel.track.name, font: UIFont(name: UIConstants.shared.font.regular, size: UIConstants.shared.track.nameSize)!)
                        }
                        
                        //Spacer()
                        GeometryReader { proxy in
                            SlidingText(geometryProxy: proxy, text: viewModel.track.artistNames.joined(separator: ","), font: UIFont(name: UIConstants.shared.font.light, size: UIConstants.shared.track.artistsSize)!)
    
                        }
            
                    }
                    .frame(height: UIConstants.shared.track.image.height)
                    .padding(.leading, UIConstants.shared.track.height * 0.1)
                    
                    
                }
            
                HStack {
                    timeInfo(timeInBars: viewModel.track.startTimeBars!)
                    
                    Spacer()
                    
                    timeInfo(timeInBars: viewModel.track.endTimeBars!)
                    
                }
                
            }
            .frame(height: UIConstants.shared.track.height)
            .padding(UIConstants.shared.track.height * 0.1)
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            //.padding(.leading, 6)
            
            resizeBarRight()
        }
        .frame(width: viewModel.width, height: UIConstants.shared.track.height, alignment: .leading)
        .background(Color.cellBackground
            .onTapGesture {}
            .gesture (
                DragGesture(minimumDistance: 0, coordinateSpace: .named("players"))
                    .onChanged { gesture in
                        viewModel.drag = gesture.translation
                        if !viewModel.dragging {
                            viewModel.startOfDrag(start: gesture.startLocation)
                        }
                    }
                    .onEnded { gesture in
                        _ = DragHandler.shared.performDrop(location: CGPoint(x: gesture.location.x - viewModel.xOffset, y: gesture.location.y))
                        viewModel.endDrag()
                        
                    }
            ))
        .cornerRadius(10)
        .offset(viewModel.drag)
    }
    /// Bar on the right side of the track cell, which can be dragged horizontally to make the cell bigger or smaller
    private func resizeBarRight() -> some View {
        Rectangle()
            .fill(.ultraThickMaterial)
            .frame(width: UIConstants.shared.track.barSize, height: UIConstants.shared.track.height)
            .fixedSize()
            .overlay(alignment: .trailing) {
                if viewModel.draggingRight {
                    withAnimation(.linear) {
                        Color.complementaryTimeline
                            .opacity(0.8)
                    }
                } else {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: UIConstants.shared.track.barArrowWidth, height: UIConstants.shared.track.barArrowHeight)
                        .foregroundStyle(.complementaryTimeline)
                        .opacity(0.5)
                }
            }
            .highPriorityGesture(
                LongPressGesture(minimumDuration: 1)
                    .onChanged({ _ in
                        withAnimation(.snappy) {
                            viewModel.draggingRight = true
                        }
                    })
                    .sequenced(before: DragGesture()
                        .onChanged({ value in
                            viewModel.changeWidthRight(change: value.translation.width)
                        })
                        .onEnded({ value in
                            viewModel.draggingRight = false
                        })
                    )
            )
    }
    /// Bar on the left side of the track cell, which can be dragged horizontally to make the cell bigger or smaller
    private func resizeBarLeft() -> some View {
        Rectangle()
            .fill(.ultraThickMaterial)
            .frame(width: UIConstants.shared.track.barSize, height: UIConstants.shared.track.height)
            .fixedSize()
            .overlay(alignment: .leading) {
                if viewModel.draggingLeft {
                    withAnimation(.linear) {
                        Color.complementaryTimeline
                            .opacity(0.8)
                    }
                } else {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundStyle(.complementaryTimeline)
                        .opacity(0.5)
                        .frame(width: UIConstants.shared.track.barArrowWidth, height: UIConstants.shared.track.barArrowHeight)
                }
            }
            .gesture(
                LongPressGesture(minimumDuration: 1)
                    .onChanged({ _ in
                        withAnimation(.snappy) {
                            viewModel.draggingLeft = true
                        }
                    })
                    .sequenced(before: DragGesture()
                        .onChanged({ value in
                            viewModel.changeWidthLeft(change: -value.translation.width)
                        })
                        .onEnded({ value in
                            viewModel.draggingLeft = false
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
        Text("\(bars)" + (!viewModel.shorterUI ? (bars == 1 ? " bar" : " bars") : ""))
            .font(.custom("Roboto-Regular", fixedSize: UIConstants.shared.track.barsSize))
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
            .font(.custom("Roboto-Regular", fixedSize: UIConstants.shared.track.timeSize))
    }
    
    /// Used for the Marquee Text sliding animation
    /// Courtesy of the package: https://github.com/SwiftUIKit/Marquee
    struct SlidingText: View {
        let geometryProxy: GeometryProxy
        var text: String
        let font: UIFont
        private var textWidth: CGFloat {
            return text.size(withAttributes: [.font: font]).width
        }
        /// Whether the text should have the sliding animation
        private var animate: Bool {
            return textWidth > geometryProxy.size.width
        }
        /// How long should the sliding duration be, right now it means 20 points/sec
        private var duration: Double {
            Double(textWidth / 20)
        }

        var body: some View {
            if animate {
                Marquee {
                    Text(text)
                        .font(Font(font))
                }
                .frame(width: textWidth, height: font.pointSize)
                .marqueeDuration(duration)
            } else {
                Text(text)
                    .font(Font(font))
            }
        }
            
    }
    
    
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let track = Track.mockSolarSystemTrack()
    let player = Player.mockPlayer1()
    container.mainContext.insert(player)
    container.mainContext.insert(track)
    player.tracks?.append(track)
    track.player = player
    UIConstants.shared.screenSize = CGSize(width: 656.0, height: 393.0)
    return TrackCell(viewModel: .init(track: track)).modelContainer(container)
}


