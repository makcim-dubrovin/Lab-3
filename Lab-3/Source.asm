.686
.model flat,stdcall
.stack 100h
.data

array dd 17.0, 20.0, 30.0
	  dd 11.0, 24.0, 1.0
	  dd 2.0, 5.0, 6.7
	  dd 56.0, 27.0, 3.5

n dd 4;число строк
m dd 3;число столбцов

i dd 0;счётчик строк
j dd 0;счётчик столбцов

mysize dd 4;

odin dd 1;

SUM_row dd 0.0;сумма чисел в нечётных строках
SUM_col dd 0.0;сумма чисел в нечётных столбцах

.code
ExitProcess PROTO STDCALL :DWORD
Start:
	finit;

	;внешний цикл
	L1:
		mov j, 0;
		xor eax, eax;
		xor ebx, ebx;
		xor ecx, ecx;
		
		L2:
			mov eax, i;
			and eax,odin;

			cmp eax, odin;
			je L3;
			jne L4;

			L3:
				xor eax, eax;
				;address calculate
				mov eax, m;
				mul i;
				add eax, j;
				mul mysize;
				;use eax
				fld array[eax];
				fld SUM_row;
				fadd;
				fstp SUM_row;

			L4:
				mov eax, j;
				and eax, odin;
				cmp eax, odin;
				je L5;
				jne L6;

				L5:
					xor eax, eax;
					;address calculate
					mov eax, m;
					mul i;
					add eax, j;
					mul mysize;
					;use eax
					fld array[eax];
					fld SUM_col;
					fadd;
					fstp SUM_col;
			L6:

			inc j;
			mov ecx, j;
			mov ebx, m;
			cmp ecx, ebx;
			jne L2;

		inc i;
		mov ecx, i;
		mov ebx, n;
		cmp ecx, ebx;
		jne L1;

		fld SUM_row;
		fld SUM_col;
		fstp SUM_col;
		fstp SUM_row;
exit:
Invoke ExitProcess,1
End Start
