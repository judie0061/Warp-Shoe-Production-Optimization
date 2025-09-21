#Beichen_Du_dubeiche_1009971407
#Cindy_Zhao_zhaocin3_1010078185

#sets
set S; #set of shoes (557)
set M; #machine number (72)
set R; #raw material number (165)
set W; #set of warehouses (8)



#parameters
param price{S}; #sale price of shoes[s]
param demand{S}; #demand of shoes[s]

param oper_cost{M}; #cost of operating machine[m] in min
param duration{S,M} default 0; #duration to produce shoes[s] on mach[m] in sec

param raw_mat_cost{R};
param raw_mat_avail{R}; #raw material[r] available 
param raw_mat_use{S,R} default 0; #amount raw_mat[r] used to produce shoes[s]

param warehouse_cost{W}; #operation cost of warehouse[w]
param warehouse_cap{W}; #capacity of warehouse[w]



#decision var
var x{S} >= 0; #number of shoes[s] produced




#objective function
maximize profit: 
	sum{s in S} price[s] * x[s] #revenue
	- sum{s in S, r in R} raw_mat_use[s,r] * x[s] * raw_mat_cost[r] #raw material cost
	- sum{s in S, m in M} duration[s,m] * x[s] * (oper_cost[m]/60) #duration in sec * cost per sec
	- sum{s in S, m in M} duration[s,m] * x[s] * (25/3600) #duration in sec * paid per sec
	- sum{s in S} 10 * max(0, demand[s] - x[s]); #penalty for unmet demand (0 if produced > demand)
	


#constraints
subject to raw_mat_budget: 
	sum {s in S, r in R} raw_mat_use[s,r] * x[s] * raw_mat_cost[r] <= 10000000;
	
subject to raw_mat_availability {r in R}: 
	sum {s in S} raw_mat_use[s,r] * x[s] <= raw_mat_avail[r];

subject to machine_time_capacity {m in M}: 
	sum{s in S} duration[s,m] * x[s] <= 3600*12*28;
	
subject to total_warehouse_capacity: 
	sum{s in S} x[s] <= 140000; #sum of all warehouses' capacities

	
# 164 156 150 140 138 131 129 116 115 108 107 106 99 84 73 68 67 65 61 39 38 17 13 12 3 2
# 154 153 144 153 128 110 97 92 80 77 69 58 56 53 51 50 48 47 45 44 42 30 27 22 15 10 1
	
