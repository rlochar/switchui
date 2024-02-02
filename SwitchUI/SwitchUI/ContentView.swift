//
//  ContentView.swift
//  SwitchUI
//
//  Created by Roar Lochar on 02/02/2024.
//

import SwiftUI

class MyViewModel: ObservableObject {
	enum state {
		case fail
		case success
		case login
	}
	
	var currentState: state = .login
}

struct ContentView: View {
	@StateObject var viewModel = MyViewModel()
	
	var body: some View {
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundStyle(.tint)
			Text("Hello, world!")
		}
		.padding()
	}
}

#Preview {
	ContentView()
}
