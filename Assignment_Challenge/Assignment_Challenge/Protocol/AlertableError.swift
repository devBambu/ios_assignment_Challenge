//
//  Error.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/19/26.
//

import Foundation

protocol AlertableError: Error {
    func title() -> String
    func message() -> String
}

extension AlertableError {
    func title() -> String { return "Error" }
    func message() -> String { return "알 수 없는 오류입니다.\n\(self.localizedDescription)" }
}


