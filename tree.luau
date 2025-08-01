--!strict

local Node = require("node.luau")

type Node = Node.Node

local Tree = {}
Tree.__index = Tree

type Tree = typeof(setmetatable(
	{} :: {
		root: Node?,
	},
	Tree
))

--[[
	Properties of a Red-Black Tree

    Node Color: Each node is either red or black.
    Root Property: The root of the tree is always black.
    Red Property: Red nodes cannot have red children (no two consecutive red nodes on any path).
    Black Property: Every path from a node to its descendant null nodes (leaves) has the same number of black nodes.
    Leaf Property: All leaves (NIL nodes) are black.
]]

function Tree.new()
	return {
		root = nil,
	}
end

function Tree.left_rotation(self: Tree)

end

function Tree.right_rotation(self: Tree)

end

function Tree.insert(self: Tree, data: string)
	if self.root == nil then
		self.root = Node("Black", data)
		return
	end

	-- Insert a new red node with standard BST insertion
	local current_node: Node? = self.root
	local parent_node: Node = self.root
	local new_node = Node("Red", data) -- Variables containing tables in Lua are like C pointers to a struct

	-- Traverse the tree until we find an empty child slot where the BST full order is maintained
	while current_node do
		parent_node = current_node

		if data <= current_node.data then
			current_node = current_node.left

			if current_node == nil then
				parent_node.left = new_node
			end
		else
			current_node = current_node.right

			if current_node == nil then
				parent_node.right = new_node
			end
		end
	end
	
	-- If the parent of the new node is Black, no properties are violated.
	if parent_node.color == "Black" then
		return
	end

	-- The tree violates the Red property
	-- A node has one or zero uncles, defined as the sibling of the parent.
	local uncle: Node?
	local grandparent = 
end
