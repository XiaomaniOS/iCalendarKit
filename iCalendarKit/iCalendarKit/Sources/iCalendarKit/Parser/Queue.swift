//
//  Queue.swift
//  Demo
//
//  Created by roy on 2019/7/11.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

class ListNode<T> {
    var data: T
    var next: ListNode?
    
    init(_ data: T) {
        self.data = data
    }
}

public class Queue<T> {
    var head: ListNode<T>?
    var tail: ListNode<T>?
    
    var isEmpty: Bool {
        return nil == head
    }
    
    func put(_ data: T) {
        let newTail = ListNode<T>(data)
        
        guard !isEmpty else {
            head = newTail
            tail = newTail
            return
        }
        
        tail?.next = newTail
    }
    
    func pull() -> T? {
        guard !isEmpty else {
            return nil
        }
        
        let pulled = head
        head = head?.next
        return pulled?.data
    }
    
    func pullAll() -> [T]? {
        guard !isEmpty else {
            return nil
        }
        
        var result = [T]()

        while let node = head {
            result.append(node.data)
            head = head?.next
        }
        
        return result
    }
}
