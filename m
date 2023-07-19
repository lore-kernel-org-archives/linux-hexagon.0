From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 6/9] vgacon: clean up global screen_info instances
Date: Wed, 19 Jul 2023 16:17:07 +0200
Message-ID: <87cz0ohtp8.fsf@minerva.mail-host-address-is-not-set>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-7-arnd@kernel.org>
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
	List-Owner; bh=JGI2pK8pfBXV9fdEywa6nAd2atT9pUmcJOJylXKjtXw=; b=MU06RU1zr/+8l1
	ft8IJFDdFaoYjSGsTSb+f+b8oye2Ufupz5cVytwFruanbYKjiYqkny8epCnTAf7Nw+by9XNBfV2qk
	D2QQCd7CInrH1gc1dfbZMOHB/CZpwiWF5XFSd0twarRpt8vmqzVccsieaw97bqz5I2yYEXWZshwfE
	51+zU8gyPTXhxlKQ/aMswG+D2j2d+8xw7JprcjzwhPcUxO8fX8tAWOd1KUK2axPoryCECVsujvacA
	+7vE2mpxyqgJTeFglkUxKvBKZWvpiYZqeNU7lNW+waxjK6ewb+6Xewy8pMMhr1AbZ17t/FzqRVHyt
	oEQUB2sz1g0z3eLfgvCw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689776252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjdFQRNR08a24eSSE2jcx3RnjwPdI3D1UG9L8u3hsoE=;
	b=GvFk42u94xyBV9J1PucXfmkCDMzFCyZcLAkWC5c9vOYRH4oopfQAdW4MGQYpg9pfahugm2
	aN7RAmzGq21L7gYfzeHoWn9YIVEs3gTwOUkIhllmk81bMeUw11jA8Zu+arXUxfskCOJNwW
	1YV1HGUima4kq1l95WLa7z6dOh5TTGA=
In-Reply-To: <20230719123944.3438363-7-arnd@kernel.org>
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
> To prepare for completely separating the VGA console screen_info from
> the one used in EFI/sysfb, rename the vgacon instances and make them
> local as much as possible.
>
> ia64 and arm both have confurations with vgacon and efi, but the contents

is this a typo for configurations ?

> never overlaps because ia64 has no EFI framebuffer, and arm only has
> vga console on legacy platforms without EFI. Renaming these is required
> before the EFI screen_info can be moved into drivers/firmware.
>
> The ia64 vga console is actually registered in two places from
> setup_arch(), but one of them is wrong, so drop the one in pcdp.c and
> the fix the one in setup.c to use the correct conditional.
>

s/the fix the/fix the

> x86 has to keep them together, as the boot protocol is used to switch
> between VGA text console and framebuffer through the screen_info data.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Patch looks good to me, but I'm not that familiar with some of the arches
to give a proper reviewed-by.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat
