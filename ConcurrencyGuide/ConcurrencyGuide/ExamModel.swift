//
//  ExamModel.swift
//  ConcurrencyGuide
//
//  Created by Giuseppe Carannante on 31/03/22.
//

import Foundation

struct ExamModel: Codable, Identifiable {
    
    var id: UUID?

    var name: String
    
    var course: String
    
    var exam_id: String


    init(id: UUID? = nil, name: String, course: String, exam_id: String) {
        self.id = id
        self.name = name
        self.course = course
        self.exam_id = exam_id

    }
    
    static func decodeExam(from data: Data) throws -> [ExamModel]{
        let JSONDecoder = JSONDecoder()
        return try JSONDecoder.decode([ExamModel].self, from: data)
    }
}
