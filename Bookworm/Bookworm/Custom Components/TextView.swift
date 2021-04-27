//
//  TextView.swift
//  Bookworm
//
//  Created by Tino on 27/4/21.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    let placeholder: String
    @Binding var text: String
    let isEditable: Bool
    let placeholderColour = UIColor.lightGray
    
    init(_ placeholder: String = "Enter some text", text: Binding<String>, isEditable: Bool = true) {
        self.placeholder = placeholder
        _text = text
        self.isEditable = isEditable
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.layer.cornerRadius = 26
        textView.backgroundColor = UIColor(Color("textFieldColour"))
        textView.isEditable = isEditable
        textView.allowsEditingTextAttributes = true
        textView.font = UIFont.systemFont(ofSize: 25)
        textView.text = placeholder
        textView.textColor = placeholderColour
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        let parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == parent.placeholderColour {
                textView.text = nil
                textView.textColor = UIColor(Color("fontColour"))
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = parent.placeholderColour
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
