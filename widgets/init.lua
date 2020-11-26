return setmetatable ({},{
    __index = function (table,key)
    return require("widgets"..'.'..key)
 end
 })