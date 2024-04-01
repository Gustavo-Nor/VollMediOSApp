//
//  String+.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 01/04/24.
//

import Foundation

extension String {
    func convertDateStringToReadableDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        if let date = inputFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
}
