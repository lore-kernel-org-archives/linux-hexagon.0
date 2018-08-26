From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Sun, 26 Aug 2018 12:30:37 -0700
Message-ID: <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------5E98DEB96C9E8225D80004DF"
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qwQsI5/kqzja3zylWSKTta2r16vNQBcXywVSGHm/O2M=; b=dY4DWLLkXNwO2eV6iyuOFKs/M
	9X5If+/vGLM7EhcZq2cQKe0Bkxk1EHA5Z6myKA8NS9BTegY61GfRMU+2fd6a3GZwhWuhL+JECNjlm
	dbMqW5g4X65D5tQ4bSfy6pVMiRmAo13fHrCee4lhshRbhnEi9CAVBnTteQf5TOT+2Fq9kDHd3e7O1
	lU9nK9SHcjpPebRg9aVRBwSV3W6uGoXRJZ3HL+bYmj3denV7iXnFys4XdubMxiWB3OrAYR8lISqCu
	7dcUHlOkr/M4BFysSptgEfMbCjZRrV7qaCFpullzm4cXuxMnZadC6F/VQd2On7N4hz/bg1mhM2Cxa
	R1QBzi96Q==;
In-Reply-To: <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Helge Deller <deller@gmx.de>, Nick Desaulniers <ndesaulniers@google.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Vasily Gorbik <gor@linux.vnet.ibm.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Marc Zyngier <marc.zyngier@arm.com>, Ram Pai <linuxram@us.ibm.com>, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, Andy Lutomirski <luto@kernel.org>, Shannon Nelson <shannon.nelson@oracle.com>, tglx@linutronix.de, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kerne

This is a multi-part message in MIME format.
--------------5E98DEB96C9E8225D80004DF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Here is a full-blown (user space) test program demonstrating the whole
technique and how to use it.

	-hpa


--------------5E98DEB96C9E8225D80004DF
Content-Type: text/x-csrc;
 name="str.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="str.c"

#include <stddef.h>
#include <string.h>

#define _RET_IP_ ((unsigned long)__builtin_return_address(0))
#define noinline __attribute__((noinline))
#define used __attribute__((used))
/* __always_inline is defined in glibc already */
#define ifconst(x,y)	__builtin_choose_expr(__builtin_constant_p(x),(x),(y))
static inline void notailcall(void)
{
	asm volatile("");
}

/* Change this to a null string to make all functions global */
#define STATIC static

struct myputs_string {
	unsigned short len;
	char str[0];
};

STATIC int _myputs_struct(const struct myputs_string * const strs);
STATIC int _myputs_string(const char *str);
STATIC int __myputs(unsigned long ip, const char *str, size_t len);

#if 1

#include <stdio.h>

STATIC void dump_caller(unsigned long where)
{
	const char *opname = NULL;
	const char *wheretoname = NULL;
	char ichar;
	unsigned long whereto = 0;

#if defined(__i386__) || defined(__x86_64__)
	char opname_buf[4];
	unsigned char opcode;
	
	where -= 5;
	opcode = *(unsigned char *)where;

	switch (opcode) {
	case 0xe8:
		opname = "call";
		whereto = where + 5 + *(signed int *)(where + 1);
		break;
	case 0xe9:
		opname = "jmp";
		whereto = where + 5 + *(signed int *)(where + 1);
		break;
	default:
		snprintf(opname_buf, sizeof opname_buf, "?%02x", opcode);
		opname = opname_buf;
		break;
	}

#elif defined(__sparc__)
	const char regtype[4] = "gilo";
	unsigned int opcode, op1, op3, ibit;
	signed int simm13, simm30;
	char opname_buf[32];
	char *p;

	where -= 8;
	
	opcode = *(signed int *)where;
	op1 = opcode >> 30;
	op3 = (opcode >> 19) & 0x3f;
	ibit = (opcode >> 13) & 1;
	simm13 = (opcode & 0x1fff) << 2;
	simm30 = (opcode & 0x3fffffff) << 2;

	opname = opname_buf;
	
	if (op1 == 1) {
		opname = "call";
		whereto = where + simm30;
	} else if (op1 == 2 && op3 == 0x38) {
		if (ibit) {
			snprintf(opname_buf, sizeof opname_buf,
				 "jmpl %%%c%u %c 0x%x",
				 regtype[(opcode >> 17) & 3],
				 (opcode >> 14) & 7,
				 simm13 < 0 ? '-' : '+',
				 abs(simm13));
		} else {
			snprintf(opname_buf, sizeof opname_buf,
				 "jmpl %%%c%u + %%%c%u",
				 regtype[(opcode >> 17) & 3],
				 (opcode >> 14) & 7,
				 regtype[(opcode >> 3) & 3],
				 opcode & 7);
		}
	} else {
		snprintf(opname_buf, sizeof opname_buf,
			 "?0x08x", opcode);
	}
#else
	/* Unknown architecture */
#endif
	if (whereto == (unsigned long)_myputs_struct) {
		wheretoname = "_myputs_struct";
	} else if (whereto == (unsigned long)_myputs_string) {
		wheretoname = "_myputs_string";
	} else {
		wheretoname = "?";
	}

	ichar = '[';
	
	if (opname) {
		printf("%c%p: %s",
		       ichar, (void *)where, opname);
		ichar = ' ';
	}
	if (whereto) {
		printf("%c%p <%s>", ichar, (void *)whereto, wheretoname);
		ichar = ' ';
	}
	if (ichar != '[')
		putchar(']');
}
	
STATIC int __myputs(unsigned long where, const char *str, size_t len)
{
	size_t slen = strlen(str);
	size_t rv;
	
	len--;
	rv = printf("%p: \"%.*s\"%*s", (void *)where, (int)len, str,
		    16-(int)slen, "");
	dump_caller(where);
	if (slen != len)
		printf(" <err: strlen = %zu, len = %zu>\n", slen, len);
	else
		printf(" <ok: len = %zu>\n", len);
	
	return rv;
}

STATIC int noinline _myputs_struct(const struct myputs_string * const strs)
{
	return __myputs(_RET_IP_, strs->str, strs->len);
}

STATIC int noinline _myputs_string(const char *str)
{
	return __myputs(_RET_IP_, str, strlen(str)+1);
}
#endif

#define myputs(s)							\
({									\
	int _rv;							\
	if (__builtin_constant_p(s) &&					\
	    __builtin_constant_p(strlen(s)) &&				\
	    strlen(s)+1 == sizeof(s) &&					\
	    sizeof(s) <= (size_t)65535) {				\
	static const struct {						\
		struct myputs_string _mps_hdr;				\
		char _mps_str[sizeof(s)];				\
	} _mps = {							\
		._mps_hdr.len = sizeof(s),				\
		._mps_str = ifconst(s,""),				\
	};								\
		_rv = _myputs_struct(&_mps._mps_hdr);			\
	} else {							\
		_rv = _myputs_string(s);				\
	}								\
	notailcall();							\
	_rv;								\
})

STATIC int test1(void);
STATIC int test2(const char *strx);

STATIC int test1(void)
{
	return myputs("Foobar");
}

STATIC int test2(const char *strx)
{
	return myputs(strx);
}

int main(int argc, char *argv[])
{
	(void)argc;

	test1();
	test2(argv[0]);
	return 0;
}

--------------5E98DEB96C9E8225D80004DF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-snps-arc mailing list
linux-snps-arc@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-snps-arc
--------------5E98DEB96C9E8225D80004DF--

