class Paths
  def initialize(g, s)
    @g = g
    @s = s

    bfs
  end

  def has_path_to?(v)
    !!@distance[v]
  end

  def path_to(v)
    return nil if !has_path_to?(v)
    path = []
    x = v

    while x != @s do
      path.unshift(x)
      x = @edge_to[x]
    end

    path.unshift(@s)

    path
  end

  def distance(v)
    @distance[v]
  end

  private
  def bfs
    @edge_to = Array.new(@g.v)
    @distance = Array.new(@g.v)

    queue = [@s]
    @distance[@s] = 0

    while queue.any?
      v = queue.pop

      @g.adj(v).each do |a|
        if !@distance[a]
          @distance[a] = @distance[v] + 1
          @edge_to[a] = v
          queue.unshift(a)
        end
      end
    end
  end
end