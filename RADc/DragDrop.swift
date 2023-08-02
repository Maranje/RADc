//
//  DragDropTest.swift
//  RADc
//
//  Created by Frank Maranje on 7/28/23 for STI-TEC, INC.
//

import SwiftUI

struct DragDrop: View {
    @Binding var texts: [String]
    @State var scalerIndex: CGFloat = -1.0
    @State var scrollHintDisplay: Bool = false
    @State var scrollHintOffset: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @State private var orientation: UIDeviceOrientation?

    var body: some View {
        VStack{
            //drag and drop popup title
            Text("Reorganize Entry Fields")
                .padding()
                .fontWeight(.thin)
                .cornerRadius(20)
                .shadow(radius: 5)
            Divider().padding(.bottom, 20)
            //scroll area with labels
            ScrollView{
                HStack{
                    Spacer().overlay(content: {
                        if scrollHintDisplay{ Image(systemName: "hand.tap")
                            .offset(x: 0, y: (scrollHintOffset ? -400.0 : -200.0))
                            .font(.title) }
                    })
                    VStack {
                        ForEach(texts.indices, id: \.self) { index in
                            HStack{
                                Text("\(index + 1)").fontWeight(.thin)
                                DraggableTextField(text: $texts[index], index: index, texts: $texts, scalerIndex: $scalerIndex)
                            }
                        }
                    }
                    .padding()
                    .background(colorScheme == .light ? .white : .black)
                    .cornerRadius(10)
                    Spacer().overlay(content: {
                        if scrollHintDisplay{ Image(systemName: "hand.tap")
                            .offset(x: 0, y: (scrollHintOffset ? -400.0 : -200.0))
                            .font(.title) }
                    })
                }
            }
            .shadow(radius: 5)
            .onAppear(){
                if texts.count > 14{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation{ scrollHintDisplay = true }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        withAnimation(Animation.easeInOut(duration: 1)){ scrollHintOffset = true }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation{ scrollHintDisplay = false }
                    }
                }
            }
        }
        .padding()
        .background(colorScheme == .light ? .white : .black)
    }
}

//struct for draggable fields
struct DraggableTextField: View {
    let text: Binding<String>
    let index: Int
    @State var indexDiff = 0.0
    @State private var dragOffset: CGFloat = .zero
    @State var set: Bool = true
    @State var hovered: Bool = false
    @State private var translation: CGSize = .zero
    @Binding var texts: [String]
    @Binding var scalerIndex: CGFloat
    @GestureState private var isLongPressing: Bool = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        TextField("", text: text)
            .disabled(true)
            .padding()
            .frame(width:300)
            .background(set ? (colorScheme == .light ? Color(red: 0.949, green: 0.949, blue: 0.971) : Color(red: 0.1, green: 0.1, blue: 0.1)).opacity(hovered ? 0.65 : 1.0) : Color.orange)
            .foregroundColor(colorScheme == .light ? .black.opacity(hovered ? 0.65 : 1.0) : .white.opacity(hovered ? 0.65 : 1.0))
            .cornerRadius(10)
            .scaleEffect(set ? 1.0:0.9)
            .scaleEffect(!hovered ? 1.0:1.1)
            .offset(y: dragOffset)
            .gesture(
                LongPressGesture(minimumDuration: 0.05)
                    .updating($isLongPressing) { value, state, _ in
                        state = true
                    }
                    .sequenced(before: DragGesture())
                    .onChanged { value in
                        switch value {
                        case .first(true):
                            //check if extended long press gesture logic can be changed here
                            break
                        case .second(true, let dragValue):
                            translation = dragValue?.translation ?? .zero
                            dragOffset = translation.height
                            indexDiff = round(dragOffset / 61)
                            scalerIndex = CGFloat(index) + indexDiff
                            if set {
                                withAnimation{set = false}
                            }
                        default:
                            break
                        }
                    }
                    .onEnded { _ in
                        dragOffset = .zero
                        let dragged = texts.remove(at: index)
                        var newIndex = index + Int(indexDiff)
                        if newIndex < 0 {newIndex = 0}
                        if newIndex > (texts.count) { newIndex = texts.count }
                        texts.insert(dragged, at: newIndex)
                        set = true
                        scalerIndex = -1.0
                    }
            )
            .onChange(of: scalerIndex){ _ in
                if index == Int(scalerIndex){
                    withAnimation{hovered = true}
                }
                else{
                    withAnimation{hovered = false}
                }
            }
    }
}
