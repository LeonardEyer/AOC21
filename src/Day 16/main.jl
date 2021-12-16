module Day16
    using Bits

    mutable struct LiteralPacket
        version::UInt8           # 3 Bits
        typeID::UInt8            # 3 Bits
        value::UInt64
    end
    mutable struct OperatorPacket
        version::UInt8           # 3 Bits
        typeID::UInt8            # 3 Bits

        lengthTypeID::Bool      # 1 Bit
        length::UInt16           # 15 or 11 Bits
        subPackets::Vector{Union{OperatorPacket, LiteralPacket}}
    end

    function display(x::LiteralPacket)
        println("version: $(Int(x.version))")
        println("type: $(Int(x.typeID))")
        println("value: $(Int(x.value))")
    end

    function display(x::OperatorPacket)
        println("version: $(Int(x.version))")
        println("type: $(Int(x.typeID))")
        println("lengthTypeID: $(x.lengthTypeID)")
        println("type: $(Int(x.length))")
        println("subpackets: [")
        for (i, p) in enumerate(x.subPackets)
            println("[")
            display(p)
            println("]")
        end
        println("]")
    end

    function bittest2(arr)
        arr = reverse(arr)
        sum(((i, x),) -> Int(x) << ((i-1) * sizeof(x)), enumerate(arr.chunks))
    end

    function hex2binary(input::String)::BitVector
        bytes = bits.(hex2bytes(input))
        vec = []
        for b in bytes
            append!(vec, reverse(b))
        end
        return BitArray(vec)
    end

    function next_multiple(n, k)
        return n + (k - n % k)
    end

    function parse_literal(binary)
        # Extract version
        version = bittest2(binary[1:3])
        # Extract the 5 bit groups
        binary_value_packets = collect(Iterators.partition(binary[7:end], 5))
        # Find id of the first group that has its first bit set to 1
        last_group = findfirst(x -> x[1] == 0, binary_value_packets)
        # Discard the first bit and combine the parts to form a number
        values = map(x -> x[2:end], binary_value_packets[1:last_group])
        value = bittest2(vcat(values...))
        # Compute the end of this packet (where possible new packets start)
        packet_end = 6 + last_group * 5

        return LiteralPacket(version, 4, value), packet_end
    end

    function parse_operator(binary)
        typeID = bittest2(binary[4:6])
        version = bittest2(binary[1:3])

        lengthTypeID = binary[7]
        # length is a 11-bit number representing the number of sub-packets.
        if lengthTypeID
            sub_packets_count = bittest2(binary[8:18])
            sub_packets = binary[19:end]
            
            total_parsed_bits = 0
            sub_packets_parsed = []
            # Parse subpackets until all to be read bits are exhausted
            while length(sub_packets_parsed) < sub_packets_count
                packet, parsed_bits = parse_packet(sub_packets[1+total_parsed_bits:end])
                total_parsed_bits += parsed_bits
                push!(sub_packets_parsed, packet)
            end
            total_parsed_bits += 18
            return OperatorPacket(version, typeID, lengthTypeID, sub_packets_count, sub_packets_parsed), total_parsed_bits
        # length is a 15-bit number representing the number of bits in the sub-packets.
        else
            sub_packets_length = bittest2(binary[8:22])
            sub_packets = binary[23:23+sub_packets_length-1]
            
            total_parsed_bits = 0
            sub_packets_parsed = []
            # Parse subpackets until all to be read bits are exhausted
            while total_parsed_bits < sub_packets_length
                packet, parsed_bits = parse_packet(sub_packets[1+total_parsed_bits:end])
                total_parsed_bits += parsed_bits
                push!(sub_packets_parsed, packet)
            end
            total_parsed_bits += 22
            return OperatorPacket(version, typeID, lengthTypeID, sub_packets_length, sub_packets_parsed), total_parsed_bits
        end
    end

    function version_sum(packet)
        total_sum = 0
        total_sum += packet.version
        if hasproperty(packet, :subPackets)
            for x in packet.subPackets
                total_sum += version_sum(x)
            end
        end
        return total_sum
    end

    function parse_packet(binary)
        version = bittest2(binary[1:3])
        typeID = bittest2(binary[4:6])
        #println("Parsing packet with version $version and typeID $typeID")
        # Literal
        if typeID == 4
            return parse_literal(binary)
        # Operator
        else
            return parse_operator(binary)
        end
    end

    function parse_input(input::String)
        binary = hex2binary(input)
        return parse_packet(binary)[1]
    end

    function part1(input::String)
        packets = parse_input(input)
        return Int(version_sum(packets))
    end

    function part2(input::String)
        input = parse_input(input)
    end
end