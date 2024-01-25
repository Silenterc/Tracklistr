//
//  ContentView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var newWidth: CGFloat = 100
    @State var oldValue: CGFloat = 0
    @State var newValue: CGFloat = 0
    @State var handleWidth: CGFloat = 100
    @State var handleOpacity = 1.0
    
    var body: some View {
        
        ZStack (alignment: .leading) {
            
            // Content
            Rectangle()
                .fill(Color.blue)
                .cornerRadius(10)
                .frame(minWidth: 50)
                .frame(maxWidth: 280)
                .frame(width: newWidth)
                .frame(minHeight: 100, maxHeight: 100, alignment: .leading)
            
            // Handle
            HStack {
                
                // Handle Proxy
                Rectangle()
                    .opacity(0)
                    .cornerRadius(10)
                    .frame(minWidth: 50)
                    .frame(maxWidth: 280)
                    .frame(width: handleWidth)
                    .frame(minHeight: 100, maxHeight: 100, alignment: .leading)
                
                // Handle
                Rectangle()
                    .fill(Color.gray)
                    .opacity(handleOpacity)
                    .frame(width: 8, height: 100)
                    .cornerRadius(10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                handleOpacity = 0.0
                                newValue = value.translation.width
                                let changeValue = oldValue - newValue
                                if newWidth - changeValue >= 50 && newWidth - changeValue <= 280 {
                                    newWidth = newWidth - changeValue
                                }
                                oldValue = value.translation.width
                                // print(newWidth)
                            }
                            .onEnded { value in
                                oldValue = 0
                                handleWidth = newWidth
                                withAnimation(.easeIn(duration: 0.1)) { handleOpacity = 1.0 }
                            }
                    )
            }
        }
        .frame(width: 300, height: 300, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
