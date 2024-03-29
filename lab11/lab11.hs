local SumListS SumList Out1 Out2 in
   fun {SumList L}       // Declarative recursive
      case L
         of nil then 0
         [] '|'(1:H 2:T) then (H + {SumList T})
      end
   end

   fun {SumListS L}      // Stateful iterative
      case L
         where 
   end

   Out1 = {SumList [1 2 3 4]}
   Out2 = {SumListS [1 2 3 4]}
   skip Browse Out1
   skip Browse Out2
end

local FoldLS FoldL Out1 Out2 in
   fun {FoldL F Z L}            // Declarative recursive
      case L
         of nil then Z
         [] '|'(1:H 2:T) then {FoldL F {F Z H} T}
      end
   end

   fun {FoldLS F Z L}           // Stateful iterative
      ...
   end 

   Out1 = {FoldL fun {$ X Y} (X+Y) end 3 [1 2 3 4]}
   Out2 = {FoldLS fun {$ X Y} (X+Y) end 3 [1 2 3 4]}
   skip Browse Out1
   skip Browse Out2
end