// ContentView.swift

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @Environment(\.scenePhase) private var scenePhase
    @State private var selectedUser: User? = nil

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(Array(viewModel.users.enumerated()), id: \ .0) { index, user in
                                    HStack(spacing: 16) {
                                        VStack(alignment: .leading) {
                                            Text(user.name)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(user.email)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        ZStack {
                                            Circle()
                                                .fill(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .frame(width: 60, height: 60)
                                            Text("\(index + 1)")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .onTapGesture {
                                        selectedUser = user
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                if let user = selectedUser {
                    PopupView(user: user, isPresented: $selectedUser)
                }
            }
            .navigationTitle("Users")
            .onAppear {
                print("ContentView appeared")
                viewModel.fetchUsers()
            }
            .onDisappear {
                print("ContentView disappeared")
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .active:
                    print("App became active (onResume)")
                    viewModel.fetchUsers()
                case .inactive:
                    print("App is inactive")
                case .background:
                    print("App moved to background (onPause)")
                default:
                    break
                }
            }
        }
    }
}

struct PopupView: View {
    var user: User
    @Binding var isPresented: User?

    var body: some View {
        VStack(spacing: 20) {
            Text("User Info")
                .font(.title)
                .bold()
            Text("Name: \(user.name)")
                .font(.headline)
            Text("Email: \(user.email)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Button("Close") {
                isPresented = nil
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

#Preview {
    ContentView()
}
