//
//  Date+.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 01/04/24.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
