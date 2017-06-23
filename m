From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] futex: remove duplicated code and fix UB
Date: Fri, 23 Jun 2017 09:51:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706230017520.2221@nanos>
References: <20170621115318.2781-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QDq8YolhFGn7tbY1zhH1CEvhUgq/HfpFUel5pHLUI8=; b=gqEgmOYR3bTEg/
	m4BjMrvZgvAVW7zNpDi1QY5lQwUEhuaIe1oS8XzyKYLndcg+cLjGP6edmbgZaZZ9x4AopWmzyODuf
	7R77/Jb3hY8OkqQrXfbg16wWV1Go44TvpZaPMI9hZV/jn3udQ/2IntcO6lSnj6r2oSmRBPrLi2fu/
	qYQ+q1t8NeXK4eSfTgRbjM74ML3Oc9aVE1/y6znz3XC/2iKZfIhKtFumoSaefM92vjA6rJ6QpTv1W
	Vsoe0PcE5zypdtux02TFxj6u04cKhaoGSTh8UGPva/TURk5Txq+UT7RBtQre3U4WyZQUsKr9KdYfv
	H61leGNrfQpo/MJp3PXA==;
In-Reply-To: <20170621115318.2781-1-jslaby@suse.cz>
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
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>, dvhart@infradead.org, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org, Stefan Kristiansson <>

On Wed, 21 Jun 2017, Jiri Slaby wrote:
> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> index f32b42e8725d..5bb2fd4674e7 100644
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -48,20 +48,10 @@ do {									\
>  } while (0)
>  
>  static inline int
> -futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)

That unsigned int seems to be a change from the arm64 tree in next. It's
not upstream and it'll cause a (easy to resolve) conflict.

> +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> +{
> +	int op = (encoded_op >> 28) & 7;
> +	int cmp = (encoded_op >> 24) & 15;
> +	int oparg = (int)(encoded_op << 8) >> 20;
> +	int cmparg = (int)(encoded_op << 20) >> 20;

So this is really bad. We have implicit and explicit type casting to
int. And while we are at it can we please stop proliferating the existing
mess.

'op' and 'cmp' definitly can be unsigned int. There is no reason to cast
them to int.

oparg, cmparg and oldval are more interesting.

The logic here is "documented" in uapi/linux/futex.h

/* FUTEX_WAKE_OP will perform atomically
   int oldval = *(int *)UADDR2;
   *(int *)UADDR2 = oldval OP OPARG;
   if (oldval CMP CMPARG)
       wake UADDR2;  */

Now the FUTEX_OP macro which is supposed to compose the encoded_up does:

#define FUTEX_OP(op, oparg, cmp, cmparg) \
  (((op & 0xf) << 28) | ((cmp & 0xf) << 24)             \
   | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))

Of course this all is not typed, undocumented and completely ill
defined.

> +	int oparg = (int)(encoded_op << 8) >> 20;
> +	int cmparg = (int)(encoded_op << 20) >> 20;

So in fact we sign expand the 12 bits of oparg and cmparg. Really
intuitive.

Yes, we probably can't change that anymore, but at least we should make it
very explicit and add a comment to that effect.

Thanks,

	tglx
