//
//  ContentView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import SwiftUI
struct CustomScrollView: View {
    @State private var offsetX: CGFloat = 0
    @GestureState private var dragState = CGSize.zero
    let items: [String]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .frame(width: geometry.size.width)
                        .background(Color.gray.opacity(0.2))
                }
            }
            .offset(x: offsetX + dragState.width)
            .gesture(
                DragGesture()
                    .updating($dragState) { drag, state, _ in
                        state = drag.translation
                    }
                    .onEnded { drag in
                        print("actual: \(drag.translation.width)")
                        print("predicted: \(drag.predictedEndTranslation.width)")
                        offsetX += drag.translation.width
                        withAnimation(.linear(duration: 1)) {
                            applyDeceleration(difference: drag.predictedEndTranslation.width - drag.translation.width)
                        }
                        
                    }
            )
        }
    }
    
    func applyDeceleration(difference: CGFloat) {
        withAnimation(.spring) {
            print("difference: \(difference)")
            let decelerationRate = 0.4
            let threshold: CGFloat = 0.5
            var currentDifference = difference

                repeat {
                    currentDifference *= decelerationRate
                    self.offsetX += currentDifference
                } while abs(currentDifference) > threshold
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomScrollView(items: ["lol", "here", "maybe"])
    }
}
