//
//  MixOverviewView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import SwiftUI
import SwiftData
/**
 View presenting the User's created mixes.
 */
struct MixOverviewView: View {
    
    //@State var path = NavigationPath()
    @State var viewModel: MixOverviewVM
    @EnvironmentObject var router: NavigationRouter
    
    // We need an initializer for injecting the database Context into our VM
    init(modelContext: ModelContext) {
        let viewModel = MixOverviewVM(databaseService: .init(databaseContext: modelContext))
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    router.navigateTo(destination: .tracklistInfoView(tracklistID: nil))
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .font(.system(size: 28))
                    }
                }
                .tint(.complementaryTimeline)
            }
            Text("Mix Overview")
                .font(.custom(UIConstants.shared.font.bold, size: 30))
            List(selection: $viewModel.selectedTracklist) {
                ForEach (viewModel.tracklists, id: \.self) { tracklist in
                    HStack {
                        Image(systemName:"slider.vertical.3")
                            .foregroundStyle(.timelineIndicator)
                        Text(tracklist.name)
                            .font(.custom(UIConstants.shared.font.regular, size: 18))
                        Spacer()
                        Text(tracklist.editedAt.formatted(date: .abbreviated, time: .omitted))
                            .font(.custom(UIConstants.shared.font.regular, size: 18))
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.complementaryTimeline)
                    }
                    .listRowInsets(EdgeInsets())
                    //.listRowBackground(Color.cellBackground)
                    .listRowSeparatorTint(.timelineIndicator)
                }
                .onDelete(perform: { indexSet in
                    viewModel.deleteTracklist(indexSet: indexSet)
                })
            }
            .listStyle(.plain)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                viewModel.fetchTracklists()
            }
            .onChange(of: viewModel.selectedTracklist) { _, newValue in
                if let tlist = newValue {
                    router.navigateTo(destination: .tracklistView(tracklistID: tlist.id))
                }
            }
        }
        .padding(16)
       
                    
         
            
//        .useSize(onChange: { size in
//            if size.height > size.width {
//                UIConstants.shared.screenSize = CGSize(width: size.height, height: size.width)
//            } else {
//                UIConstants.shared.screenSize = size
//            }
//            print(size)
//        })
        
        
    }
}

extension MixOverviewView {
    /**
     Represents a summary of a tracklist
     */
    struct TracklistCell : View {
        let viewModel: MixOverviewVM
        let name: String
        var editedAt: Date? = nil
        
        var body : some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.custom(UIConstants.shared.font.medium, fixedSize: 18))
                    
                    if let date = editedAt{
                        Text("Date: \(date))")
                            .font(.custom(UIConstants.shared.font.light, fixedSize: 16))
                            .foregroundColor(.gray)
                    }
                    
                }
            }
            .cornerRadius(10)
        }
    }
    
}
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    container.mainContext.insert(Tracklist.mockTracklist1())
    container.mainContext.insert(Tracklist.mockTracklist1())
    container.mainContext.insert(Tracklist.mockTracklist1())
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        MixOverviewView(modelContext: container.mainContext)
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
    
}
