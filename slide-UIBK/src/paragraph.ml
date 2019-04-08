  
let paragraph s n = 
  let rec traverse  buffer n i = function
   | [] -> Picture.row (Lst.reverse buffer)
   | x::xs -> 
   if i = n then traverse (x::'\n'::buffer) n 1  xs 
   else traverse (x::buffer) n (i+1) xs in 
   traverse [] n 0 (Strng.of_string s);;
