return setmetatable ({},{
    __index = function (table,key)
    return require("utilities.shape"..'.'..key)
 end
 })