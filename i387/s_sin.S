/*
 * Written by:
 *	J.T. Conklin (jtc@netbsd.org)
 *	Public domain.
 */

#include <i387/bsd_asm.h>
//__FBSDID("$FreeBSD: src/lib/msun/i387/s_sin.S,v 1.9 2011/01/07 16:13:12 kib Exp $")

ENTRY(sin)
	fldl	4(%esp)
	fsin
	fnstsw	%ax
	andw	$0x400,%ax
	jnz	1f
	ret
1:	fldpi
	fadd	%st(0)
	fxch	%st(1)
2:	fprem1
	fnstsw	%ax
	andw	$0x400,%ax
	jnz	2b
	fstp	%st(1)
	fsin
	ret
END(sin)

	
/* Enable stack protection */
#if defined(__linux__) && defined(__ELF__)
.section .note.GNU-stack,"",%progbits
#endif
