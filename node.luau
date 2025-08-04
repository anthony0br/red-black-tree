--!strict

export type Node = {
	color: "Red" | "Black",
	data: string | nil,
	left: Node?,
	right: Node?,
	parent: Node?,
}

return function(color: "Red" | "Black", data: string): Node
	return {
		color = color,
		data = data,
	}
end
