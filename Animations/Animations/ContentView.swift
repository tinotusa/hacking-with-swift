//
//  ContentView.swift
//  Animations
//
//  Created by Tino on 18/3/21.
//

import SwiftUI

struct ContentView: View {
//    @State private var animationAmount = CGFloat(1)
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello SwiftUI")
    
    @State private var showingRed = false
    var body: some View {
//        -------------------- custom transitions --------------------
        VStack {
            Button("Tap me") {
                withAnimation {
                showingRed.toggle()
                }
            }
            if showingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
                }
        }
        

////        -------------------- view transitions --------------------
//        VStack {
//            Button("Tap me") {
//                withAnimation {
//                    showingRed.toggle()
//                }
//            }
//            if showingRed {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
//            }
//        }
        
        
//        -------------------- animating gestures --------------------
//        LinearGradient(gradient: Gradient(colors: [.yellow, .blue]), startPoint: .top, endPoint: .bottom)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .animation(nil)
//            .gesture(
//                DragGesture()
//                    .onChanged { dragAmount = $0.translation }
//                    .onEnded { _ in
//                        withAnimation(.spring()) {
//                            dragAmount = .zero
//                        }
//                    }
//            )
            
//        HStack(spacing: 0) {
//            ForEach(0 ..< letters.count) { index in
//                Text(String(letters[index]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? Color.blue : Color.red)
//                    .offset(dragAmount)
//                    .animation(Animation.default.delay(Double(index) / 20))
//
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { size in dragAmount = size.translation}
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
        
        
        
//        -------------------- animation stack --------------------
//        Button("tap me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? Color.blue : Color.red)
//        .foregroundColor(.white)
//        .animation(nil)
//        .clipShape(
//            RoundedRectangle(cornerRadius: enabled ? 60 : 0)
//        )
//        .animation(.interpolatingSpring(stiffness: 20, damping: 1))
        
//        -------------------- explicit animations --------------------
//        Button("Tap me") {
//            withAnimation(
//                Animation.interpolatingSpring(stiffness: 50, damping: 5)
//            ) {
//                animationAmount += 360
//            }
//        }
//        .padding(40)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 1))
        
        
//        print(animationAmount)
//        -------------------- animation binding --------------------
//        return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
//            Spacer()
//            Button("Tap me") {
//                animationAmount += 1
//            }
//            .padding(40)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
        
        
//        Button("Tap me") {
////            animationAmount += 1
//        }
//        .padding(20)
//        .background(Color.blue)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//
//        .blur(radius: (animationAmount - 1) * 3)
//        .scaleEffect(animationAmount)
////       -------------------- implicit animations --------------------
//        .animation(.default)
//        .animation(.easeOut)
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
//        .animation(.easeInOut(duration: 2))
//
////        -------------------- customizing animations --------------------
//        .animation(
//            Animation.easeInOut(duration: 2)
//                .delay(1)
//        )
//        .animation(
//            Animation.easeInOut(duration: 1)
//                .repeatCount(2, autoreverses: true)
//        )
//        .animation(
//            Animation.easeInOut(duration: 1)
//                .repeatForever(autoreverses: true)
//        )
//        .overlay(
//            Circle()
//                .stroke(Color.red)
//                .scaleEffect(animationAmount)
//                .opacity(Double(2 - animationAmount))
//                .animation(
//                    Animation.easeOut(duration: 1)
//                        .repeatForever(autoreverses: false)
//                )
//        )
//        .onAppear {
//            animationAmount = 2
//        }
    }
}

// custom transition
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading),
                  identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
