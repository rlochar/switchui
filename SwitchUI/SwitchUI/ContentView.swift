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
			FailedLoginView()
		case .success:
			LoggedInView()
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

struct LoggedInView: View {
	
	var body: some View {
		ZStack {
			Image(systemName: "checkmark.square.fill")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 350)
				.foregroundStyle(.green)
				.opacity(0.1)
			
			VStack {
				Text("Success!")
					.fontDesign(.monospaced)
					.font(.largeTitle)
					.padding()
				
				Text("Congratulations, you are now logged in!")
					.fontWeight(.semibold)
			}
		}
	}
}

struct FailedLoginView: View {
	
	var body: some View {
		ZStack {
			Image(systemName: "x.square.fill")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 350)
				.foregroundStyle(.red)
				.opacity(0.1)
			
			VStack {
				Text("Failed!")
					.fontDesign(.monospaced)
					.font(.largeTitle)
					.padding()
				
				Text("You failed to log in, you will be terminated.")
					.fontWeight(.semibold)
			}
		}
	}
}

