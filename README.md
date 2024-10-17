# SIGMOD25 PIMGT
Supplementary materials for VLDB'24 submission: PimGT

## Half-Division (HDV)

### Datasets
You can download the used datasets with "get_datasets.sh"
```
~/SIGMOD25_PIMGT$ sh get_datasets.sh
```

### Compilation
The source codes of Half-Division are included in "PimGT/HDV/src" directory.
We provide an object file and some source code files written by C.

You can generate the executable files with "HDV/Makefile".
```
~/SIGMOD25_PIMGT$ cd HDV
~/SIGMOD25_PIMGT/HDV$ make	// generates all executables
~/SIGMOD25_PIMGT/HDV$ make ne	// for Edge-cut Version of Neighbor Expansion
~/SIGMOD25_PIMGT/HDV$ make divide	// for Half-Division
~/SIGMOD25_PIMGT/HDV$ make debug	// for debugging the partitioning qualities
```

### Baseline
We used METIS 5.1.0 [1], Neighbor Expansion [2], Half-Division, Half-Division with ICN refinement, and Half-Division with ICN refinement + Balancing for baselines.
Every baseline source codes are also provided.

### Usage
You can run each partitioning technique with following commands.
option_refine: 0 for no refinement(HDV), 2 for ICN refinement(HDV+R), 3 for ICN refinement + balancing(HDV+R+B).
```
~/SIGMOD25_PIMGT/HDV$ cd ..
~/SIGMOD25_PIMGT$ ./HDV/bin/ne dataset/input_graph num_subgraphs
~/SIGMOD25_PIMGT$ ./HDV/bin/divide dataset/input_graph num_subgraphs option_refine
~/SIGMOD25_PIMGT$ ./METIS/bin/gpmetis dataset/input_graph
```

Or, you can check the quality of all the partitioning with a command.
However, the METIS may need to be compiled on your local PC with reference to this address;

 http://glaros.dtc.umn.edu/gkhome/metis/metis/download
```
~/SIGMOD25_PIMGT$ sh check_ICN.sh		// Compares METIS, NE, and Half-Division(HDV)
~/SIGMOD25_PIMGT$ sh check_Refine.sh	// Compares HDV, HDV+R, HDV+R+B
```
The partitioning results will be stored in "debug.csv"

Since the quality of ICN refinement saturates quickly, the number of iterations is limited to 50.
However, you can get the exactely the same results by limiting the iterations to 500.
Changing the number 50 will effect the number of iterations.
```C
// in SIGMOD25_PIMGT/HDV/src/divide.c line 17,
if (ref > NO_REFINEMENT) prepare_Refinement(mat, target, ref, 50);
```

## PimGT Framework

### Compilation
The source codes of PimGT (Graph Traversal on Processing-in-Memory) are included in "PimGT/src" directory.
We provide the Breadth-First Search Algorithm.

You can generate the executable files with "PimGT/Makefile".
Install the UPMEM SDK (https://sdk.upmem.com/) [4] and replace the "UPMEMDIR" in Makefile with its path.
```
~/SIGMOD25_PIMGT$ cd PimGT
~/SIGMOD25_PIMGT/PimGT$ make
```

### Usage 
You can run the BFS algorithm with following commands.
```
~/SIGMOD25_PIMGT/PIMGT$ ./bin/bfs dataset/metis/mario001.mtx 64
~/SIGMOD25_PIMGT/PIMGT$ ./bin/bfs dataset/ne/mario001.mtx 64
~/SIGMOD25_PIMGT/PIMGT$ ./bin/bfs dataset/hdv/mario001.mtx 64
```
However, the PIM kernel can only be executed on real-world PIM systems; UPMEM PIM [3].
Fortunately, the UPMEM PIM SDK [4] also provides a CPU-based simulator.
Therefore we adapted our code for the simulator.
However, since the simulator can only simulate 64 PIM units, we provide "mario001", which is the smallest graph we used in our experiments that can run on 64 units.

The simulation results are shown below.
```
  -- Input File: dataset/metis/mario001.mtx	# METIS
	Number of Nodes:	38435
	Number of Edges:	206156


  -- Partitioning Result
	Total Number of Nodes: 38435
	Total Number of ICNs : 23924 
	Ratio of ICNs: 62.25 %
	Number of Nodes in SG: 583 ~ 617 (Avg: 600)
	Number of ICNs  in SG: 302 ~ 429 (Avg: 373)


  -- Execution Time Log
	Allocate 64 DPUs:	6.39 ms
	PIM transfer + Execute:	2376.86 ms
	- H-to-D Transfer:	0.51 ms
	- SG + ICE Analysis:	2375.55 ms
	- D-to-H Transfer:	0.80 ms
	Finalize Traversal:	2.34 ms
	Total Execution:	2379.19 ms
```
```
  -- Input File: dataset/ne/mario001.mtx	# Neighbor Expansion (NE)
	Number of Nodes:	38435
	Number of Edges:	206156


  -- Partitioning Result
	Total Number of Nodes: 38435
	Total Number of ICNs : 5396 
	Ratio of ICNs: 14.04 %
	Number of Nodes in SG: 600 ~ 601 (Avg: 600)
	Number of ICNs  in SG: 23 ~ 332 (Avg: 84)


  -- Execution Time Log
	Allocate 64 DPUs:	5.71 ms
	PIM transfer + Execute:	1285.41 ms
	- H-to-D Transfer:	0.47 ms
	- SG + ICE Analysis:	1283.97 ms
	- D-to-H Transfer:	0.97 ms
	Finalize Traversal:	0.86 ms
	Total Execution:	1286.27 ms
```
```
  -- Input File: dataset/hdv/mario001.mtx	# Half-Division (HDV)
	Number of Nodes:	38435
	Number of Edges:	206156


  -- Partitioning Result
	Total Number of Nodes: 38435
	Total Number of ICNs : 6060 
	Ratio of ICNs: 15.77 %
	Number of Nodes in SG: 477 ~ 626 (Avg: 600)
	Number of ICNs  in SG: 27 ~ 196 (Avg: 94)


  -- Execution Time Log
	Allocate 64 DPUs:	6.09 ms
	PIM transfer + Execute:	1273.12 ms
	- H-to-D Transfer:	0.57 ms
	- SG + ICE Analysis:	1271.90 ms
	- D-to-H Transfer:	0.65 ms
	Finalize Traversal:	0.65 ms
	Total Execution:	1273.77 ms
```
In contrast to real-world execution, NE can perform similarly or even slightly better than HDV in simulation.
This is because the simulation is performed on the CPU with dynamic scheduling, so balancing the workload across subgraphs is not critical.
Thus, METIS with the most total ICNs/ICEs is the slowest, and NE with the least ICNs/ICEs performs similar to HDV.
Additionally, the final traversal was also faster with lower total ICNs/ICEs.
However, in real-world PIM systems, HDV, which balances the workload across subgraphs, has always performed best.


### References
[1] George Karypis and Vipin Kumar. 1998. A Fast and High Quality Multi-level Scheme for Partitioning Irregular Graphs. SIAM Journal on Scientific Computing 20, 1 (1998), 359–392. https://doi.org/10.1137/S1064827595287997
[2] Chenzi Zhang, Fan Wei, Qin Liu, Zhihao Gavin Tang, and Zhenguo Li. 2017. Graph Edge Partitioning via Neighborhood Heuristic (KDD ’17). Association for Computing Machinery, New York, NY, USA, 605–614. https://doi.org/10.1145/3097983.3098033
[3] F. Devaux. 2019. The true Processing In Memory accelerator. In 2019 IEEE Hot Chips 31 Symposium (HCS). IEEE Computer Society, Los Alamitos, CA, USA, 1–24. https://doi.org/10.1109/HOTCHIPS.2019.8875680
[4] https://sdk.upmem.com/

> We will provide the full source code soon, when some confidential issues are resolved.
