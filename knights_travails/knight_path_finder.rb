require_relative "../skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        @starting_pos = pos
        build_move_tree
    end 

    def self.valid_moves(pos)
        moves = []
        x, y = pos 
        (-1..1).each do |row|
            (-1..1).each do |col|
                poss_x_moves = (x + row >= 0 && x + row < 8)
                poss_y_moves = (y + col >= 0 && y + col < 8)
                same_position = (row == 0 && col == 0)
                if poss_x_moves && poss_y_moves && !same_position
                    moves << [x + row, y + col]
                end 
            end 
        end
        moves
    end

    def new_move_positions(pos)
        possible_moves = self.class.valid_moves(pos)
        possible_moves.reject { |move| @considered_positions.include?(move) }
    end 

    # def build_move_tree 
    #     queue = [self.root_node]
    #     current_node = queue.shift
    #     new_positions = new_move_positions(current_node)

    #     new_positions.each do |pos|
    #         current_node.children << PolyTreeNode.new(pos)
    #     end 

    #     current_node.children.each do |child|
    #         queue << child
    #     end 
    # end 

    def find_path

    end 

    private
    attr_reader :considered_positions
end 

# n = KnightPathFinder.new([3,4])
# n.considered_positions << [3,3]
# n.considered_positions << [4,4]

# p n.new_move_positions([3,4])