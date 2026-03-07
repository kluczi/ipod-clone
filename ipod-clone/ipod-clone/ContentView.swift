//
//  ContentView.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: IpodViewModel = IpodViewModel()
    var body: some View {
        IpodShellView()
            .environmentObject(vm)
    }
        
}

#Preview {
    ContentView()
}
