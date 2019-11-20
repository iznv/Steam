//
//  TableDirector+Replace.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import TableKit

extension TableDirector {
    
    func replace(with sections: [TableSection]) {
        clear()
        append(sections: sections)
        reload()
    }
    
}
