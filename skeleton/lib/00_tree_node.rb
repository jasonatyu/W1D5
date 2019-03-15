require 'byebug'

class PolyTreeNode
    attr_reader :value
    attr_accessor :parent, :children

    def initialize(value)
        @value = value 
        @parent = nil 
        @children = []
    end 

    def parent=(node)

        if !self.parent.nil? 
            new_children = []
            self.parent.children.each do |child|
                new_children << child if child != self 
            end 
            self.parent.children = new_children
        end

        if node.nil?
            @parent = nil
        else
            @parent = node
            node.children << self unless node.children.include?(self)
        end 
    end 

    def add_child(node)
        node.parent = self 
    end 

    def remove_child(node)
        if node.parent == nil 
            raise "error"
        else 
            node.parent = nil 
        end 
    end 

    def dfs(target_value)
        #base case 
        return self if self.value == target_value 
        self.children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end 
        nil
    end 

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            current_node = queue.shift 
            return current_node if current_node.value == target_value
            queue.concat(current_node.children)
        end
        nil 
    end 

end