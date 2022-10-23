//
//  ContentView.swift
//  PickPhotosFromMacBook
//
//  Created by Ramill Ibragimov on 23.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var photos: [NSImage] = []
    
    var body: some View {
        NavigationView {
            Label("", systemImage: "plus.square.fill.on.square.fill")
                .font(.title)
                .onTapGesture {
                    selectPhotos()
                }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                    ForEach(photos, id: \.self) { photo in
                        if photo.isValid == true {
                            Image(nsImage: photo)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func selectPhotos() {
        let panel = NSOpenPanel()
        panel.prompt = "Choose Picture"
        panel.showsResizeIndicator = true
        panel.showsHiddenFiles = false
        panel.allowsMultipleSelection = true
        panel.allowedContentTypes = [.image, .jpeg, .png]
        
        if panel.runModal() == .OK {
            if let fileUrl = panel.url?.path {
                let photo = NSImage(contentsOf: URL(fileURLWithPath: fileUrl))
                self.photos.append(photo!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
