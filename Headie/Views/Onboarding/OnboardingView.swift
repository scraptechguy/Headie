//
//  OnboardingView.swift
//  Headie
//
//  Created by Rostislav Brož on 12/31/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        Button(action: {
            model.requestGeolocationPermission()
        }, label: {
            Text("Request location")
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
