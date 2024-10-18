//
//  Question.swift
//  Project5_DavidPerez
//
//  Created by David Perez on 10/13/24.
//

import Foundation

struct Question: Codable, Identifiable {
    var id: UUID?  // Make id optional
    
    let type: String
    let difficulty: String
    let category: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
    var userAnswer: String?
    
    // Computed property for all answers
    var allanswers: [String] {
        incorrect_answers + [correct_answer]
    }
    
    // Custom initializer
    init(type: String, difficulty: String, category: String, question: String, correct_answer: String, incorrect_answers: [String], userAnswer: String?) {
        self.id = UUID()  // Generate UUID here
        self.type = type
        self.difficulty = difficulty
        self.category = category
        self.question = question
        self.correct_answer = correct_answer
        self.incorrect_answers = incorrect_answers
        self.userAnswer = userAnswer
    }
}
