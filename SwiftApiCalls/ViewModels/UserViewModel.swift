// UserViewModel.swift

import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // Call the NetworkService to fetch users
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        
        // Using NetworkService to fetch users
        ApiService.fetchUsers { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

