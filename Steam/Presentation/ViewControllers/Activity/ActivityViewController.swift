import TableKit
import Utils

class ActivityViewController: BaseTableViewController<ActivityViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Views

    

    // MARK: - Properties
    
    lazy var tableDirector = TableDirector(tableView: tableView)

    

    // MARK: - Computed Properties



    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = R.string.localizable.activityTabTitle()

    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }
    
    // MARK: - Overrides

    

}

// MARK: - Table

private extension ActivityViewController {
    
    // MARK: - Sections
    
    var section: TableSection {
        return TableSection(onlyRows: [
            
        ])
    }
    
    // MARK: - Rows
    
    
    
}

// MARK: - Actions

private extension ActivityViewController {

    

}

// MARK: - Constraints

private extension ActivityViewController {

    

}

// MARK: - Private

private extension ActivityViewController {

    

}
