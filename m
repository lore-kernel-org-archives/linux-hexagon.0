From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Sat, 25 Aug 2018 20:16:39 -0700
Message-ID: <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E7C8783F0513F369AAD19004"
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K7mQxG2ycdukjCP1/IdWJHnAeFuCiaZvk9/pPPdHoxg=; b=BX/2MlR04BwpJpkGPJy7siPFk
	fHmEA+/EKoDUK87DelSlIhcBoRlAvhBomL+DFGQkYtckndUM+g3xNGi4Gpw5p30h+czahFdXtt9sD
	NIUzeHpbkv1Cdzr5de1eXmp5UgnTTA2dYfsNx/Byyeb7Jq7NpGi20JWu4x2zTM3pSl+Bfd+YTtc8d
	zbJqIAMA+FzndLfQEpIRIuAoL4BssEBUWv9prOp+lH2xY+zQoYs25QyI7Kse1eej0K6AepR/cEx4l
	aRx4sH6kpi9OLVPBgZAWXQuEq/1mG6rDVeqaUqw/jRNI01qdZQj0vmX7gTBCnhaG9JFN/Se9cpEd3
	Ng4lDza5Q==;
In-Reply-To: <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
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
--------------E7C8783F0513F369AAD19004
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08/25/18 19:38, H. Peter Anvin wrote:
>
> If it was worthwhile it would make more sense to at least force this
> into the rodata section with the string, something like the attached
> file for an example; however, I have a hunch it doesn't matter.
> 

An even nuttier version which avoids the extra pointer indirection.
Read it and fear.

	-hpa


--------------E7C8783F0513F369AAD19004
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
	unsigned short len;
	char str[0];
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

#define ifconst(x,y)	__builtin_choose_expr(__builtin_constant_p(x),(x),(y))

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

		

--------------E7C8783F0513F369AAD19004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-snps-arc mailing list
linux-snps-arc@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-snps-arc
--------------E7C8783F0513F369AAD19004--

