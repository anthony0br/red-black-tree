--!strict

local node = require("./node")
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

	(geeksforgeeks)
]]

function Tree.new()
	return {
		root = nil,
	}
end

--[[
Let y be the right child of x
1. Set the right child of x to the left child of y + update parent pointers
2. Set left child of y + update parent pointers

We are essentially moving the right child up and then redrawing the tree to
satisfy the BST property.

x
 \
  y
 / \
a   b
]]
function Tree.left_rotation(self: Tree, x: Node)
	local final_parent = x.parent
	local y = x.right
	assert(y)
	local a = y.left
	assert(a)

	-- Step 1
	x.right = a
	a.parent = x

	-- Step 2
	y.left = x
	x.parent = y

	y.parent = final_parent
end

--[[
    x
   /
  y
 / \
a   b
]]
function Tree.right_rotation(self: Tree, x: Node)
	local final_parent = x.parent
	local y = x.left
	assert(y)
	local b = y.right
	assert(b)

	-- Step 1
	x.left = b
	b.parent = x

	-- Step 2
	y.right = x
	x.parent = y

	y.parent = final_parent
end

local function fix_red_violation(tree: Tree, problem_node: Node)
	-- The tree violates the Red property
	-- A node has one or zero uncles, defined as the sibling of the parent.
	local uncle: Node?
	-- Grandparent is garuanteed to exist if rules are implemented correctly
	local parent_node = problem_node.parent

	if not parent_node then
		print("no parent")
		return
	end

	local grandparent = parent_node.parent

	if not grandparent then
		print("no grandparent")
		return
	end

	if grandparent.left == parent_node then
		uncle = grandparent.right
	else
		uncle = grandparent.left
	end

	-- If the uncle is a nil node, then we count it as black.
	if uncle ~= nil and uncle.color == "Red" then -- Is the above layer consistently red?
		parent_node.color = "Black" -- Swap it to consistently black
		uncle.color = "Black"

		if grandparent ~= tree.root then
			grandparent.color = "Red"
		end

		fix_red_violation(tree, grandparent)
	elseif parent_node.left == problem_node then
		tree:left_rotation(parent_node)
	elseif parent_node.right == problem_node then
		tree:right_rotation(grandparent)
		-- TODO: "recolor appropriately"
	end
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
	while current_node and current_node.data do
		parent_node = current_node
		if data <= current_node.data then
			current_node = current_node.left

			-- Note: we count "nil" pointers as 'empty black nodes'
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

	-- We now have a red property violation
	fix_red_violation(self, new_node)
end

function Tree.search(self: Tree, needle: string) end

function Tree.delete(self: Tree, data: string) end

-- The number of black nodes on any path from, but not including, a node x down to a leaf is
-- the black-height of the node, denoted by bh(x). (Algorithms II notes)
-- Includes the leaf (nil node) as black!
-- TODO: Lemma 22
function Tree.black_height() end

function Tree.check_rules(self: Tree)
	-- Check BST order rule

	-- Check Red rule

	-- Check Black Height

	-- other rules are kinda irrelevant lol
end
