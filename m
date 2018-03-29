From: Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Thu, 29 Mar 2018 09:12:10 +0800
Message-ID: <20180329011210.GA4275@WeideMacBook-Pro.local>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QyAdBoaK/beNrWPszdFE0Y2uZrLVDr5lZcwBuSnac50=; b=NLuLAy/u0CmbeN
	aIlzRKiaqq4clImdUHd3ByvzJigiQ9pZXim6a/1ywrHz5gpVc68qZK0myeJwx8WhnYbxITwDJN2Ay
	gC/Xh6XOO2YlrMlE//qvWpFCdMhg7xrZ9uiTwTfe7i9/xmzhMh0pVFiPDsAspqliyomqe9iQXZqR1
	UoPY/Y2gMsKzKjPmu1RycJ2gFTigxBmnmK0qqUuBA/h4I+RN8WdBEuQfrjnaoGBb/UhvFUOETseb/
	ah63d4TX6rPaPtf0CJyiGb90B7VlbGS6AyrERyLhhIke72Ct3HP7vwIqsPpj9rE9QSU8guB2+PXCn
	fAsm9es/zOSDz3T+WeHQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GAsEAuA/4wkkmLXuWBTfZ4TahUKEhDVaSCN3DyLMjvE=;
 b=LHfXHTp7MzKRPDSPZV2kYbx9kEXh85Q7liv+TLSGpWcJRHzbAGkOQ1rGp6+aAJw0Rp
 IG/zdWQhG1oyyXQG7Pc1+oKUW4kakhfDbLxX9jzzrLDE783il+ILPeB7tr9dJjjZeM4D
 3kj27mWYweHChqDNKerEu27J5Gle6OdWMpEeOvU8+WXE7BzXwiurBn5CxcTwV83iHhTT
 oFp03ZQo+rdCpl5sRgN5wAEZN2a6e3K9YNiBc5kTu+/iFs0lj+WXLH4qlDG8KE949mcI
 Ih8lSjGSe2OEh3HjNmJePj0MxtgdTExA9ydLDH1VduifGwEuACk1aGIgMSVquaa3iN1o
 yTBA==
Content-Disposition: inline
In-Reply-To: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-sh <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfou>

On Wed, Mar 28, 2018 at 09:55:07AM -0700, Kees Cook wrote:
>On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
>>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
>Yay consolidation! :)
>
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>         default ".lzma" if RD_LZMA
>>         default ".bz2"  if RD_BZIP2
>>         default ""
>> +
>> +config HAVE_ARCH_FREE_INITRD_MEM
>> +       bool
>> +       default n
>
>If you keep the Kconfig, you can leave off "default n", and I'd
>suggest adding a help section just to describe what the per-arch
>responsibilities are when select-ing the config. (See
>HAVE_ARCH_SECCOMP_FILTER for an example.)
>

One question about this change.

The original code would "select" HAVE_ARCH_FREE_INITRD_MEM on those arch.
After this change, we need to manually "select" this?

>-Kees
>
>-- 
>Kees Cook
>Pixel Security

-- 
Wei Yang
Help you, Help me
