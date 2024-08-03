//
//  OffsetKey.swift
//  Task Management
//
//  Created by Mayur Vaity on 03/08/24.
//

import SwiftUI

//??
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
