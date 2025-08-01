--!strict

export type Node = {
	color: "Red" | "Black",
	data: string,
}

return function(color: "Red" | "Black", data: string): Node
	return {
		color = color,
		data = data,
	}
end
