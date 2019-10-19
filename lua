--[[
	练习  排序算法  升序
--]]

--[[
	①冒泡排序   bubbleSort
	从第一个数开始，相邻元素两两对比，小的数放前面。
	（每循环一次，最后一个数都会被确定下来，为每轮的最大数）
--]]
function bubbleSort(arr)
	local length = #arr
	
	for i = 1, length do
		for j = 1, length-1 do
			if arr[j] > arr[j+1] then
				arr[j], arr[j+1] = arr[j+1], arr[j]
			end
		end
	end

	return arr
end

local arr = {3, 7, 16, 5, 66, 2, 133, 26, 90, 8, 233, 10, 6}
print("--------冒泡排序后--------")
bubbleSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)

--[[
	②选择排序   choiceSort
	从第一个数开始，循环一圈找最小的数交换位置。
	（每循环一圈，第一个数都会被确定下来，为每轮最小的值）
--]]
function choiceSort(arr)
	local length = #arr
	
	for i = 1, length do
		local minIndex = i
		for j = i+1, length do
			if arr[j] < arr[minIndex] then
				minIndex = j
			end
		end
		arr[i], arr[minIndex] = arr[minIndex], arr[i]
	end
	
	return arr
end

local arr = {3, 7, 16, 5, 66, 2, 133, 26, 90, 8, 233, 10, 6}
print("--------选择排序后--------")
choiceSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)

--[[
	③插入排序   insertSort
	从第二个数开始，跟前一个数比较，若比前一个数小，则交换位置，
	接着跟前一个数比较，直到比前一个数大为止。
	（从第一张开始整理扑克牌，小的往前插)
	(可能会出现一个数从最后比较到最前面，比较费时)
--]]
function insertSort(arr)
	local length = #arr
	
	for i = 2, length do
		for j = i, 2, -1 do
			if arr[j] < arr[j-1] then
				arr[j], arr[j-1] = arr[j-1], arr[j]
			end
		end
	end
	
	return arr
end

local arr = {3, 7, 16, 5, 66, 2, 133, 26, 90, 8, 233, 10, 6}
print("--------插入排序后--------")
choiceSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)

--[[
	④希尔排序   shellSort
	属于插入类排序，是将整个有序序列分割成若干个小的子序列分别进行插入排序。
	排序过程:先取一个正整数d1<n,把所有序号相隔d1的数组元素放一组，组内进行直接
	插入排序，然后取d2<d1，重复上续分组和排序操作，直至d1=1，即所有记录放进一个
	组中排序为止。
	(将每间隔一定步距的数取出来进行比较，比如gap=5，就是把第1个、第6个、第11个
	..数取出来进来插入排序)
--]]
function shellSort(arr)
	local length = #arr
	local gap = length
	
	while (true) do
		gap = math.floor(gap/2)
		
		for i = gap, length do
			for j = i-gap, 1, -gap do
				if arr[j] > arr[j + gap] then
					arr[j], arr[j + gap] = arr[j + gap], arr[j]
				end
			end
		end
		
		if gap == 1 then
			break
		end
	end
	
	return arr
end

local arr = {3, 7, 16, 5, 66, 2, 133, 26, 90, 8, 233, 10, 6}
print("--------希尔排序后--------")
shellSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)

--[[
	⑤归并排序   mergeSort
	归并排序有两种实现方法：自上而下的递归；自下而上的迭代。下面讲递归法：
    将原数组用二分法一直分到两个数为一组，然后通过比较将较小的数放到前面（通过一个中间数组排序）；然后一层层向上排序。
    （就是两个数比较进行排序，然后两组（四个数）进行比较排序，然后两组（八个数）进行比较排序…）
--]]

--把数组的第一个元素从其中删除，并返回第一个元素的值。
function shift(arr)
	local result = arr[1]
	table.remove(arr,1)
	return result
end

--返回一个新的数组，
--包含从start到end(不包括该元素)的arrayObject中的元素。
function slice(arr, startPos, endPos)
	local result = {}
	endPos = endPos or (#arr+1)
	
	for k,v in pairs(arr) do
		if k >= startPos and k < endPos then
			table.insert(result,v)
		end
	end
	
	return result
end

function merge(left, right)
	local result = {}
	
	while #left > 0 and #right > 0 do
		if left[1] <= right[1] then
			table.insert(result,shift(left))
		else
			table.insert(result,shift(right))
		end
	end 
	
	while #left > 0 do
		table.insert(result, shift(left))
	end
	
	while #right > 0 do
		table.insert(result, shift(right))
	end
	
	return result
end

function mergeSort(arr)
	local length = #arr
	local left = {}
	local right = {}
	if length < 2 then
		return arr
	end
	
	local middle = math.floor(length/2) + 1
	left = slice(arr, 1, middle)
	right = slice(arr, middle)
	
	return merge(mergeSort(left), mergeSort(right))
end

local arr = {3, 7, 16, 5, 66, 2, 133, 26, 90, 8, 233, 10, 6}
print("--------归并排序后--------")
arr = mergeSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)

--[[
	⑥快速排序   quickSort
	先找到一个基准点（一般指数组的中部），然后数组被该基准点分为两部分，依次与该基准点数据比较，
	如果比它小，放左边；反之，放右边。 左右分别用一个空数组去存储比较后的数据。最后递归执行上述操作，直到数组长度<=1。
    特点：快速，常用。缺点是需要另外声明两个数组，浪费了内存空间资源。
--]]

--分区操作
function partition(arr, left, right)
	local pivot = left    --设置基准值
	local index = pivot + 1
	
	for i = index, right do
		if arr[i] < arr[pivot] then
			arr[i], arr[index] = arr[index], arr[i]
			index = index + 1
		end
	end
	
	arr[pivot], arr[index-1] = arr[index-1], arr[pivot]
	return index-1
	
end

function quickSort(arr, left, right)
	local length = #arr
	local partitionIndex
	left = left or 1
	right = right or length
	
	if left < right then
		partitionIndex = partition(arr, left, right)
		quickSort(arr, left, partitionIndex-1)
		quickSort(arr, partitionIndex+1, right)
	end
	
	return arr
end

local arr = {8, 7, 16, 5, 66, 2, 133, 26, 90, 3, 233, 10, 6}
print("--------快速排序后--------")
quickSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)


--[[
	⑦堆排序   heapSort
	是一种利用堆的概念来排序的选择排序。有两种方法：
	
	1.大顶堆：每个节点的值都大于或等于其子节点的值，在堆排序算法中用于升序排列
	2.小顶堆：每个节点的值都小于或等于其子节点的值，在堆排序算法中用于降序排列
--]]
local arrLen

--堆调整
function heapify(arr, i)
	local left = 2 * i
	local right = 2 * i + 1
	local largest  = i 
	
	if left < arrLen and arr[left] > arr[largest] then
		largest = left
	end
	
	if right < arrLen and arr[right] > arr[largest] then
		largest = right
	end
	
	if largest ~= i then
		arr[i], arr[largest] = arr[largest], arr[i]
		heapify(arr, largest)
	end
	
end

--建立大顶堆
function buildMaxHeap(arr)
	arrLen = #arr
	for i = math.floor(arrLen/2), 1, -1 do
		heapify(arr,i)
	end
end

function heapSort(arr)
	buildMaxHeap(arr)
	
	for i = #arr, 1, -1 do
		arr[1], arr[i] = arr[i], arr[1]
		arrLen = arrLen - 1
		heapify(arr, 1)
	end
	
	return arr
end

local arr = {8, 7, 16, 5, 66, 2, 133, 26, 90, 3, 233, 10, 6}
print("--------堆排序后--------")
heapSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)

--[[
	⑧计数排序   countSort
	其核心在于将输入的数据值转化为键存储在额外开辟的数组空间中。作为一种线性
	时间复杂度的排序，计数排序要求输入的数据必须是有确定范围的整数。
--]]
function findMax(arr)
	local max = arr[1]
	
	for k,v in pairs(arr) do
		if v > max then
			max = v
		end
	end
	
	return max
end

function countSort(arr, maxValue)
	maxValue = maxValue or findMax(arr)
	maxValue = maxValue + 1
	local length = #arr
	local bucket = {}
	local sortedIndex = 0
	local bucketLen = maxValue + 1
	
	for i = 1, length do
		if "number" ~= type(bucket[arr[i]]) then
			bucket[arr[i]] = 0
		end
		bucket[arr[i]] = bucket[arr[i]] + 1
	end
	
	for j = 1, bucketLen do
		while type(bucket[j]) == "number" and bucket[j] > 0 do
			sortedIndex = sortedIndex + 1
			arr[sortedIndex] = j
			bucket[j] = bucket[j] - 1
		end
	end
	
	return arr
end

local arr = {8, 7, 16, 5, 66, 2, 133, 26, 90, 3, 233, 10, 6}
print("--------计数排序后--------")
countSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)


--[[
	⑨桶排序   bucketSort
	是计数排序的升级版。它利用了函数的映射关系，高效与否的关键就在于这个映射函数
	的确定。
	为了使桶排序更加高效，我们需要做到这两点：
		1.在额外空间充足的情况下，尽量增大桶的数量
		2.使用的映射函数能够将输入的N个数据均匀的分配到K个桶中
	对于桶中元素的排序，选择何种比较排序算法对于性能的影响至关重要。
	**什么时候最快**
	当输入的数据可以均匀的分配到每一个桶中
	**什么时候最慢**
	当输入的数据被分配到同一个桶中
--]]
function bucketSort(arr, bucketSize)
	local length = #arr
	local minValue = arr[1]
	local maxValue = arr[1]
	
	for i = 1, length do
		if arr[i] < minValue then
			minValue = arr[i]
		elseif arr[i] > maxValue then
			maxValue = arr[i]
		end
	end
	
	--桶的初始化
	local DEFAULT_BUCKET_SIZE = 5   --设置桶的默认数量为5
	bucketSize = bucketSize or DEFAULT_BUCKET_SIZE
	local bucketCount = math.floor((maxValue - minValue)/bucketSize) + 1
	local buckets = {}
	for i = 1, bucketCount do
		buckets[i] = {}
	end
	
	for i = 1, length do
		local pos = math.floor((arr[i] - minValue)/bucketSize) + 1
		table.insert(buckets[pos], arr[i])
	end
	
	arr = {}
	for i = 1, #buckets do
		insertSort(buckets[i])
		for j = 1, #buckets[i] do
			table.insert(arr, buckets[i][j])
		end
	end
	
	
	return arr
end

local arr = {8, 7, 16, 5, 66, 2, 133, 26, 90, 3, 233, 10, 6}
print("--------桶排序后--------")
arr = bucketSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)

--[[
	⑩基数排序   radixSort
	基数排序有两种方法
	1.MSD从高位开始进行排序
	2.LSD从低位开始进行排序
	
	基数排序 VS 计数排序 VS 桶排序
	
	这三种排序算法都利用了桶的概念，但对桶的使用方法上有明显的差异:
	○基数排序:根据键值的每位数字来分配桶
	○计数排序:每个桶只存储单一键值
	○ 桶排序: 每个桶存储一定范围的数值
	
--]]

--radixSort 不完善 数组内不能含有 0 
local counter = {}

function radixSort(arr, maxDigit)
	local length = #arr 
	local mod = 10
	local dev = 1
	maxDigit = maxDigit or findMax(arr)
	
	for i = 1, 63 do
		for j = 1, length do
			local bucket = math.ceil((arr[j] % mod) / dev)
			if bucket == 0 then
				bucket = 10
			end
			if type(counter[bucket]) == "nil" then
				counter[bucket] = {}
			end
			table.insert(counter[bucket], arr[j])
		end
		
		local pos = 0
		for j = 1, #counter do
			local value = nil
			if type(counter[j]) ~= "nil" then
				value = shift(counter[j])
				while type(value) ~= "nil" do
					pos = pos + 1
					arr[pos] = value
					value = shift(counter[j])
				end
			end
		end
		
		dev = dev * 10
		mod = mod * 10
	end
	
	return arr
end

local arr = {8, 7, 16, 5, 66, 2, 133, 26, 90, 3, 233, 10, 6}
print("--------基数排序后--------")
radixSort(arr)
local printArr = ""
for k,v in ipairs(arr) do
	printArr = printArr .. " " .. v
end
print(printArr)
