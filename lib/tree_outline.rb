require 'tree_outline/version'

class TreeOutline
  DEFAULT = '├── '
  LINE    = '│   '
  SINGLE  = '└── '
  EMPTY   = '    '

  def initialize(tree)
    @tree = tree
  end

  def to_s
    build_lines(@tree).join("\n")
  end

  private

  def build_lines(node)
    return [node.to_s] if node.children.empty?
    result = node.children.map do |c|
      build_lines(c)
    end
    result = [node.to_s] + last_map(result,
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
end
