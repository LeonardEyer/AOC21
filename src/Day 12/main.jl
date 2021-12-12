module Day12

    mutable struct GraphNode
        id::Int
        name::String
    end

    mutable struct Graph
        nodes::Vector{GraphNode}
        adjacency::Matrix
    end

    function add_edge!(a::GraphNode, b::GraphNode, G::Graph)
        G.adjacency[a.id, b.id] = 1
    end

    function get_neighbours(a::GraphNode, G::Graph)
        neighbour_ids = findall(x -> x == 1, G.adjacency[a.id, :])
        return G.nodes[neighbour_ids]
    end

    function parse_input(input::String)
        egdes = map(x -> split(x, '-'), split(input, '\n'))

        nodes = unique(Iterators.flatten(egdes))
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
        display(G.adjacency)
        println(get_neighbours(G.nodes[1], G))
    end

    function part2(input::String)
        G = parse_input(input)
    end
end