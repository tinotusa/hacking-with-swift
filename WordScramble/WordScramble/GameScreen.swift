//
//  GameScreen.swift
//  WordScramble
//
//  Created by Tino on 19/4/21.
//

import SwiftUI

// MARK: TODO
// word checking has an problem
// check other screen sizes

struct GameScreen: View {
    @State private var usedWords = [String](repeating: "testing", count: 20)
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var showingError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ZStack {
                    Constants.background
                        .ignoresSafeArea()
                    
                    VStack {
                        restartButton
                        
                        Group {
                            Text("Make words from:")
                            Text(rootWord)
                        }
                        .font(.custom("kefa", size: proxy.size.width * 0.1))
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        
                        textbox
                            .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.18)
                        
                        Text("Used Words")
                            .font(.custom("kefa", size: proxy.size.width * 0.09))
                            .foregroundColor(.white)
        
                        usedWordsList
                            .frame(width: proxy.size.width * 0.9)
                            .animation(nil)
                    }
                }
                .blur(radius: showingError ? 6 : 0)
                if showingError {
                    errorPopup(proxy: proxy)
                }
            }
            .animation(.default)
        }
    }
}

private extension GameScreen {
    func errorPopup(proxy: GeometryProxy) -> some View {
        let width = proxy.size.width * 0.8
        let height = proxy.size.height * 0.2
        
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("darkBrown"))
                .frame(width: width, height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("lightBrown"), lineWidth: 10)
                )
                
            VStack {
                Text(errorTitle)
                    .underline()
                Text(errorMessage)
                    .frame(width: width)
                
                Button(action: {
                    showingError = false
                    newWord = ""
                }) {
                    Text("Dismiss")
                        .padding()
                }
                
            }
            .font(.custom("kefa", size: 18))
            .foregroundColor(.white)
        }
        .transition(.scale)
    }
    
    var restartButton: some View {
        HStack {
            Spacer()
            Button(action: startGame) {
                Text("Resest")
                    .padding(3)
                    .font(.custom("kefa", size: 23))
                    .foregroundColor(.white)
                    .background(Color("darkBrown"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("lightBrown"), lineWidth: 3))
                    .shadow(radius: 5)
                    
            }
        }
        .padding(.trailing)
    }

    var textbox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 27)
                .fill(Color("darkBrown"))
                .overlay(
                    RoundedRectangle(cornerRadius: 27)
                        .stroke(Color("lightBrown"), lineWidth: 4)
                )
                .shadow(radius: 10)
            TextField("...", text: $newWord, onCommit: addNewWord)
                .multilineTextAlignment(.center)
                .font(.custom("kefa", size: 30))
                .foregroundColor(.white)
        }
        .onAppear(perform:startGame)
    }
    
    var usedWordsList: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color("darkBrown"))
                .shadow(radius: 5)
            ScrollView {
                ForEach(usedWords, id: \.self) { word in
                    ListRow(word: word)
                        .frame(height: 70)
                        .padding(.horizontal)
                        .padding(.vertical, 3)
                }
            }
        }
        
    }
    
    // MARK: Functions
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognised", message: "You can't just make them up, you know?")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word (or it is the same as the root word or it is too short (less than 3 letters)")
            return
        }
        
        usedWords.insert(answer, at: 0)
        score += answer.count
        newWord = ""
    }
    
    func startGame() {
        let errorMessage = "Could not load start.txt from bundle."
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError(errorMessage)
        }
        guard let startWords = try? String(contentsOf: startWordsURL) else {
            fatalError(errorMessage)
        }
        let allWords = startWords.components(separatedBy: "\n")
        rootWord =  allWords.randomElement() ?? "silkworm"
        usedWords.removeAll()
        score = 0
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = word
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 || word == rootWord {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen()
    }
}
