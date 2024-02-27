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
            ScrollView {
                LazyVStack(spacing: 20) {
                    Button {
                        router.navigateTo(destination: .tracklistInfoView())
                    } label: {
                        TracklistCell(viewModel: viewModel, name: "Start a new set")
                    }
                    ForEach(viewModel.tracklists) { tracklist in
                        Button {
                            router.navigateTo(destination: .tracklistView(tracklistID: tracklist.id))
                        } label: {
                            TracklistCell(viewModel: viewModel, name: tracklist.name, editedAt: tracklist.editedAt)
                        }
                    }
                }
                .padding()
            }
            .onAppear{
                viewModel.fetchTracklists()
            }
        }
        .navigationTitle("Mix Overview")
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
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
    
}
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        MixOverviewView(modelContext: container.mainContext)
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
    
}
