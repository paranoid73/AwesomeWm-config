return setmetatable ({},{
   __index = function (table,key)
   return require("core"..'.'..key)
end
})