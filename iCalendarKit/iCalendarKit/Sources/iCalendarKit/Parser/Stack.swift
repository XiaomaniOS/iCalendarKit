//
//  Stack.swift
//  Demo
//
//  Created by roy on 2019/7/10.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

protocol StackType {
    associatedtype T
    
    var store: [T] { get set }
}

extension StackType {
    var isEmpty: Bool {
        return store.isEmpty
    }
    
    var count: Int {
        return store.count
    }
    
    var bottom: T? {
        return store.first
    }
    
    var top: T? {
        return store.last
    }
}

extension StackType {
    mutating func push(_ item: T) {
        store.append(item)
    }
    
    @discardableResult
    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        return store.removeLast()
    }
    
    typealias ElementPredicater = (T) -> Bool
    func matchTop(with predicater: ElementPredicater) -> Bool {
        guard let top = top else { return false }
        
        return predicater(top)
    }
    
    mutating func popWhenMatchTop(with predicater: ElementPredicater) -> T? {
        guard matchTop(with: predicater) else { return nil }
        return pop()
    }
}

class Stack<T>: StackType {
    var store: [T]
    
    init() {
        store = []
    }
}
