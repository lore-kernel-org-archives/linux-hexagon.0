From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Mon, 2 Apr 2018 07:59:33 +0200
Message-ID: <20180402055933.zbpyorktot2owzzu@gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <20180330111517.rrx6gs2skkgk336j@gmail.com>
 <87bmf3rmq6.fsf@xps13.shealevy.com>
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
	List-Owner; bh=VkYgcBK2fNByCPwqD7/E3jN0zq1jR4T7h/HLzgu7M7U=; b=D4/yJJEORL4qmV
	7uhEOHczNCI9R2VA8yIl6PeJBiiqZUsCSO9dF8GOrlzLvK+GcECk/cbe05QjbSyo7M7ThQ3x2HOxe
	1HBhyTDs/CWocnvvEG2Km6q8Z7OSK3e9r93PZI4L84s7iG+jHrn05UARp+uezmUc2b+JwlRvixMc7
	b+X0oy54IGJMWBPvQKSFe/YmMv0t48O7i4ZgcX8OQ6tSy0Gqb7DdXl0qOHtO2+ugCGHhCgJMIxhvU
	flcS5oea9ZEJf3SKSUOH7O5AVYQYdnO6UE+RgOV5zYH4q6A4RRhXfXDsrJ0RC5HoeVmXWRvl7GYas
	bGiXCEAAwdD0nu9TbYNw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8S9j2GGiF6Hq0Ve0gp08kcpf5x+zmb5JGAyHhh8nX3A=;
 b=mRWIiq1YCiNEshVpIeud/3kWUb5WXPPOKk0dM5K2GdMhqgC1iYgkbzw4KORY0u68/m
 BetUrvTjPHbCQuuLIKCfBToMGsvegUHk8lkk1NwY/W9ysX8E4Ozl+yErcFmHhMKP7el1
 81oOjTsTsPFQRGWIWZ9u8g2saiMtCPudnxgUAnDs2q/+OSchqLb3psIdsZslYXQHB2N9
 bIDZvLjHSQZ35gtr0q0+D0y7TlYmmED6tX/4ktfdh9HeA/0uP2aPJ8m8vuGhGVFmknDl
 I0/jtIc5Uax54RYLxlnkx2p11PsjIAApq5WbSKUtrHxu8bc5b4HEqwouw1yIv6Ge0Oco
 T6Yw==
Content-Disposition: inline
In-Reply-To: <87bmf3rmq6.fsf@xps13.shealevy.com>
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
To: Shea Levy <shea@shealevy.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kerne


* Shea Levy <shea@shealevy.com> wrote:

> > Please also put it into Documentation/features/.
> 
> I switched this patch series (the latest revision v6 was just posted) to
> using weak symbols instead of Kconfig. Does it still warrant documentation?

Probably not.

Thanks,

	Ingo
