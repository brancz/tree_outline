describe TreeOutline do
  it 'has a version number' do
    expect(TreeOutline::VERSION).not_to be nil
  end

  it 'renders a tree in awesome extended ASCII characters' do
    node = Struct.new(:label, :children) do
      alias_method :to_s, :label
    end

    tree = node.new('root', [
      node.new('first-node',  Array.new),
      node.new('second-node', [
        node.new('inner-first',  [node.new('most-inner', [])]),
        node.new('inner-second', [
          node.new('first-node',  Array.new),
          node.new('second-node', [
            node.new('inner-first',  [node.new('most-inner', [])]),
            node.new('inner-second', []),
            node.new('inner-last',   [])
          ]),
          node.new('third-node',  Array.new)
        ]),
        node.new('inner-last',   [])
      ]),
      node.new('third-node',  Array.new)
    ])

    outline = TreeOutline.new(tree)

    expect(outline.to_s).to eq(
      "root
       ├── first-node
       ├── second-node
       │   ├── inner-first
       │   │   └── most-inner
       │   ├── inner-second
       │   │   ├── first-node
       │   │   ├── second-node
       │   │   │   ├── inner-first
       │   │   │   │   └── most-inner
       │   │   │   ├── inner-second
       │   │   │   └── inner-last
       │   │   └── third-node
       │   └── inner-last
       └── third-node".gsub(/^( |\t)+/, "")
    )
  end

  it 'allows passing a method to use for labeling a node' do
    node = Struct.new(:label, :children)
    tree = node.new('root', [node.new('first', [])])

    expect(TreeOutline.new(tree).label_method(:label).to_s).to eq(
      "root
       └── first".gsub(/^( |\t)+/, "")
    )
  end

  it 'allows passing a method to use for retrieving a nodes children' do
    folder = Struct.new(:label, :subfolders) do
      alias_method :to_s, :label
    end

    tree = folder.new('root', [folder.new('first', [])])

    expect(TreeOutline.new(tree).children_method(:subfolders).to_s).to eq(
      "root
       └── first".gsub(/^( |\t)+/, "")
    )
  end
end
