import Alamofire

class ApiService {
    
    // Method to fetch users
    static func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = AppUrls.baseURL + AppUrls.usersEndpoint
        
        AF.request(url).responseDecodable(of: [User].self) { response in
            switch response.result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
