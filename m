From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/1] futex: remove duplicated code and fix UB
Date: Wed, 21 Jun 2017 20:53:37 -0700
Message-ID: <20170622035337.GF25900@fury>
References: <20170621115318.2781-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ypKb0x41ANWfrfCRuR+/20TNk9hZPKlr8geJdc2pE0E=; b=jWRp537qzlZNvI
	7qegdw9q4dAoJrnwgPYBta8GwWBCV1a648ByG7Sf3QKmzKvjs6Rp2HvucyfaBbMkRBIbYHK3+UFkW
	VSBWAVPYf43j+lGzLGI1cOf9DxHtqghsiKlZuiNIwyxkUoYYdZY7qUYBIQTiO9rMrutHK9zAuRIno
	5aCBOZaX7xaWY0mIUM+pe3DmkWSsT/J3/6Wb1QdyyUBhnl2TesXV6HK5IuyNeqGvFgWB8OpYMbKZb
	oWpvIBXy8mIaXwcoiuSgWTNT8YAdOxV3aRvY6a36lN2ITOJMruSIDQK7ZJ205Y+3ZhqHFdHmukrGP
	L+f36C6qjEBI2oG7uPJQ==;
Content-Disposition: inline
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, tglx@linutronix.de, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org, Stefan Kristiansson <ste>

On Wed, Jun 21, 2017 at 01:53:18PM +0200, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
> 
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
> 
> This effectively distributes the Will Deacon's arm64 fix for undefined
> behaviour reported by UBSAN to all architectures. The fix was done in
> commit 5f16a046f8e1 (arm64: futex: Fix undefined behaviour with
> FUTEX_OP_OPARG_SHIFT usage).  Look there for an example dump.
> 
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).
> 

This required a minor manual merge for ARM on the tip of Linus' tree today. The
reduced duplication is a welcome improvement.

Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>

-- 
Darren Hart
VMware Open Source Technology Center
