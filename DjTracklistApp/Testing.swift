//
//  Testing.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 13.02.2024.
//

import SwiftUI
 // TRYING TO MAKE THE POSITIONING WORK, IT SEEMS THAT THE BEST WAY IS TO USE PADDING INSIDE A ZSTACK, HOWEVER PADDING TAKES
// COORDS FROM THE LEFT AND DROP DESTINATION TAKES THE CENTER, BUT THAT IS MANAGEABLE
struct Testing: View {
    let songs: [String] = ["Song 1", "Song 2", "Song 3", "Song 4"]
    let pos: [CGFloat] = [100, 200, 300, 400]
    var body: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<4, id: \.self) { _ in
                
                    VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                            ZStack(alignment: .leading) {
                                ForEach(0..<4) { i in
                                        Text(songs[i])
                                            .background(Color(.cellBackground))
                                        //.offset(x: 100)
                                            .draggable(songs[i])
                                        //.position(x: pos[i], y: 50)
                                            .padding(.leading, pos[i])
                                          
                                }
                                
                            }
                                // TEMPORARYą
                            Spacer()
                            
                
                           
                        }
                        .border(.green)
                        .background {
                            Color.black
                                .dropDestination(for: String.self) { droppedSongs, location in
                                    print(droppedSongs[0])
                                    print(location)
                                    return true
                                }
                                
                        }
                        
                    
                }
                
            }
            //.frame(width: 2000)
            //.border(.blue)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    Testing()
}
