require 'tree_outline/version'

class TreeOutline
  DEFAULT = '├── '
  LINE    = '│   '
  SINGLE  = '└── '
  EMPTY   = '    '

  def initialize(tree)
    @tree = tree
    @label_method = :to_s
    @children_method = :children
  end

  def label_method(method_symbol)
    @label_method = method_symbol
    self
  end

  def children_method(method_symbol)
    @children_method = method_symbol
    self
  end

  def to_s
    build_lines(@tree).join("\n")
  end

  private

  def build_lines(node)
    return [node_label(node)] if is_leaf?(node)
    result = node_children(node).map do |c|
      build_lines(c)
    end
    result = [node_label(node)] + last_map(result,
      ->(block){
        first_map(block, ->(line){ DEFAULT+line }, ->(line){ LINE+line })
      },
      ->(block){
        first_map(block, ->(line){ SINGLE+line }, ->(line){ EMPTY+line })
      }
    ).flatten(1)
  end

  def first_map(enumerable, first, other)
    result = [first.call(enumerable.first)]
    result += enumerable.drop(1).map do |e|
      other.call(e)
    end
    result
  end

  def last_map(enumerable, other, last)
    result = enumerable[0..-2].map do |e|
      other.call(e)
    end
    result = result + [last.call(enumerable.last)]
    result
  end

  def is_leaf?(node)
    # mind the order of this OR statement, it's important
    !node.respond_to?(@children_method) || node_children(node).nil? || node_children(node).empty?
  end

  def node_label(node)
    node.public_send @label_method
  end

  def node_children(node)
    node.public_send @children_method
  end
end
