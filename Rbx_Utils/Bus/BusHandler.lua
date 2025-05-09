
local BusConfig = require(script.Parent.Config)

local BusHandler = {}
BusHandler.__index = BusHandler

math.randomseed(os.time())

type Bus = {
	ID: number,
	Name: string,
	MaxPassengers: number,
	Route: string,
	RouteID: number,
}

function BusHandler.new(busName: string, maxPassengers: number): Bus
	local self = setmetatable({}, BusHandler)
	
	self.Name = busName
	self.MaxPassengers = maxPassengers
	self.Route = ""
	self.RouteID = 0
	self.ID = self:GenerateUniqueID(20)
	
	return self
end

function BusHandler:GenerateUniqueID(length: number): string
	local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	local id

	repeat
		id = ""
		for _ = 1, length do
			local randomIndex = math.random(1, #characters)
			id = id .. string.sub(characters, randomIndex, randomIndex)
		end
	until not BusConfig.Busses[id] --// Ensures uniqueness

	return id
end

function BusHandler:CreateNewBus(Bus): Bus
	if not BusConfig.Busses[Bus.ID] then
		BusConfig.Busses[Bus.ID] = Bus 
		return BusConfig.Busses[Bus.ID]
	end
	return false, "A Bus With The Given Name or ID, Already Exists!"
end

function BusHandler:ChangeRoute(Bus, newRoute: string)
	
end

function BusHandler:GetCurrentRoute(Bus): (number, string)
	if BusConfig.Busses[Bus.ID] then
		return BusConfig.Busses[Bus.ID].RouteID, BusConfig.Busses[Bus.ID].Route
	end
end

return BusHandler
