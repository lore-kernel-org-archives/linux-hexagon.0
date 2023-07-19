From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 7/9] vga16fb: drop powerpc support
Date: Wed, 19 Jul 2023 16:23:53 +0200
Message-ID: <87a5vshtdy.fsf@minerva.mail-host-address-is-not-set>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-8-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qTjRvb/QfLNjpRtNxlWBHMNJQEzP06trON4PO57jwaw=; b=GDCtDZhcyXEJic
	+5Jb7MrSLwUt5bK0ZhCDUixVmw0+02WDBieEXKynpl6XoGLGnDAFdCLyX6TVrUJb1UlcvTObG/QBI
	e8kxcSMARX0cFcTWNmDmFkC/HLRPZbrz6BnRuUCO7Dx5cox/e4J//TF6A2R6ZbykAGr1wqWJ+FK1J
	vVLFjmTzUMGY+cQhcDP+mxsKgHKKKsilpBX9ebr053jMLWJVfSV1OF/I8PUjM2Af4as73g7wtCmiU
	ckHnPQ/MiKkeuJOAJdOs0EMp+Td4uY4EA0VWeX/oFEiad5YPCYJlvOklYGhZ05nxC65EXgRZvIMp/
	WQhVyvgqIP1Vzb1M8nZg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689776639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AYL0WxfELPHjwx6ZiDqavEiQQIijrcopNRfhrvLV03A=;
	b=DGl5JY9HyulFIN/2+f+illzXjr1CUuSPQJD1122DRrwP6xZ92xeN2pjhyAJKxa+HgV3FIl
	MynIC41Cm5gBRFdGnOCNo1AIeuuXPtrvlxSorh2+q4UwJ7JZyfc3uHorXVkAiFh5mHtz0H
	ecT14gFgxtldx91wuKFNLDzERZKBYqE=
In-Reply-To: <20230719123944.3438363-8-arnd@kernel.org>
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
To: Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Khalid Aziz <khalid@gonehiking.org>, Linus Walleij <linus.walleij@linaro.org>, Matt Turner <mattst88@gmail.com>, Max

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> I noticed that commit 0db5b61e0dc07 ("fbdev/vga16fb: Create
> EGA/VGA devices in sysfb code") broke vga16fb on non-x86 platforms,
> because the sysfb code never creates a vga-framebuffer device when
> screen_info.orig_video_isVGA is set to '1' instead of VIDEO_TYPE_VGAC.
>
> However, it turns out that the only architecture that has allowed
> building vga16fb in the past 20 years is powerpc, and this only worked
> on two 32-bit platforms and never on 64-bit powerpc. The last machine
> that actually used this was removed in linux-3.10, so this is all dead
> code and can be removed.
>
> The big-endian support in vga16fb.c could also be removed, but I'd just
> leave this in place.
>
> Fixes: 933ee7119fb14 ("powerpc: remove PReP platform")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat
