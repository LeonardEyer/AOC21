module Day12

    mutable struct GraphNode
        id::Int
        name::String
        explored::Bool
    end

    mutable struct Graph
        nodes::Vector{GraphNode}
        adjacency::Matrix
    end

    function GraphNode(id, name)
        return GraphNode(id, name, false)
    end

    function is_big(a::GraphNode)
        return uppercase(a.name) == a.name
    end

    function add_edge!(a::GraphNode, b::GraphNode, G::Graph)
        G.adjacency[a.id, b.id] = 1
        G.adjacency[b.id, a.id] = 1
    end

    function get_neighbours(a::GraphNode, G::Graph)
        neighbour_ids = findall(x -> x == 1, G.adjacency[a.id, :])
        return G.nodes[neighbour_ids]
    end

    mutable struct BFSNode
        id::Int
        graphNode::GraphNode
        parent::Union{Nothing, BFSNode}
        children::Vector{BFSNode}
        explored::Bool
    end

    mutable struct BFSTree
        node_count::Int
        root::Union{Nothing, BFSNode}
        nodes::Vector{BFSNode}
    end

    function BFSNode(t::BFSTree, node::GraphNode)
        id = t.node_count
        t.node_count += 1
        return BFSNode(id, node, nothing, [], false)
    end

    function BFSTree()
        return BFSTree(0, nothing, [])
    end

    function visited_before(x::BFSNode, node::GraphNode)
        curr = x
        while curr !== nothing
            if curr.graphNode.id == node.id
                return true
            else
                curr = curr.parent
            end
        end
        return false
    end

    function parse_input(input::String)
        egdes = map(x -> split(x, '-'), split(input, '\n'))

        nodes = filter(x -> !(x in ["start", "end"]), unique(Iterators.flatten(egdes)))
        insert!(nodes, 1, "start")
        push!(nodes, "end")
        nodes = map((x) -> GraphNode(x[1], x[2]), enumerate(nodes))

        adjacency = zeros(Int, (length(nodes), length(nodes)))
        G = Graph(nodes, adjacency)

        for e in egdes
            a = nodes[findfirst(x -> x.name == e[1], nodes)]
            b = nodes[findfirst(x -> x.name == e[2], nodes)]

            add_edge!(a, b, G)
        end
        return G
    end

    function part1(input::String)
        G = parse_input(input)    

        tree = BFSTree()
        root_node = BFSNode(tree, G.nodes[1])
        tree.root = root_node

        exploring_queue = [root_node]
        while !isempty(exploring_queue)
            curr = pop!(exploring_queue)
            curr.explored = true
            
            # Sink
            if curr.graphNode == G.nodes[end]
                continue
            end

            neighbours = get_neighbours(curr.graphNode, G)
            # Get all neighbours that can be visited (possibly again)
            visitable_neighbours = filter(x -> is_big(x) || !visited_before(curr, x), neighbours)

            # Enqueue all neighbours
            for n in visitable_neighbours
                new_neighbour = BFSNode(tree, n)
                new_neighbour.parent = curr
                push!(tree.nodes, new_neighbour)
                push!(curr.children, new_neighbour)
                push!(exploring_queue, new_neighbour)
            end
        end

        possible_paths = filter(x -> isempty(x.children) && x.graphNode == G.nodes[end], tree.nodes)

        return length(possible_paths)
    end

    function part2(input::String)
        G = parse_input(input)
    end
end