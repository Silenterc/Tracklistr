//
//  AddTrackView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 28.01.2024.
//

import SwiftUI
import SwiftData
struct AddTrackView: View {
    @State var viewModel: AddTrackVM
    
    init(player: Player) {
        let viewModel = AddTrackVM(player: player)
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack (alignment: .bottom) {
                let musicApi = Image("MusicApi").resizable()
                    .aspectRatio(contentMode: .fit)
                Button(action: {
                    
                }, label: {
                    inputSelectionCell(image: Image("Spotify"), text: "Find via Spotify")
                })
                .tint(.black)
                
                Button(action: {
                    
                }, label: {
                    inputSelectionCell(image: musicApi, text: "Find via all services")
                })
                .tint(.black)
        
               
            }
            
            HStack (alignment: .bottom) {
                let plus = Image(systemName: "plus.app").resizable().frame(width: 45, height: 45)
                Button(action: {
                    
                }, label: {
                    inputSelectionCell(image: plus, text: "Add your own")
                })
                .tint(.black)
                
            }
            
            
        }
        .frame(width: 400)
    }
    
    func inputSelectionCell(image: some View, text: String) -> some View {
        VStack {
        
            image
              
            Text(text)
            
        }
        .frame(width: 150)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    return AddTrackView(player: Player.mockPlayer1())
}
