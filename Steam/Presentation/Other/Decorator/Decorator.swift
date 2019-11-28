//
//  Decorator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 29/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct Decorator<T> {
    
    let object: T
    
    func apply(_ decorations: Decoration<T>...) -> Void {
        decorations.forEach { $0(object) }
    }

}
