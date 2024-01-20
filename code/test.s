	.file	"test.c";源文件名
	.text;开始代码段
	.globl	func1;全局符号func1
	.type	func1, @function;func1为函数类型
func1:;函数开始标签
.LFB0:
	.cfi_startproc
	pushq	%rbp;保存调用者帧指针到栈顶
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp;将栈顶指针赋值给帧指针，创建新的栈帧
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp);将函数参数arr的地址存储在帧指针相对位置-24处
	movl	%esi, -28(%rbp);将函数参数size存储在帧指针相对位置-28处
	movl	$0, -8(%rbp);初始化累加器变量cnt为0，存储在帧指针相对位置-8处
	movl	$0, -4(%rbp);初始化变量i为0，存储在帧指针相对位置-4处
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax;循环计数器i加载到eax寄存器
	cltq
	leaq	0(,%rax,4), %rdx;计算数组元素的地址
	movq	-24(%rbp), %rax;加载arr的地址到rax
	addq	%rdx, %rax;计算出当前要访问的数组元素的实际地址
	movl	(%rax), %eax;从计算处的地址读取int型数组元素到eax
	addl	%eax, -8(%rbp);数组元素和cnt累加
	addl	$1, -4(%rbp);i自增1
.L2:
	movl	-4(%rbp), %eax;i加载到eax
	cmpl	-28(%rbp), %eax;检查i是否小于size
	jl	.L3
	movl	-8(%rbp), %eax;循环结束时，将最终的cnt加载到eax
	popq	%rbp;恢复调用者的帧指针
	.cfi_def_cfa 7, 8
	ret;返回到调用者，将eax中的值作为返回值
	.cfi_endproc
.LFE0:;func1的结束标签
	.size	func1, .-func1;记录func1函数大小，从函数标签到当前地址距离
	.globl	func2;定义全局符号func2,
	.type	func2, @function;标记func2为函数类型
func2:;func2开始标签
.LFB1:;函数起始
	.cfi_startproc
	pushq	%rbp;保存调用者指针到栈顶
	.cfi_def_cfa_offset 16;更新CFA偏移量为16字节
	.cfi_offset 6, -16;设置rbp寄存器在当前帧中偏移量为-16
	movq	%rsp, %rbp;将栈顶指针赋值给栈指针，创建新的栈帧
	.cfi_def_cfa_register 6;设置帧指针作为新的CFA寄存器
	movl	%edi, -20(%rbp);将a的值存储在rbp相对位置-20处
	movl	%esi, -24(%rbp);将b的值存储在rbp相对位置-24处
	movl	-20(%rbp), %eax;将a的值加载到eax寄存器
	movl	%eax, -4(%rbp);将eax寄存器的值存储在rbp相对位置-4处
	movl	-24(%rbp), %eax;将b的原始值重新加载到eax寄存器
	movl	%eax, -20(%rbp);eax寄存器的值覆盖到rbp相对位置-24处
	movl	-4(%rbp), %eax;将之前暂存的a的值加载到eax寄存器
	movl	%eax, -24(%rbp);eax的值覆盖到rbp相对位置-24处
	nop
	popq	%rbp;恢复调用者的帧指针
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:;func2的结束标签
	.size	func2, .-func2;记录func2的大小，从函数标签到当前地址的距离
	.globl	func3;定义全局函数func3
	.type	func3, @function;标记func3为函数类型
func3:;func3开始标签
.LFB2:
	.cfi_startproc
	pushq	%rbp;保存调用者指针到栈顶
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp;栈顶指针赋值给帧指针，创建新的栈帧
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp);将a的值存储在rbp相对位置-24处
	movq	%rsi, -32(%rbp);b的值存储在rbp相对位置-32处
	movq	-24(%rbp), %rax;a加载到rax
	movl	(%rax), %eax;获取rax指向的内存地址处的int值，存入eax
	movl	%eax, -4(%rbp);eax的值暂存至rbp相对位置-4处
	movq	-32(%rbp), %rax;b加载到rax
	movl	(%rax), %edx;获取rax指向内存地址处的int值，存入edx
	movq	-24(%rbp), %rax;再把a加载到rax
	movl	%edx, (%rax);b的地址指向的值写入a的地址指向的值的位置
	movq	-32(%rbp), %rax;b加载到rax
	movl	-4(%rbp), %edx;将暂存a指向的值重新加载到edx
	movl	%edx, (%rax);edx的值写入rax，就是b指向的地址
	nop
	popq	%rbp;恢复调用者栈指针
	.cfi_def_cfa 7, 8
	ret;返回到调用者
	.cfi_endproc
.LFE2:
	.size	func3, .-func3;记录func3的大小
	.globl	main;定义main，标志主函数开始
	.type	main, @function;标记main为函数
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp;保存调用者帧指针到栈顶
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp;栈顶指针赋值给帧指针，创建新的栈帧
	.cfi_def_cfa_register 6
	subq	$48, %rsp;在栈上分配48字节用于存储局部变量
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax;清零eax
	movl	$1, -48(%rbp);初始化i为1
	movl	$3, -40(%rbp);初始化j为3
	movl	$5, -44(%rbp);初始化k为5
	movl	$1, -32(%rbp);连续为数组元素赋值 1~6
	movl	$2, -28(%rbp)
	movl	$3, -24(%rbp)
	movl	$4, -20(%rbp)
	movl	$5, -16(%rbp)
	movl	$6, -12(%rbp)
	leaq	-32(%rbp), %rax;arr数组的地址加载到rax
	movl	$6, %esi;数组大小为6，存入esi
	movq	%rax, %rdi;数组地址传给rdi
	call	func1;调用func1
	movl	%eax, -36(%rbp);func1存入rbp相对位置-36处
	movl	-48(%rbp), %eax;取i到eax
	movl	-40(%rbp), %edx;取j到edx
	movl	%edx, %esi;edx中的j作为func2的第二个参数
	movl	%eax, %edi;eax中的i作为func2的第一个参数
	call	func2;调用func2
	leaq	-44(%rbp), %rdx;取rbp相对位置-44位置的元素放入rdx
	leaq	-48(%rbp), %rax;取rbp相对位置-48位置的元素放入rax
	movq	%rdx, %rsi;rdx存储的地址放入rsi
	movq	%rax, %rdi;rax存储的地址放入rdi
	call	func3;调用func3
	movl	$0, %eax;准备返回值0
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
