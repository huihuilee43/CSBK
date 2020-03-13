import numpy as np
import random
import math
import csv



def rbf_kernel(u,v,sigma):
	k = np.exp(-np.dot((u-v),(u-v).T) / (2*sigma**2))
	return k


def MVSVM(xa,xb,y,a,c,r):		#xa,xb,
	l = y.shape[0]
	itn = 1000
	t = 1
	rbf_sig = 2

	A = np.zeros((l,1),dtype=float)						#矩阵a[j]初始化
	B = np.zeros((l,1),dtype=float)

	while (t <= itn) :
		i = random.randint(1,l-1)
		#随机抽取一个数据
		xa_i = xa[i,:]
		xb_i = xb[i,:]
		yi = y[i]
		sigma_a = 0
		sigma_b = 0

		"""
		由于 j != i 时，a_t+1[j] = a_t[j],所以用一维（l*1）只更新 j = i
		"""
		xb_i = xb[i,:]

		for j in range(1,l):        #计算cesi_a,cesi_b中的sigma求和
				sigma_a =  sigma_a +yi * A[j] * rbf_kernel(xa_i,xa[j,:],rbf_sig)
				sigma_b =  sigma_b +yi * B[j] * rbf_kernel(xb_i,xb[j,:],rbf_sig)

		cesi_a = 1 - yi * c * a /t * sigma_a
		cesi_b = 1 - yi * c * a /(t*r) * sigma_b

		if cesi_a > 0 :
			A[j] = A[j] + yi*np.exp(a*(cesi_a+cesi_b)-1)
		else:
			A[j] = A[j]

		if cesi_b > 0 :
			B[j] = B[j] + yi*np.exp(a*(cesi_a+cesi_b)-1)
		else:
			B[j] = B[j]

		t = t+1

	A = A/t				#为了少传一个参数t，先除t
	B = B/(t*r)
	return A,B


def predict(A,B,xa,xb,xi_a,xi_b,a,c,r):	#xa,xb要和MVSVM(xa,xb,y,a,c,r)中xa，xb相同，xi_a,xi_b是待预测数据
	l,dim = xa.shape
	rbf_sig = 2
	sigma_a = 0
	sigma_b = 0

	for j in range(1,l):
		sigma_a = sigma_a +  A[j] * rbf_kernel(xi_a, xa[j, :], rbf_sig)
		sigma_b = sigma_b +  B[j] * rbf_kernel(xi_b, xb[j, :], rbf_sig)

	#label = np.sign(c*a*(sigma_a+sigma_b)/2)
	#label = np.sign(c*a*(sigma_a))
	label = np.sign(c*a*(sigma_b))

	return label


def accuracy(xa,xb,testdata_a,testdata_b,label,A,B,a,c,r):
	test_m = testdata_a.shape[0]
	predictlabel = np.zeros((test_m,1))
	P,N,TP,TN,FP,FN = 0,0,0,0,0,0

	for i in range(test_m):
		predictlabel[i] = predict(A,B,xa,xb,testdata_a[i,:],testdata_b[i,:],a,c,r)	#两视角预测函数
		#predictlabel[i] = np.sign(np.dot(testdata_a[i,:] ,Wa) + b_a)													#a视角预测函数
		#predictlabel[i] = np.sign(np.dot(testdata_b[i,:] ,Wb) + b_b)
		if label[i]==1:
			P  = P+1
			if predictlabel[i] ==1:
				TP +=1
			else:
				FN +=1
		else:
			N = N+1
			if predictlabel[i] ==1:
				FP +=1
			else:
				TN +=1
	# print('predict:',predictlabel)
	# print('y:',label)
	# print('P:',P)
	# print('N:',N)
	# print('TP:',TP)
	# print('TN:',TN)
	acc = (TP+TN)/(P+N)
	#recall = TP/(TP+FP+1)		#+1防止除0
	#spec = TN/(TN+FN+1)
	#gmean = (recall * spec)**0.5

	# print('acc:',acc)
	# print('gmean:',gmean)

	return acc

def Crossvalidation(xa,xb,y,k,a,c,r):     #k 为k折交叉验证，y为label

	m,dim = xa.shape
	all_acc,all_gmean = [],[]


	for i in range(1,k):
		head = int(i*(m/k))   				#切割开始的索引号
		tail = int((i+1)*(m/k))
		# print('head:',head)
		# print('tail:',tail)

		test_a = xa[head : tail,:]
		test_b = xb[head : tail,:]
		test_label = y[head : tail]

		train_a = np.concatenate((xa[:head,:],xa[tail:,:]))
		train_b = np.concatenate((xb[:head,:],xb[tail:,:]))
		train_label = 	np.concatenate((y[:head],y[tail:]))

		A,B= MVSVM(train_a,train_b,train_label,a,c,r)
		t1 = accuracy(train_a,train_b,test_a,test_b,test_label,A,B,a,c,r)
		all_acc.append(t1)
		#print('acc:',t1)

	mean_acc =np.mean(all_acc)

	std_acc = np.std(all_acc)

	return mean_acc,std_acc

def gridsearch(xa,xb,y,k):
	max_acc = 0
	best_r,best_a,best_b,best_Ca,best_Cb,best_C = 0,0,0,0,0,0

	for i in [x*0.5 for x in range(1,2)]:			#a
		for j in [x * 0.1 for x in range(-20, -1)]:		#	c
			for n in [x * 0.5 for x in range(1, 2)]:			#r
				mean_acc, std_acc = Crossvalidation(xa,xb,y,k,i,j,n)  #Crossvalidation(xa,xb,y,k,r,a,b,Ca,Cb,C):
				if max_acc < max(max_acc,mean_acc):

					max_acc = max(max_acc,mean_acc)

					I = i
					J = j
					N = n
							# print('max_acc:',max_acc)
							# print(i,j,h,l,m,n)
	# print('i:',I)
	# print('j:',J)
	# print('n:',N)
	return max_acc

if __name__ =='__main__':

	xa, xb = [], []
	name_a, name_b = [], []
	for i in range(50):

		name_a.append(str(i) + 'a.csv')

		name_b.append(str(i) + 'b.csv')

		#path1 = '/Users/huihui/Documents/temp/code/multi/tnnls_dataset_map/corel_map/'
		path1 = '/Users/huihui/Documents/temp/code/multi/corel_image_dataset/'
		#name_a[i] = str(a) + 'a'
		#name_b[i] = str(a) + 'b'
		#path2 = '/Users/huihui/Documents/temp/code/multi/tnnls_dataset_map/'
	#print(len(name_a))
	for i in range(1,len(name_a)):

		tp = path1 + name_a[i]
		#print(tp)
		with open(path1+name_a[i],encoding='utf-8') as csvfile:
			datalist = [i for i in csv.reader(csvfile)]
			data_a = np.array(datalist)
		#	print(data_a)

		with open(path1+name_b[i],encoding='utf-8') as csvfile:
			datalist = [i for i in csv.reader(csvfile)]
			data_b = np.array(datalist)
		#	print('data_b.shape:',data_b.shape)

		y = data_a[:,0]
		#print('y',y)
		y = y.astype(np.float)
		xa = data_a[:,1:]
		#print('type:',type(xa[1,1]))
		xa = xa.astype(np.float)
		#print('type:', type(xa[1, 1]))
		xb = data_b[:,1:]
		xb = xb.astype(np.float)

		max_acc= gridsearch(xa,xb,y,5)
		#print('c',i)
		print(max_acc)
		#print(max_gmean)












