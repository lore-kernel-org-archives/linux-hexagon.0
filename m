From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
Date: Fri, 30 Jun 2023 13:53:24 +0200
Message-ID: <dd5aa01e-afad-48d2-bf4c-4a58b74f1644@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
 <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
 <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
 <ef7b3899-7d18-8018-47fa-aac0efaa61f4@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p9Lm1vH3iPjdDaogiB5sjtYBweuHEJ9bA2k4Zt2Uz5Y=; b=1QTD/U/4On8XES
	gAu7m5TwyzjFAZ+jNtmt4Ps7GICIwA0/XzeWLWcuFKhmfHInz7dvo/nVoS0Lbo0zoCrXgxYW66zSs
	/wKarPxty1UGkz/t+e1lQZ0TbkKyO3TW0VMW1Qltuy/qLddoFTm9XCTVU/181cjZHRVJ8FmgRRkfG
	xH+EiERmuuhplxTx/wVEZJxxQnJlOMG0g1Ng30d7HWx05lCMUP2yLzbJ2BogBfcOrDzWXD9sE1HQm
	19qS6OJX/nhb9/1sJdq2ZJeKOCbDhnfoRZjFJfkuUlCL3vuhb0gboLnd622DKvvhqYQOuY0igYx3Q
	tsJ1kHVx2BWziSsdycnw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1688126025; x=1688133225; bh=ya
	Hy0NgB4QI7znLtjDpufXmMXzZcSHw23m7h8BkLYBc=; b=10KOp+CzUmojO7ZSQ7
	q9c3tAJBmOd76hg6sonOk40OjKAR6/QOPiz7XUomr8IP6aN19s7N9Q20gnTBA8OU
	H+ET1KWhVc0oqozGAYUdc7B70SAPMdGIyEmEipUjQs98dHfF9mAUgsaeXHru8OlA
	Z6b+3BUsGbAouqrpsuvP8THkbsAzAbWArrjQjssrDfLJHYAxMJ1nD0US1BwUxLpH
	Khsbp9i0wfMK4NjF83UPBZQU2Xe9X8o6q5JmvVGPeBGgXYJSti5i4d4Vr++XzGjN
	1deBUgFU/w8tfA/bjpGKl2V8A3IgBHPWHWftg2j80IDtUUtjFI/5ldbjH9jVYmeY
	G2pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688126025; x=1688133225; bh=yaHy0NgB4QI7z
	nLtjDpufXmMXzZcSHw23m7h8BkLYBc=; b=VLzmPefoROKUnYgyH59xLO28GGD4n
	I4lte/pn3WzX95H4eQRtTSBAb90fH5FqIscW92NizI9x3K9rvYkB4k9q6ajV1EbD
	VxE8AOWeA5gd3Truhe/A9kaDx6LrP7Tl4Y9XFamiioeruNo4WJqflkjaHJ0nsHcv
	J2r4IJGTVqOt1B1dMbybj/sbd/LzIbl5CzvfvEtuw8uPdvo7PAFEKVHhv2+1X9Xd
	qEBjQf6xoQoJmFw77YwpNSZG5Kn1KzEpYegVmCRAHDr3owvr/EeqaPrEmVGD6Gmw
	mfm5v+sxS/9Ml4UMUnNpdnRbqLCJ6zjTnHpvZojc13GhJnUu+kDlq3vDg==
In-Reply-To: <ef7b3899-7d18-8018-47fa-aac0efaa61f4@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <pet>

On Fri, Jun 30, 2023, at 09:46, Thomas Zimmermann wrote:
> Am 29.06.23 um 15:21 schrieb Arnd Bergmann:
>> On Thu, Jun 29, 2023, at 15:01, Thomas Zimmermann wrote:
>>> Am 29.06.23 um 14:35 schrieb Arnd Bergmann:
>>>> On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
>
>>>
>>> FIRMWARE_EDID is a user-selectable feature, while ARCH_HAS_EDID_INFO
>>> announces an architecture feature. They do different things.
>> 
>> I still have trouble seeing the difference.
>
> The idea here is that ARCH_HAS_ signals the architecture's support for 
> the feature.  Drivers set 'depends on' in their Kconfig.
>
> Another Kconfig token, VIDEO_SCREEN_INFO or FIRMWARE_EDID, would then 
> actually enable the feature.  Drivers select VIDEO_SCREEN_INFO or 
> FIRMWARE_EDID and the architectures contains code like

Fair enough. In that case, I guess FIRMWARE_EDID will just depend on
ARCH_HAS_EDID_INFO, or possibly "depends on FIRMWARE_EDID || EFI"
after it starts calling into an EFI specific function, right?

> #ifdef VIDEO_SCREEN_INFO
> struct screen_info screen_info = {
> 	/* set values here */
> }
> #endif
>
> This allows us to disable code that requires screen_info/edid_info, but 
> also disable screen_info/edid_info unless such code has been enabled in 
> the kernel config.
>
> Some architectures currently mimic this by guarding screen_info with 
> ifdef CONFIG_VT or similar. I'd like to make this more flexible. The 
> cost of a few more internal Kconfig tokens seems negligible.

I definitely get it for the screen_info, which needs the complexity.
For ARCHARCH_HAS_EDID_INFO I would hope that it's never selected by
anything other than x86, so I would still go with just a dependency
on x86 for simplicity, but I don't mind having the extra symbol if that
keeps it more consistent with how the screen_info is handled.

>> I suppose you could use FIRMWARE_EDID on EFI or OF systems without
>> the need for a global edid_info structure, but that would not
>> share any code with the current fb_firmware_edid() function.
>
> The current code is build on top of screen_info and edid_info. I'd 
> preferably not replace that, if possible.

One way I could imagine this looking in the end would be
something like

struct screen_info *fb_screen_info(struct device *dev)
{
      struct screen_info *si = NULL;

      if (IS_ENABLED(CONFIG_EFI))
            si = efi_get_screen_info(dev);

      if (IS_ENABLED(CONFIG_ARCH_HAS_SCREEN_INFO) && !si)
            si = screen_info;

      return si;
}

corresponding to fb_firmware_edid(). With this, any driver
that wants to access screen_info would call this function
instead of using the global pointer, plus either NULL pointer
check or a CONFIG_ARCH_HAS_SCREEN_INFO dependency.

This way we could completely eliminate the global screen_info
on arm64, riscv, and loongarch but still use the efi and
hyperv framebuffer/drm drivers.

    Arnd
