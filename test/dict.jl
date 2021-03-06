module TestDicts

using Base.Test
using DataFramesMeta
using Compat

y = 3
@compat d = Dict(:s => 3, :y => 44, :d => 5, :e => :(a + b))
@test @with(d, :s + :y) == d[:s] + d[:y]
@test @with(d, :s + y)  == d[:s] + y
@test @with(d, d)  == d
@test @with(d, :s + d[^(:y)])  == d[:s] + d[:y]
@test @with(d, :e.head) == d[:e].head
@test @compat @with(Dict(:s => 3, :y => 44, :d => 5, :e => :(a + b)), :e.head) == d[:e].head

x = @with d begin
    z = y + :y - 1
    :s + z
end
@test x == y + d[:y] - 1 + d[:s]

fun = d -> @with d begin
    z = y + :y - 1
    :s + z
end
@test fun(d) == y + d[:y] - 1 + d[:s]

d2 = @transform(d, z = :y + :s)
@test d2[:z] == 47

d2 = @select(d, :y, z = :y + :s, :e)
@test d2[:z] == 47

end # module
