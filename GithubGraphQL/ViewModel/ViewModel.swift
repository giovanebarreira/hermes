import Apollo
import Foundation

protocol ViewModelProtocol {
    func search(phrase: String)
    var delegate: ViewModelDelegate? { get set }
}

protocol ViewModelDelegate: AnyObject {
    func show(content: [RepositoryObjectDetails])
    func didFailed(error: String)
    func showLoading(_ isLoading: Bool)
}

final class ViewModel: ViewModelProtocol {
    private let client: GraphQLClient
    private var endCursor: Cursor? = nil
    weak var delegate: ViewModelDelegate?
    
    init(client: GraphQLClient = ApolloClient.shared) {
        self.client = client
    }
    
    func search(phrase: String) {
        delegate?.showLoading(true)
        
        self.client.searchRepositories(mentioning: phrase, filter: .after(endCursor, limit: 15), cachePolicy: .returnCacheDataElseFetch) { [weak self] response in
            var repositoryObjectDetails: [RepositoryObjectDetails] = []
            
            switch response {
            case let .failure(error):
                self?.delegate?.didFailed(error: error.localizedDescription)
                
            case let .success(results):
                let pageInfo = results.pageInfo
                self?.endCursor = Cursor(rawValue: pageInfo.endCursor ?? "")
                
                results.repos.forEach { repository in
                    repositoryObjectDetails.append(RepositoryObjectDetails(repositoryDetails: repository))
                }
                
                self?.delegate?.show(content: repositoryObjectDetails)
            }
            self?.delegate?.showLoading(false)
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
