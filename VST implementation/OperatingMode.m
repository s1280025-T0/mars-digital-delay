classdef OperatingMode < int8
    enumeration
        linear (0)
        logarithmic (1)
        sigmoid (2)
        stepwise (3)
        none (4)
    end
end