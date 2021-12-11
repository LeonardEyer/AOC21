module Day10
    using Statistics

    char_pairs = [
        ('(', ')')
        ('[', ']')
        ('{', '}')
        ('<', '>')
    ]

    corruption_cost = Dict(
        ')' => 3,
        ']' => 57,
        '}' => 1197,
        '>' => 25137,
    )

    completion_cost = Dict(
        ')' => 1,
        ']' => 2,
        '}' => 3,
        '>' => 4,
    )

    closing_pairs = [cp[2] for cp in char_pairs]
    opening_pairs = [cp[1] for cp in char_pairs]

    function get_closing_pair(opening_pair::Char)
        opening_index = findfirst(x -> x == opening_pair, opening_pairs)
        return closing_pairs[opening_index]
    end

    mutable struct TreeNode
        id::Int
        char::Char
        parent::Union{TreeNode, Nothing}

        opening::Union{Char, Nothing}
        body::Vector{TreeNode}
        closing::Union{Char, Nothing}
    end

    mutable struct Tree
        root::Union{TreeNode, Nothing}
        node_count::Int
    end

    function makeTree()
        t = Tree(nothing, 0)
        root = makeNode(t, '.')
        t.root = root
        return t
    end

    function makeNode(tree::Tree, char::Char)
        n = TreeNode(tree.node_count, char, nothing, nothing, [], nothing)
        tree.node_count += 1
        return n
    end

    function addNode(tree::Tree, t::TreeNode, char::Char)
        
        if char in opening_pairs

            # Create a new body to keep track of pairing
            body = makeNode(tree, '.')

            # Log the opening char
            body.opening = char

            # Link from to parent
            body.parent = t
            push!(t.body, body)

            return body

        elseif char in closing_pairs

            # Find the corresponding opening char
            opening_char = opening_pairs[findfirst(x -> x == char, closing_pairs)]

            # If the current node opens with this
            if t.opening !== nothing && t.closing === nothing
                if t.opening === opening_char
                    # We can fulfill closing condition
                    t.closing = char
                    return t
                # Corruption
                else
                    t.closing = char
                    return nothing
                end
            
            # We need to find the possibly missing opening node
            else
                # Can we find the opening in outer brackets?
                if t.parent !== nothing
                    return addNode(tree, t.parent, char)
                else
                    throw(ErrorException("Unknown path"))
                end
            end
        else
            throw(ErrorException("Invalid character"))
        end

    end

    function complete_node(tree::Tree, treeNode::TreeNode, added_chars)

        # Missing closing bracked
        if treeNode.closing === nothing
            opener = treeNode.opening
            closing_char = get_closing_pair(opener)
            push!(added_chars, closing_char)
            
            treeNode.closing = closing_char
        end

        for x in treeNode.body 
            complete_node(tree, x, added_chars)
        end

        return added_chars
    end

    function compute_completion_cost(added_chars::Vector{Char})
        total_cost = 0
        for c in added_chars
            total_cost *= 5
            total_cost += completion_cost[c]
        end

        return total_cost
    end

    function parse_input(input)
        return map(collect, split(input, "\n"))
    end

    function part1(input)

        input = parse_input(input)
        total_cost = 0 
        for (i, l) in enumerate(input)
            t = makeTree()
            curr = t.root
            for (j, x) in enumerate(l)
                new = addNode(t, curr, x)
                if new !== nothing
                    curr = new
                else
                    #println("In line ", i, " at pos ", j, " with content ", String(l))
                    #println("Updating error with ", error_cost[x])
                    total_cost += corruption_cost[x]
                end
            end
        end
        return total_cost
    end

    function part2(input)
        input = parse_input(input)

        trees = Tree[]

        # Filter all corrupt and build trees
        for l in input
            t = makeTree()
            curr = t.root
            for x in l
                curr = addNode(t, curr, x)
                if curr === nothing
                    break
                end
            end
            if curr === nothing
                continue
            end
            push!(trees, t)
        end

        added_chars::Vector{Vector{Char}} = map(x -> complete_node(x, x.root.body[1], []), trees)
        computed_costs::Vector{Int} = map(compute_completion_cost, map(reverse, added_chars))
        return Int(median(computed_costs))
    end
end