//
//  Errors.swift
//  ConcurrencyGuide
//
//  Created by Giuseppe Carannante on 31/03/22.
//

import Foundation

enum ExamError: Error, LocalizedError {
    case itemNotFound, creationFailed, serverError
    
    var localizedDescription: String {
        switch self {
        case .itemNotFound:
            return "I could not find the item I was looking for, it could be a server problem or not..."
        case .creationFailed:
            return "I was unable to create the desired item, it could be a server problem or not..."
        case .serverError:
            return "This is definitely a server error, ask a mentor what is going on ..."
        }
    }
}
