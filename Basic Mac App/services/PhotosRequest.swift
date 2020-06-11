import Foundation
import Alamofire

enum PhotoError: Error {
    case photosNotFound, invalidRequest
}
protocol PhotosRequest {
      func getPhotos(completion: @escaping (Result<[Photo], PhotoError>) -> Void)
}
class ApiPhotosRequest: PhotosRequest {
    
    var apiURL: String
    
    init() {
        apiURL = APIs.photoURL
    }
    
    func getPhotos(completion: @escaping (Result<[Photo], PhotoError>) -> Void) {
        AF.request(apiURL).responseData { response in
            guard let data = response.data else {
                completion(.failure(.photosNotFound))
                return
            }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(.invalidRequest))
            }
        }
    }
}
