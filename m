From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Sat, 25 Aug 2018 21:56:11 -0700
Message-ID: <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7/6uoB7lxvhOkJ4I/159HCRqR1RdWF3nduy+Q8pnb6k=; b=rsraFt1cnw0Rw6
	XNm35alzdbEcc6EazoXvDeLVIbsIErNY1tpSOrgo4iAFR149vGUrR8gqp9X790pquM7Jnt9Rn3KW4
	G9uWrC1/uIKGK3Hh9smI0RzXcIpdJk57//kVa7i9ShCb9nJkvxr8VhVp9yO9I0mMWvx/t3OoqOa5s
	iBQgIBhZ6vHrR2QJBkIqWWocWhn5Wrw9ZMf795i48egvy1UrsjsMg8v3ME+tet0WtGfJYol/re1kb
	tQqYiIo65YXMKSL0XKeCU2SIG9I25K1BooGLFfGtFkr2+dqvew8nyx9kJGu6m/97OSLynqh0ibXld
	izqneQmsD8yxDwgjxCGA==;
In-Reply-To: <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
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

On 08/25/18 20:16, H. Peter Anvin wrote:
> On 08/25/18 19:38, H. Peter Anvin wrote:
>>
>> If it was worthwhile it would make more sense to at least force this
>> into the rodata section with the string, something like the attached
>> file for an example; however, I have a hunch it doesn't matter.
>>
> 
> An even nuttier version which avoids the extra pointer indirection.
> Read it and fear.
> 
> 	-hpa
> 

OK, so one more thing, I guess: it is necessary to suppress the tailcall
optimization for _RET_IP_ to make any sense, but that should be pretty
simple:

static inline void notailcall(void)
{
	asm volatile("");
}

	-hpa
