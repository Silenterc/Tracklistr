//
//  TracklistView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct TracklistView: View {
    @State var viewModel: TracklistVM
    @EnvironmentObject var router: NavigationRouter
    @State var contentOffset: CGPoint = .zero
    @State var scrollViewWidth: CGFloat = .zero
    @State var visibleWidth: CGFloat = .zero
    @State private var offsetX: CGFloat = 0
    @GestureState private var dragState = CGSize.zero
    init(modelContext: ModelContext, tracklistID: UUID) {
        let viewModel = TracklistVM(tracklistService: DatabaseService(databaseContext: modelContext), tracklistID: tracklistID)
        _viewModel = State(initialValue: viewModel)
    }
    
    
    
    
    var body: some View {
        if let tracklist = viewModel.tracklist {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        router.navigateToRoot()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.complementaryTimeline)
                            Text("Back")
                                .font(.custom(UIConstants.shared.font.light, size: UIConstants.shared.track.nameSize + 4))
                                .foregroundStyle(.complementaryTimeline)
                        }
                    }
                    .offset(y: 8)
                    Spacer()
                }
                
                HStack {
                    ScrollView (.horizontal) {
                        ZStack (alignment: .leading) {
                            HStack {
                                VStack {
                                    ZStack() {
                                        let part = UIConstants.shared.screenSize.height / 4
                                        ForEach(1..<4) { i in
                                            VStack(alignment: .leading, spacing: 0) {
                                                TimeIndicationView(bars: (viewModel.tracklist?.durationMinutes.getBars(bpm: viewModel.tracklist!.bpm, timeUnit: .minutes))!)
                                                minutesIndication(tracklist: tracklist)
                                                
                                            }
                                            .offset(y: part * CGFloat(i) - UIConstants.shared.indicator.big.height / 2 - UIConstants.shared.track.nameSize / 2)
                                        }
                                        
                                    }
                                    Spacer()
                                }
                            }
                            
                            
                            
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(viewModel.players) { player in
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        PlayerView(viewModel: .init(player: player, databaseService: viewModel.tracklistService))
                                            .frame(width: GridHandler.shared.getWidthFromBars(bars: tracklist.durationMinutes.getBars(bpm: tracklist.bpm, timeUnit: .minutes)), alignment: .leading)
                                        Spacer()
                                        
                                    }
                                    
                                    .zIndex(1)
                                }
                                
                            }
                            
                            .useSize { size in
                                if (size.height > UIConstants.shared.screenSize.height) {
                                    UIConstants.shared.screenSize = size
                                    print("actual: \(size)")
                                }
                            }
                            .coordinateSpace(.named("players"))
                            
                        }
                        
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .navigationBarBackButtonHidden()
                    TrackAddBar(tracklist: tracklist)
                    
                }
              
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .background(.black)
            .frame(maxWidth: .infinity)
        }
        
    }
    
    func TrackAddBar(tracklist: Tracklist) -> some View {
        VStack {
            ForEach(viewModel.players) { player in
                Spacer()
                Button {
                    router.navigateTo(destination: .addTrackView(player: player, bpm: tracklist.bpm))
                } label: {
                    Image(systemName: "plus.app")
                        .resizable()
                        .tint(Color.cellBackground)
                        .frame(width: UIConstants.shared.track.addButtonSize, height: UIConstants.shared.track.addButtonSize)
                }
                Spacer()
                
            }
        }
        .background(.black)
        .frame(width: UIConstants.shared.track.addbarSize)
    }
    
    func minutesIndication(tracklist: Tracklist) -> some View {
        ZStack (alignment: .leading) {
            ForEach(0...Int(tracklist.durationMinutes) / 10, id: \.self) { x in
                Text("\(x * 10)")
                    .foregroundStyle(Color(.complementaryTimeline))
                    .font(.custom("Roboto-Regular", fixedSize: UIConstants.shared.track.nameSize))
                    .offset(x: GridHandler.shared.getWidthFromBars(bars: UInt(x * 10).getBars(bpm: tracklist.bpm, timeUnit: .minutes)))
            }
        }
    }
    
    
}



#Preview(traits: .landscapeLeft) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let tracklist = Tracklist.mockTracklist1()
    container.mainContext.insert(tracklist)
    let player0 = Player.mockPlayer1()
    let player1 = Player.mockPlayer2()
    let player2 = Player.mockPlayer3()
    let player3 = Player.mockPlayer4()
    container.mainContext.insert(player0)
    container.mainContext.insert(player1)
    container.mainContext.insert(player2)
    container.mainContext.insert(player3)
    player0.tracklist = tracklist
    player1.tracklist = tracklist
    player2.tracklist = tracklist
    player3.tracklist = tracklist
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        TracklistView(modelContext: container.mainContext, tracklistID: tracklist.id)
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
    
}
