describe TreeOutline do
  it 'has a version number' do
    expect(TreeOutline::VERSION).not_to be nil
  end

  it 'renders a tree' do
    Node = Struct.new(:label, :children) do
      alias_method :to_s, :label
    end

    tree = Node.new('root', [
      Node.new('first-node',  Array.new),
      Node.new('second-node', [
        Node.new('inner-first',  [Node.new('most-inner', [])]),
        Node.new('inner-second', [
          Node.new('first-node',  Array.new),
          Node.new('second-node', [
            Node.new('inner-first',  [Node.new('most-inner', [])]),
            Node.new('inner-second', []),
            Node.new('inner-last',   [])
          ]),
          Node.new('third-node',  Array.new)
        ]),
        Node.new('inner-last',   [])
      ]),
      Node.new('third-node',  Array.new)
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
end
