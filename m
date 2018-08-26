From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Sat, 25 Aug 2018 19:38:47 -0700
Message-ID: <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------CE37549B542F2DC07673DCF7"
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6RSP2i89LzWD/6vfYExz4X0ry9DlvleS/oKCCr5Lxr0=; b=oUJbq98AjQ69XJmdsETiqMX6G
	duaf2QnZYw7py5pPxNqfaOfu45G8UC3ExpSm4I35kAgNNu76WTJd56e8mQbIUwIry5w2R9jf/TfFV
	igDp1WvEScX2IZ93GozAMR5fQ02oRc4R/OWWQtJlQcNMGUWkaSJsGg68imx0zAMGntD6+clULd0FQ
	P0hODACtdEnzhW2RiQvgVJbshpfHui65I2VE9SDVbEaTrOZVBQvwE4sLuFtSyHio3FV3fxEEoNcYX
	hgrFy/RZ3a0mAgXGBK4OY3csHXsv/Y0TLsYzIqkcjVGohKmauExCr9oIE7i66jeQ4lnceJ5PQRHmz
	rYSmKLJhQ==;
In-Reply-To: <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
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
--------------CE37549B542F2DC07673DCF7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08/25/18 03:48, Helge Deller wrote:
> 
> Currently alpha, s390, sparc, sh, c6x, ia64 and parisc provide an
> inline assembly function to get the current instruction pointer. 
> As mentioned in an earlier thread, I personally would *prefer* if 
> _THIS_IP_ would use those inline assembly instructions on those
> architectures instead of the (currently used) higher C-level
> implementation.
> 

Older ones have as well, e.g. x86.

The only reason to retain the use of an assembly function would be in
the case where either:

a) the C implementation produces bad or invalid code on certain
   architectures;
b) there is a specific requirement that either an absolute or a relative
   value is used in the binary, e.g. due to constraints on relocation.
   The latter particularly comes to mind since the x86-64 implementation
   in assembly will produce movq $.,%reg (which requires relocation)
   instead of the more natural leaq .(%rip),%reg.

In the case (a) those architectures ought to be able to simply

#undef _THIS_IP_
#define _THIS_IP_ blah...

and in case (b) *those specific instances* should be using some kind of
specially flagged function e.g. current_true_ip() vs.
current_linktime_ip() or somesuch.

I also note that a lot of those functions are not marked
__always_inline, which is a serious error should the compiler ever get
the idea to out-of-line these functions, which could potentially happen
as gcc is rather bad at assigning weight to an assembly statement.

I'm also going to throw in a perhaps ugly bomb into this discussion:

_THIS_IP_ seems to be horribly ill-defined; there is no kind of
serialization, and no reason to believe it can't be arbitrarily hoisted
inside a function. Furthermore, *most of the uses of _THIS_IP_ seem to
be either discarded or passed to a function*, and the location of a
function call, unlike _THIS_IP_ is very well defined.

In that case, the use of this mechanism is completely pointless and
ought to be replaced with _RET_IP_.  It seems like most invocations of
_THIS_IP_ can be trivially replaced with _RET_IP_ inside the function,
which would also reduce the footprint of the function call, for example:

__trace_puts() is only ever called with _THIS_IP_ as the first argument;
drop that argument and use _RET_IP_ inside the function (also,
__trace_puts() only ever uses strlen() as the third argument, which gcc
can of course optimize into a constant for the case of a consta t
string, but *is that optimization actually worth it*?  In the case of
__trace_puts(), a variable strlen() would only ever need to be called in
the case of an allocation actually happening -- otherwise str is never
examined -- and again, it increases the *code size* of the call site.
If it was worthwhile it would make more sense to at least force this
into the rodata section with the string, something like the attached
file for an example; however, I have a hunch it doesn't matter.

I wouldn't be surprised if all or nearly all instances of _THIS_IP_ can
be completely removed.

	-hpa

--------------CE37549B542F2DC07673DCF7
Content-Type: text/x-csrc;
 name="str.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="str.c"

#include <stddef.h>
#include <string.h>

#define _RET_IP_ ((unsigned long)__builtin_return_address(0))
#define no_inline __attribute__((noinline))
#define must_inline __attribute__((always_inline)) inline

struct myputs_string {
	size_t len;
	const char *str;
};

int _myputs_struct(const struct myputs_string * const strs);
int _myputs_string(const char *str);
int __myputs(unsigned long ip, const char *str, size_t len);

int no_inline _myputs_struct(const struct myputs_string * const strs)
{
	return __myputs(_RET_IP_, strs->str, strs->len);
}

int no_inline _myputs_string(const char *str)
{
	return __myputs(_RET_IP_, str, strlen(str)+1);
}

#define myputs(s)							\
({									\
	int _rv;							\
	if (__builtin_constant_p(s) &&					\
	    __builtin_constant_p(strlen(s)) &&				\
	    strlen(s)+1 == sizeof(s)) {					\
		static const struct myputs_string _mps = {		\
			.len = sizeof(s),				\
			.str = __builtin_constant_p(s) ? s : NULL,	\
		};							\
		_rv = _myputs_struct(&_mps);				\
	} else {							\
		_rv = _myputs_string(s);				\
	}								\
	_rv;								\
})

int test1(void);
int test2(const char *strx);

int test1(void)
{
	return myputs("Foobar");
}

int test2(const char *strx)
{
	return myputs(strx);
}

		

--------------CE37549B542F2DC07673DCF7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-snps-arc mailing list
linux-snps-arc@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-snps-arc
--------------CE37549B542F2DC07673DCF7--

