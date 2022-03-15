import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Private properties
    private let cellIdentifier = "repositoryCell"
    private var viewModel: ViewModelProtocol?
    private var fetchingMore = false
    private var phrase: String = "graphql"
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private var contentToDisplay: [RepositoryObjectDetails]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Constructor
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Github users"
        viewModel?.delegate = self
        viewModel?.search(phrase: phrase)
        setupTableView()
    }
    
   private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func spinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    private func showAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: "\(errorMessage)", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.search(phrase: self.phrase)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
}

    // MARK: Protocols implementations
extension ViewController: ViewModelDelegate {
    func didFailed(error: String) {
        DispatchQueue.main.async {
            self.showAlert(errorMessage: error)
        }
    }
    
    func show(content: [RepositoryObjectDetails]) {
        if !fetchingMore {
            contentToDisplay = content
        } else {
            contentToDisplay?.append(contentsOf: content)
            fetchingMore = false
        }
    }
    
    func showLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if !self.fetchingMore {
                isLoading ? self.showSpinner() : self.removeSpinner()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentToDisplay?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepositoryCell else { return UITableViewCell() }
        
        let contentObj = contentToDisplay?[indexPath.row]
        cell.setup(object: contentObj)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if fetchingMore {
            self.tableView.tableFooterView = spinnerFooter()
        }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        viewModel?.search(phrase: phrase)
    }
}
