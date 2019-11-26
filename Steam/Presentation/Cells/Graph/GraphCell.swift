import ScrollableGraphView
import TableKit
import Utils

class GraphCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let dataPointSpacing: CGFloat = 50
        
        static let barLineWidth: CGFloat = 0
        
        static let barWidth: CGFloat = 10
        
    }
    
    // MARK: - Views
    
    private lazy var graphView: ScrollableGraphView = {
        let graphView = ScrollableGraphView()
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.shouldAdaptRange = true
        graphView.direction = .rightToLeft
        graphView.dataPointSpacing = Constants.dataPointSpacing
        
        let plot = BarPlot(identifier: .empty)
        plot.shouldRoundBarCorners = true
        plot.barLineWidth = Constants.barLineWidth
        plot.barWidth = Constants.barWidth
        graphView.addPlot(plot: plot)
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineColor = .clear
        graphView.addReferenceLines(referenceLines: referenceLines)
        
        graphView.dataSource = self
        return graphView
    }()

    // MARK: - Properties

    private var viewModel: GraphCellViewModel?
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(graphView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureGraphViewConstraints()
    }
    
}

// MARK: - ConfigureCell

extension GraphCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 250
    
    func configure(with viewModel: GraphCellViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - ScrollableGraphViewDataSource

extension GraphCell: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return item(for: pointIndex)?.value ?? 0
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return item(for: pointIndex)?.dateGraphString ?? .empty
    }
    
    func numberOfPoints() -> Int {
        return viewModel?.statItems.count ?? 0
    }
    
}

// MARK: - Constraints

private extension GraphCell {
    
    func configureGraphViewConstraints() {
        graphView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Private

private extension GraphCell {
    
    func item(for pointIndex: Int) -> StatItem? {
        guard let viewModel = viewModel else { return nil }
        let items = viewModel.statItems
        
        return items[items.count - pointIndex - 1]
    }
    
}
