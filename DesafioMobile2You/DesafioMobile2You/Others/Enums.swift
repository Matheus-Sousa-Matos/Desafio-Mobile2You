//
//  Enums.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

enum ServiceError: Error{
    case invalidURL
    case decodeFail(Error?)
    case newtowrk(Error?)
}
