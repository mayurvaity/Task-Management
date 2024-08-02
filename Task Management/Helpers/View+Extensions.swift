//
//  View+Extensions.swift
//  Task Management
//
//  Created by Mayur Vaity on 02/08/24.
//

import SwiftUI

//Custom view extensions (these are custom modifiers) 
extension View {
    //custom spacers
    //horizontal spacer - to add horizontal spacing before/ after a view based on alignment
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    //vertical spacer - to add vertical spacing above/ below a view based on alignment
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
