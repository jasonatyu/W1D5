require_relative "../skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder

    attr_reader :considered_positions, :root_node

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        @starting_pos = pos
        build_move_tree
    end 

    def self.valid_moves(pos)
        moves = []
        x, y = pos 
        #this is for pawns; need to update for knights
        valid_shifts = [[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1],[2,1],[1,2]]
        valid_shifts.each do |shift|
            poss_x_moves = (x + shift[0] >= 0 && x + shift[0] < 8)
            poss_y_moves = (y + shift[1] >= 0 && y + shift[1] < 8)
            if poss_x_moves && poss_y_moves
                moves << [x + shift[0], y + shift[1]]
            end
        end
        # (-1..1).each do |row|
        #     (-1..1).each do |col|
        #         poss_x_moves = (x + row >= 0 && x + row < 8)
        #         poss_y_moves = (y + col >= 0 && y + col < 8)
        #         same_position = (row == 0 && col == 0)
        #         if poss_x_moves && poss_y_moves && !same_position
        #             moves << [x + row, y + col]
        #         end 
        #     end 
        # end
        moves
    end

    def new_move_positions(pos)
        possible_moves = self.class.valid_moves(pos)
        new_moves = possible_moves.reject { |move| @considered_positions.include?(move) }
        considered_positions.concat(new_moves)
        new_moves
    end 

    def build_move_tree 
        queue = [root_node]
        until queue.empty?
            # debugger
            # need to set parent!
            current_node = queue.shift
            new_positions = new_move_positions(current_node.value)

            new_positions.each do |pos|
                child = PolyTreeNode.new(pos)
                current_node.children << child
                current_node.add_child(child)
            end 

            current_node.children.each do |child|
                queue << child
            end 
        end
        root_node
    end 

    def find_path(end_pos)
        end_node = root_node.dfs(end_pos)
        trace_path_back(end_node)
    end 

    def trace_path_back(end_node)
        path = [end_node.value]
        current_node = end_node.parent
        while current_node != root_node
            path.unshift(current_node.value)
            current_node = current_node.parent
        end
        path.unshift(root_node.value)
    end 
end 
