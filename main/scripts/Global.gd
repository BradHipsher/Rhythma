extends Node

## I/O
func add_scn_pth(scn):
	return "res://main/screens/"+scn+".tscn"

func save_cali(linest : Vector2):
	var file = File.new()
	file.open("res://main/Music/9mm/9mm.dat", File.WRITE)
	file.store_string(str(linest))
	file.close()

func load_cali():
	var file = File.new()
	file.open("res://main/Music/9mm/9mm.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return content

## MATHS
func range0(s : int):
	return range(s).pop_back()

func sum(arr : Array):
	var sum : float = 0.0
	for e in arr:
		sum += e
	return sum

func avg(arr : Array):
	return sum(arr) / arr.size()
	
func sumprod(arr0 : Array, arr1 : Array):
	var arr : Array = []
	var sumprod : float = 0.0
	if arr0.size() == arr1.size():
		for i in range(arr0.size()):
			arr.append(arr0[i]*arr1[i])
		sumprod = sum(arr)
	return sumprod 

func addscalar(arr0 : Array, scalar : float):
	var arr : Array = []
	for e in arr0:
		arr.append(e+scalar)
	return arr

func linest(ys : Array):
	var xs : Array = range(ys.size())
	
	var xbar : float = avg(xs)
	var ybar : float = avg(ys)
	
	var xdif : Array = addscalar(xs, -xbar)
	var ydif : Array = addscalar(ys, -ybar)
	
	var numer : float = sumprod(xdif, ydif) 
	var denom : float = sumprod(xdif, xdif)
	
	var m : float = numer / denom
	var b : float = ybar - (m * xbar)
	
	var b0 : float = b
	while (abs(b0) > abs(b0-m)):
		b0 -= m
	print("b0: " + str(b0))
	
	return Vector2(m, b0)
