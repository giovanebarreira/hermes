import Apollo
import Foundation

protocol ViewModelProtocol {
    func search(phrase: String)
    var delegate: ViewModelDelegate? { get set }
}

protocol ViewModelDelegate: AnyObject {
    func show(content: [RepositoryObjectDetails])
}

final class ViewModel: ViewModelProtocol {
    private let client: GraphQLClient
    private var endCursor: Cursor? = nil
    weak var delegate: ViewModelDelegate?
    
    init(client: GraphQLClient = ApolloClient.shared) {
        self.client = client
    }
    
    func search(phrase: String) {
        self.client.searchRepositories(mentioning: phrase, filter: .after(endCursor, limit: 15)) { [weak self] response in
            guard let self = self else { return }
            var repositoryObjectDetails: [RepositoryObjectDetails] = []
            
            switch response {
            case let .failure(error):
                print(error)
                
            case let .success(results):
                let pageInfo = results.pageInfo
                self.endCursor = Cursor(rawValue: pageInfo.endCursor ?? "")
                
                results.repos.forEach { repository in
                    repositoryObjectDetails.append(RepositoryObjectDetails(repositoryDetails: repository))
                }
                
                self.delegate?.show(content: repositoryObjectDetails)
            }
        }
    }
}

// MARK: - Response encapsulation
struct RepositoryObjectDetails {
    private let repositoryDetails: RepositoryDetails
    
    init(repositoryDetails: RepositoryDetails) {
        self.repositoryDetails = repositoryDetails
    }
    
    var repoNameText: String {
        return repositoryDetails.name
    }
    
    var urlText: String {
        return repositoryDetails.url
    }
    
    var owner: String {
        return repositoryDetails.owner.login
    }
    
    var avatarUrl: URL? {
        guard let avatarUrl = URL(string: repositoryDetails.owner.avatarUrl) else { return URL(string: "") }
        return avatarUrl
    }
    
    var stars: String {
        return String(repositoryDetails.stargazers.totalCount)
    }
}


//        print("pageInfo: \n")
//        print("hasNextPage: \(pageInfo.hasNextPage)")
//        print("hasPreviousPage: \(pageInfo.hasPreviousPage)")
//        print("startCursor: \(String(describing: pageInfo.startCursor))")
//        print("endCursor: \(String(describing: pageInfo.endCursor))")
//        print("\n")

//          print("Name: \(repository.name)")
//          print("Path: \(repository.url)")
//          print("Owner: \(repository.owner.login)")
//          print("avatar: \(repository.owner.avatarUrl)")
//          print("Stars: \(repository.stargazers.totalCount)")
//          print("\n")
