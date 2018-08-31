From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Fri, 31 Aug 2018 09:48:56 -0700
Message-ID: <CAKwvOdmXhRZJ5bQw+W0Ro+oeWSTRJzG1UAJnjyjciR1JFs+ubA@mail.gmail.com>
References: <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
 <20180827073358.GV24124@hirez.programming.kicks-ass.net>
 <f9896d68-4a49-e666-cea5-a9c0522f1658@zytor.com>
 <20180827131103.GD24124@hirez.programming.kicks-ass.net>
 <4d1a8f35-e2fc-70d2-ca0e-44b8574c86f1@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uPK7SUogjrFbV1F0zVInHfuefnDhQ7ws4nvm0gi0cWk=; b=RQML+wWd3vd/V9
	nL94TK2CqJ9uTzvGDUu5qT3MszFsFqRv36MPsoVzTjg4N+T28FyTHQWXDU8uaiqmF4UStoZHHaunV
	0zGLFT2g0tgLTBvv4eK0l5VoivVKZ6sl/juvCs/D5JO3rgSFkwMkWNYqL9RW3+yqXl5cFqghWMf4h
	KRojBNmVHBCMEQSnJjSJTz3sZFFoj96CMTA/gL3rfqtKnitHVX/30UW4wDAdoY8TMwyv1QfhPjDGp
	7IV9Uc069liV5YaOw1pRymKhtJlbN8jZ1RGdLdA2Z00I88jf6cvLxilS1GOpbUIzAeVdNa00hO2a6
	54LHUecjosNpoWIq8mqg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bCAuXK2OzX1Y32o4nfX28eLgRp+6m9IIcFWuemVE5WY=;
 b=N18YRpr8Sb1LGBugLd2WKciz/6inmAgY4pGO/BJSgASuLXw3cUZK9Fc91sHLPyPzur
 h59KQ9BlIUiAigm8ubE55V4N6/53+5jD/Kbcq0N4xoPSeBxIkDwJwdwSUWzEzVMbb0TZ
 MFQdDCBv+rpJUkfTRi2D3PtRo5/qh6AEEdTLb/aEIliVhnpYKjp4Q2bakgARP51iJNrC
 01+GpwMzT5JyHtVWTwLziSLHTD5MwGA+OqGWBpU6VPF6Pu/NKBJ6SM3aDjR6VSQ6Wq36
 zTPjlA8/quUpxZwtwYw69Qzm4KCXQAHE0iJNTjbS/JujWES9LuRc4lxfgVtesjPXWf5A
 nGaw==
In-Reply-To: <4d1a8f35-e2fc-70d2-ca0e-44b8574c86f1@zytor.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, benh@kernel.crashing.org, Will Deacon <will.deacon@arm.com>, paulus@samba.org, mpe@ellerman.id.au, jejb@parisc-linux.org, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, gor@linux.vnet.ibm.com, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Marc Zyngier <marc.zyngier@arm.com>, linuxram@us.ibm.com, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, luto@kernel.org, shannon.nelson@oracle.com, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, rth@twiddle.net, jkosina@suse.cz, LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, rkuo@codeaurora.org, paul.burton@mips.com, aneesh.kumar@linux.vnet.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Andrew

On Mon, Aug 27, 2018 at 6:34 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 08/27/18 06:11, Peter Zijlstra wrote:
> > On Mon, Aug 27, 2018 at 05:26:53AM -0700, H. Peter Anvin wrote:
> >
> >> _THIS_IP_, however, is completely ill-defined, other than being an
> >> address *somewhere* in the same global function (not even necessarily
> >> the same function if the function is static!)  As my experiment show, in
> >> many (nearly) cases gcc will hoist the address all the way to the top of
> >> the function, at least for the current generic implementation.
> >
> > It seems to have mostly worked so far... did anything change?
> >
>
> Most likely because the major architectures contain a arch-specific
> assembly implementation.  The generic implementation used in some places
> is completely broken, as my experiments show.
>
> >> For the case where _THIS_IP_ is passed to an out-of-line function in all
> >> cases, it is extra pointless because all it does is increase the
> >> footprint of every caller: _RET_IP_ is inherently passed to the function
> >> anyway, and with tailcall protection it will uniquely identify a callsite.
> >
> > So I think we can convert many of the lockdep _THIS_IP_ calls to
> > _RET_IP_ on the other side, with a wee bit of care.
> >
> > A little something like so perhaps...
>
> I don't have time to look at this right now (I'm on sabbatical, and I'm
> dealing with personal legal stuff right at the moment), but I think it
> is the right direction.
>
>         -hpa

Linus,
Can this patch please be merged?  Then we can polish off Peter's
change to lockdep to not even use _THIS_IP_.

-- 
Thanks,
~Nick Desaulniers
