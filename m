From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 05/18] x86: remove __range_not_ok()
Date: Fri, 18 Feb 2022 15:45:56 +0000
Message-ID: <905678e9e05d40b9a4e13e7b1a34cb68@AcuMS.aculab.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-6-arnd@kernel.org> <20220218062851.GC22576@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9HjOUxkJDZcKY2lpfenRwzN0l0eUl60EzGlOOrevbww=; b=mvRy11ASXQtD2e
	0jjAq4uWUqcmIQ5iD0lw12xNuymiFh4OP+++G3T6RqFnmn4es90gHj7nW5oBrY/vpNnswIL9X38Zw
	4gVHLN5vpBNKr9p0TxP/8I33QA+bvSbVPStw71tAK9iM3B5Vj5ELGLjLa1LjckGFPBf+Euru97V2c
	HODM8CaZGij1Px7LfZGw7URViQwUd1mdaWSmqyRe0j6RwH1sPbyDKCdN0JFsRjTkLBUzsgTXGO4x0
	MnckAhVXve3gUgal0IIc0bhrnJzo9/KRsn4Oj/jL/q2Fc9/rxsLHUzIzYAySRx9cToM1owiMM16Ck
	0S0RZIMNcj8DQxO1YdWQ==;
In-Reply-To: <20220218062851.GC22576@lst.de>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: 'Christoph Hellwig' <hch@lst.de>, Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "will@kernel.org" <will@kernel.org>, "guoren@kernel.org" <guoren@kernel.org>, "bcain@codeaurora.org" <bcain@codeaurora.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>, "nickhu@andestech.com" <nickhu@andestech.com>, "green.hu@gmail.com" <green.hu@gmail.com>, "dinguyen@kernel.org" <dinguyen@kernel.org>, "shorne@gmail.com" <shorne@gmail.com>, "deller@gmx.de" <deller@gmx.de>, mp

From: Christoph Hellwig
> Sent: 18 February 2022 06:29
...
> 
> > diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> > index 15b058eefc4e..ee117fcf46ed 100644
> > --- a/arch/x86/kernel/stacktrace.c
> > +++ b/arch/x86/kernel/stacktrace.c
> > @@ -90,7 +90,7 @@ copy_stack_frame(const struct stack_frame_user __user *fp,
> >  {
> >  	int ret;
> >
> > -	if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
> > +	if (!__access_ok(fp, sizeof(*frame)))
> >  		return 0;
> 
> Just switch the __get_user calls below to get_user instead.

Is this worth doing at all?
How much userspace code is actually compiled with stack frames?

Won't work well for a 32bit process on a 64bit kernel either.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
