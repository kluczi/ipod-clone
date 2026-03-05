//
//  IpodShellView.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct IpodShellView: View {
    @EnvironmentObject var vm: IpodViewModel

    var body: some View {
        ZStack {
            IpodFrame()
            VStack {
                IpodScreen()
                Spacer()
                ClickWheel()
            }
        }
    }
}

#Preview {
    IpodShellView()
}
