-- Utilities
local util = {}
local class = require 'class'

function util.isNode(n)
   return class.type(n) == 'Node'
end

function util.getValue(v)
   if util.isNode(v) then
      return v.value
   else
      return v
   end
end

function util.map(tbl, func)
   local newtbl = {}
   for i,v in pairs(tbl) do
      newtbl[i] = func(v)
   end
   return newtbl
end

function util.filter(tbl, func)
   local newtbl= {}
   for i,v in pairs(tbl) do
      if func(v) then
         newtbl[#newtbl+1]=v
      end
   end
   return newtbl
end

function util.oneHot(labels, n)
   --[[
   Assume labels is a 1D tensor of contiguous class IDs, starting at 1.
   Turn it into a 2D tensor of size labels:size(1) x nUniqueLabels

   This is a pretty dumb function, assumes your labels are nice.
   ]]
   local n = n or labels:max()
   local nLabels = labels:size(1)
   local out = torch.FloatTensor(nLabels, n):fill(0)
   for i=1,nLabels do
      out[i][labels[i]] = 1.0
   end
   return out
end

return util
