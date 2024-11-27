//
//  Topic.swift
//  11+ Quiz
//
//  Created by amith reddy on 27/11/2024.
//


import SwiftUI

struct Topic: Identifiable, Hashable{
    let id = UUID()
    let title: String
    let subject: String
}