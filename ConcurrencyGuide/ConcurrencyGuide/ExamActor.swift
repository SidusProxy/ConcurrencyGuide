//
//  Exam.swift
//  ConcurrencyGuide
//
//  Created by Giuseppe Carannante on 31/03/22.
//

import Foundation

actor ExamActor {
    
    private var urlComponents = URLComponents(string: "http://127.0.0.1:8080")!
    
    func getExams() async throws -> [ExamModel] {
        urlComponents.path = "/exam"
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            
            throw ExamError.serverError
            
        }
        let exams = try? ExamModel.decodeExam(from: data)
        return exams ?? []
    }
    
    func getExams(examID: String) async throws -> ExamModel? {
        urlComponents.path = "/exam/\(examID)"
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            
            throw ExamError.serverError
            
        }
        let exam = try? ExamModel.decodeExam(from: data).first
        return exam
    }
    
    func createExam(exam: ExamModel) async throws {
        urlComponents.path = "/exam"
        
        
        guard let JSONData = try? JSONEncoder().encode(exam) else {
            throw ExamError.creationFailed
        }
        
        
        var request = getRequest(url: urlComponents.url!, method: "POST")
        request.httpBody = JSONData
        print("\(request)")
        let (_, response) = try await URLSession.shared.data(for: request as URLRequest)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ExamError.serverError
        }
        
    }
    
    func updateExam(oldName: String, newName: String) async throws {
        urlComponents.path = "/updateNameExam/\(oldName)/\(newName)"
        
        let request = getRequest(url: urlComponents.url!, method: "PUT")
        
        let (_, response) = try await URLSession.shared.data(for: request as URLRequest)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            
            throw ExamError.serverError
            
        }
    }
    //
    //    func getAllTables(examIDs: [String]) async throws -> [ExamModel]{
    //        let examArr = await withTaskGroup(of: [ExamModel].self){group -> [ExamModel] in
    //            var examModelArr = [ExamModel]()
    //            for exam in examIDs {
    //                group.addTask {
    //                    return try! await self.getExams(examID: exam)
    //                }
    //
    //            }
    //
    //            return examModelArr
    //        }
    //        return examArr
    //    }
    
    private func getRequest(url: URL, method: String) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        return request
    }
}
