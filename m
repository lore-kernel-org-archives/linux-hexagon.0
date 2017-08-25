From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/1] futex: remove duplicated code and fix UB
Date: Fri, 25 Aug 2017 22:43:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708252243020.2124@nanos>
References: <20170824073105.3901-1-jslaby@suse.cz>
 <20170824094756.GA6346@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6cGgc292RtDsTw2FbkcoDsB9ktHCDQVKisSTidrMDjY=; b=RNrCNyEG8W3K0i
	ZZyUac5lZtojyBylPeBpr0N2tLDk0Ez8Vkshos6R1a2hdAanBJEshDbQXfC2ROQasn9qPxiAXkMys
	KSj+ecGDNqykV/chXqb/w6y8/xCwJVCIJdszvOg0XogjSbPgZN+ilXY4S6lx9IVTS8nHFxNPrh0+T
	e/akRqvd924qzi6MeeOg+Ssq8g5cq/RmtYRzp1NnzD8JEHn/vUHfq/Cpg0js9o5VHDSerNTfBgWAC
	wUrMcnikOLrUNWkfP7oSmeDdL1IWIOHxTF+k8m3JIgTijZFqywOIeHkhxGcgO3lr9MBu4j8XKmxN0
	Uf4UW8NRYJ0mZe9k4hew==;
In-Reply-To: <20170824094756.GA6346@arm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>, dvhart@infradead.org, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org, Stefan Kristiansson <stefan>

On Thu, 24 Aug 2017, Will Deacon wrote:
> On Thu, Aug 24, 2017 at 09:31:05AM +0200, Jiri Slaby wrote:
> > +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > +{
> > +	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
> > +	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
> > +	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> > +	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
> > +	int oldval, ret;
> > +
> > +	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
> > +		if (oparg < 0 || oparg > 31)
> > +			return -EINVAL;
> > +		oparg = 1 << oparg;
> > +	}
> > +
> > +	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> > +		return -EFAULT;
> > +
> > +	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
> > +	if (ret)
> > +		return ret;
> 
> We could move the pagefault_{disable,enable} calls here, and then remove
> them from the futex_atomic_op_inuser callsites elsewhere in futex.c

Correct, but we can do that after getting this in.

Thanks,

	tglx
