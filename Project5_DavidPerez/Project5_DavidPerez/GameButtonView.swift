//
//  GameButtonView.swift
//  Project5_DavidPerez
//
//  Created by David Perez on 10/17/24.
//

import SwiftUI

struct GameButtonView: View {
    @State var pressed = false
    var answer: String
    @Binding var question: Question
    var body: some View {
        Button(action: {
            pressed = true
            question.userAnswer = answer
            print("state of press: \(pressed)")
        }, label: {
            Rectangle()
                .frame(height: 50)
                .tint(Color.init(red: 0.9575, green: 0.9575, blue: 0.9575))
                .overlay(content: {
                    Text("\(answer)")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .overlay(content: {
                            HStack{
                                if(pressed){
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                        
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                })
                .clipShape(.buttonBorder)
            
        })
        .padding(.horizontal)
    }
}

#Preview {
    GameButtonView(answer: "", question: .constant(Question(type: "", difficulty: "", category: "", question: "", correct_answer: "", incorrect_answers: [], userAnswer: "")))
}
