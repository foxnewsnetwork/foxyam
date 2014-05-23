class FunctionalSupport::FreeTree
  TraverseTypes = [:depth, :breadth].freeze
  include Enumerable
  attr_accessor :data, :parent, :children
  def initialize(data=nil, parent=nil)
    @data, @parent = data, parent
  end

  def add_child(datum)
    self.class.new(datum, self).tap do |child|
      @children.push child
    end
  end

  def map(&block)
    self.class.new(yield(data), self).tap do |node|
      node.children = children.map { |child| child.map(&block) }
    end
  end

  def each(&block)
    yield data
    children.each(&block)
  end

  def children
    @children ||= []
  end

  def leaf?
    children.blank?
  end

  def root?
    parent.blank?
  end
end