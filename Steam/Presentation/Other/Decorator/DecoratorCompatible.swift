//
//  DecoratorCompatible.swift
//  Steam
//
//  Created by Ivan Zinovyev on 29/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

protocol DecoratorCompatible {

    associatedtype DecoratorCompatibleType

    var decorator: Decorator<DecoratorCompatibleType> { get }

}

extension DecoratorCompatible {

    var decorator: Decorator<Self> {
        return Decorator(object: self)
    }

}

extension NSObject: DecoratorCompatible {}
