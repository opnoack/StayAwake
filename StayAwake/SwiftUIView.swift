//
//  SwiftUIView.swift
//  StayAwake
//
//  Created by Oliver Philipp Noack on 8/12/2022.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
