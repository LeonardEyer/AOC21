module Day15

    using DataStructures

    struct InfinityInteger <: Integer end
    Base.isinf(::InfinityInteger) = true

    mutable struct GraphNode
        index::CartesianIndex
        distance::Float16
        prev::Union{Nothing, GraphNode}
    end

    mutable struct Graph
        nodes::Matrix{GraphNode}
        distances::Matrix{Int}
    end

    function GraphNode(index::CartesianIndex)
        return GraphNode(index, Inf, nothing)
    end

    function get_neighbours(a::GraphNode, G::Graph)
        window = make_cross_window(a.index, G)
        return G.nodes[window]
    end

    # Assumes distance to neighbours
    function distance(b::GraphNode, G::Graph)
        return G.distances[b.index]
    end

    function isless(a::GraphNode, b::GraphNode)
        return a.distance < b.distance
    end

    function make_cross_window(index, G)
        cross =  [CartesianIndex(1, 0) CartesianIndex(0, 1) CartesianIndex(-1, 0) CartesianIndex(0 , -1)]
        pos = [index + x for x in cross]
        return filter(x -> all((1, 1) .<= Tuple(x) .<= Tuple(size(G.nodes))), pos)
    end

    function parse_input(input::String)
        distances = hcat(map(x -> parse.(Int, x), map(collect, split(input, "\n")))...)

        # Construct graph of nodes
        nodes = Matrix{GraphNode}(undef, size(distances))
        for idx in CartesianIndices(distances)
            nodes[idx] = GraphNode(idx)
        end

        # Make graph
        G = Graph(nodes, distances)
        return G
    end

    function djikstra(G::Graph, start::GraphNode, target::GraphNode)
        start.distance = 0

        Q = PriorityQueue{GraphNode, Float16}()

        for idx in CartesianIndices(G.nodes)
            n = G.nodes[idx]
            enqueue!(Q, n, n.distance)
        end

        while !isempty(Q)
            u = dequeue!(Q)
            if u == target
                return u
            end

            for v in get_neighbours(u, G)
                alt = u.distance + distance(v, G)
                if alt < v.distance
                    v.distance = alt
                    v.prev = u
                    Q[v] = alt
                end
            end
        end

    end

    function part1(input::String)
        G = parse_input(input)
        result = djikstra(G, G.nodes[1, 1], G.nodes[end, end])

        return result.distance
    end

    function part2(input::String)
        G = parse_input(input)
    end
end