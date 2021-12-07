module Day5
    using LinearAlgebra
    using PyPlot

    struct Line
        from :: Vector
        to :: Vector
    end

    function horizontal(line::Line)::Bool
        return line.from[1] == line.to[1]
    end

    function vertical(line::Line)::Bool
        return line.from[2] == line.to[2]
    end

    function max_coord(line::Line)
        return Base.maximum(hcat(line.from, line.to))
    end

    function point_on(line::Line, x::Vector)
        a = x - line.from
        b = line.to - x
        c = line.to - line.from

        return (norm(a) + norm(b)) == norm(c)
    end

    function parse_input(input)
        function parse_line(linestring)
            function parse_points(pointstring)
                return collect(map(x -> parse(Int, x), split(pointstring, ",")))
            end
            from, to = sort(map(parse_points, split(linestring, " -> ")))
            return Line(from, to)
            
        end
        input_cleaned = map(strip, split(input, "\n"))
        return map(parse_line, input_cleaned)
    end

    function plotline_bresenham(l::Line, grid)
        x0 = l.from[1]
        x1 = l.to[1]
        y0 = l.from[2]
        y1 = l.to[2]

        # Bresenham
        dx =  abs(x1-x0)
        sx = x0<x1 ? 1 : -1
        dy = -abs(y1-y0)
        sy = y0<y1 ? 1 : -1
        err = dx+dy
        while true
            grid[x0+1, y0+1] += 1
            if (x0 == x1 && y0 == y1) 
                break
            end
            e2 = 2*err
            if (e2 >= dy)
                err += dy
                x0 += sx
            elseif (e2 <= dx)
                err += dx
                y0 += sy
            end
        end
    end

    function plotline(line::Line, grid::Matrix)
        x0 = line.from[1]
        x1 = line.to[1]
        y0 = line.from[2]
        y1 = line.to[2]


        m = line.to - line.from
        m /= maximum(m)
        
        x = x0
        y = y0
        while true
            grid[round(Int, x) + 1, round(Int, y) + 1] += 1
            if(round(Int, x) == x1 && round(Int, y) == y1)
                break
            end
            x += m[1]
            y += m[2] 
        end
    end

    function part1(input)

        # Only use horizontal and vertical lines
        lines = filter(x -> horizontal(x) || vertical(x), parse_input(input))

        # Initialize the grid datastructure 
        max_val = Base.maximum(map(max_coord, lines))
        grid = zeros(Int, (max_val + 1, max_val + 1))

        # Plot all lines on the grid
        for l in lines
            plotline(l, grid)
        end        

        imshow(transpose(grid))
        colorbar()

        # Return the sum of grid points with intersection records >= 2
        return sum(grid .>= 2)
    end
    function part2(input)

        # Use all the lines
        lines = parse_input(input)

        # Initialize the grid datastructure 
        max_val = Base.maximum(map(max_coord, lines))
        grid = zeros(Int, (max_val + 1, max_val + 1))

        # Plot all lines on the grid
        for l in lines
            plotline(l, grid)
        end        

        imshow(transpose(grid))
        colorbar()
        # Return the sum of grid points with intersection records >= 2
        return sum(grid .>= 2)

    end
end