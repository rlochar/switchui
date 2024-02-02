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
	
	@Published var didLogin: Bool = true {
		didSet {
			currentState = didLogin ? .success : .fail
		}
	}
}

struct ContentView: View {
	@StateObject var viewModel = MyViewModel()
	
	var body: some View {
		switch viewModel.currentState {
		case .fail:
			Text("Fail")
		case .success:
			Text("Success")
		case .login:
			LoginView(isLoggedIn: $viewModel.didLogin)
		}
	}
}

#Preview {
	ContentView()
}

struct LoginView: View {
	@Binding var isLoggedIn: Bool
	@State var username: String = ""
	
	var body: some View {
		VStack {
			Text("Welcome!")
				.fontDesign(.monospaced)
				.font(.largeTitle)
				.padding()
			
			TextField("Username", text: $username)
				.padding(.horizontal, 40)
				.textFieldStyle(.roundedBorder)
			TextField("Password", text: $username)
				.padding(.horizontal, 40)
				.textFieldStyle(.roundedBorder)
			
			HStack {
				Button("Log in", action: {
					isLoggedIn = true
				})
				.font(.title3)
				.buttonStyle(.bordered)
				.padding()
				
				Button("Fail", action: {
					isLoggedIn = false
				})
				.font(.title3)
				.buttonStyle(.bordered)
				.padding()
			}
		}
	}
}
