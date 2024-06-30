//
//  ContentView.swift
//  SwiftUIBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 30.06.2024.
//

import SwiftUI

// Convert a view from UIKit to SwiftUI
/*
 Representable view swiftUI da bulunmayan ya da yeterince özellleştiremediğimiz view ları UIKitten uyarlamamızı sağlar.
 Bu örnekte TextField placeholder özelleştirme örneği yapıldı.SwiftUI da özelleştirilemediği için.
 */

struct UIViewRepresentableBootcamp: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            
            HStack {
                Text("SwiftUI:")
                TextField("Type here..", text: $text)
                    .frame(height: 55)
                    .background(.gray)
            }
            
            HStack {
                Text("UIKit:")
                UITextFieldViewRepresentable(text: $text, placeholder: "Type here..")
                    .frame(height: 55)
                    .background(.gray)
            }
           
                
            
            
        }
        
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}


struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    let placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String, placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
        
    }
    
    // From SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : placeholderColor])
        textField.attributedPlaceholder = placeholder
        return textField
    }
    
    // From UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
    
    
}
