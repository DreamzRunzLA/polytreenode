class PolyTreeNode
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def value
        @value
    end

    def parent=(node)
        if node == nil
            @parent = nil
            return
        else
            if @parent != nil
                temp = @parent
                @parent = node
                temp.children.delete(self)
                if node.children.include?(self) == false
                    node.children << self
                end
            end
            @parent = node
            if node.children.include?(self) == false
                node.children << self
            end
        end
    end

    def add_child(child)
        if @children.include?(child) == false
            @children << child
            child.parent=(self)
        end
    end

    def remove_child(child)
        if @children.include?(child) == false
            raise 'node is not a child'
        else
            @children.delete(child)
            child.parent=(nil)
        end
    end

    def dfs(target_value)
        if self.value == target_value
            return self
        end

        self.children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end

        return nil
    end

    def bfs(target_value)
        queue = []
        queue << self

        until queue == []
            result = queue.shift
            if result.value != target_value
                result.children.each do |child|
                    queue << child
                end
            else
                return result
            end
        end
        return nil
    end

end