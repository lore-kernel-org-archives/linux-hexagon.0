From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 00/12] arch,fbdev: Move screen_info into arch/
Date: Thu, 29 Jun 2023 16:29:17 +0200
Message-ID: <0783a7ec-b779-4033-9877-f6eacc65c575@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
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
	List-Owner; bh=mStixHxxeTyUsZHgqwqcbuTQbTTaRg9+btQMTjlG+iw=; b=i/iyGClId4SWcp
	eBi+fL/Dyj9zIUCiudl2h6sYhH5atKKdKPxuHamvJNKyvX9mWTG9Qyae8eeoe8GpnHZCgOP3eBRj4
	IzOSCHhCCW9tccWdMktRmj2x3CRel2G8HzwHqc92fH2y6vQ9U4vSpqRNo3NH+hcvVjx09ElgOrNCi
	oLU/9IRj+bztrnJBUYp1s/nYQolF75RjgfXxJRm90WsflfjlLaLyc7+tKaXjZGJzQahgD8SyvUS+k
	sudkPKDxHYSq/6w/CwM9SWw6sZRDhPY/83oLFMJ3oSH3jk1ACu8Lmt7Xcsn+RWfJK2kLWDIPnNSrh
	hld54EIkZf+VipQ4RfjA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1688048978; x=1688056178; bh=nG
	nJsyAJyrvJkwnkSe1+RvyafOFNiNiqyHMsPO1u6Xk=; b=2EcylAr+2IQK5P7b6p
	/vjLbGIHf8i+8rzMt8chAuFq+c5T2nXA6rNsTNzOdtksQ6e0sAw9/eRHtOar+WHl
	hAsaWivSScicHRc+IOwIVIkXzMKCHS/A9Ffztx8GB0RJptxk+yUbu3OXBw/f3KTQ
	oPUWqOApNqupZeOxA1+KamV7Y1R9j5wdLjjMttKjfSUmTUPTzRkr/PbCf7BFCJf4
	mDKkwIwEguDSpZs+nb5nQ5ZSuOg9qrQBVpn/A0WtJOxqM4NA4/h3SXbcRbNONYzA
	I5y/p+xe7tbFRUhSHoYPvHtNe3/fi0gTCERIIZJ9/fLQnFzpbVcymrZbyXkaYBBK
	ODIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688048978; x=1688056178; bh=nGnJsyAJyrvJk
	wnkSe1+RvyafOFNiNiqyHMsPO1u6Xk=; b=qcZu2F7J3I03fwrcSPg8dsLuhFIrS
	ucycm657dud2E6uYWskFVqcIfgSe/dBt8fFB6+XQTy/fANN6a1BuztN45oTSanNT
	XxVMQih8LW415rbF6tRZPCXSpwn+ekET+YIRIH1036pYAwUd1Fb1ijQRv3N+j2GN
	AxU6byz7HLauD8dLGeOrAT3BJrYb8oPjklQK9FEAS/EPJOPUSZb+pzy/zrsduOA2
	IVQQiY6wMEEkf+oC5juPiNw0sDEEHj+C7FUzhU16m7yof5koi7/AUsQnx7vi7hIE
	YvfD9R33aPOCag5rTXjki4uvznKy226FqetZdturkKSXU4rXB99QQtsyg==
In-Reply-To: <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 29, 2023, at 15:31, Arnd Bergmann wrote:
> On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
>>
>> Future directions: with the patchset in place, it will become possible
>> to provide screen_info and edid_info only if there are users. Some
>> architectures do this by testing for CONFIG_VT, CONFIG_DUMMY_CONSOLE,
>> etc. A more uniform approach would be nice. We should also attempt
>> to minimize access to the global screen_info as much as possible. To
>> do so, some drivers, such as efifb and vesafb, would require an update.
>> The firmware's EDID data could possibly made available outside of fbdev.
>> For example, the simpledrm and ofdrm drivers could provide such data
>> to userspace compositors.
>
> I suspect that most architectures that provide a screen_info only
> have this in order to compile the framebuffer drivers, and provide
> hardcoded data that does not even reflect any real hardware.
>
> We can probably reduce the number of architectures that do this
> a lot, especially if we get EFI out of the picture.

I tried to have another look at who uses what, and here are
some observations:

- EFIFB and hyperv are the only ones that are relevant on modern
  systmes, and they are only used on systems using EFI, so they
  could use a separate data structure that is defined as part of
  drivers/firmware/efi. This would likely mean we don't have to
  define a separate screen_info for arm64, loongarch, ia64 and
  riscv, and could separate the legacy vgacon/vesafb stuff on
  arm32 from the efi side.

- FB_SIS can likely be marked 'depends on X86' like FB_INTEL,
  it seems to depend on x86 BOOT_VESA_SUPPORT.

- FB_VGA16 is currently support on powerpc and enabled on
  one defconfig (pasemi), which I'm fairly sure is a mistake,
  so this could be made x86 specific as well.

- VGA_CONSOLE has a complicated Kconfig dependency list that
  lists platforms without VGA support but I think this is better
  expressed with a positive list. It looks like csky, hexagon,
  nios2 and xtensa should be excluded here and not provide
  screen_info.

- arm and mips only need to provide screen_info on machines
  with VGA_CONSOLE. On Arm we have a dependency on
  footbridge/integrator/netwinder, while on mips the
  dependency can be added to the platforms that fill
  the info (mips, malta, sibyte, sni).

- DUMMY_CONSOLE only uses screen_info on arm, and this should
  likely be limited to the three obsolete machines that
  support VGACON. Almost all Arm machines use DT these days
  and won't ever fill the screen info dynamically.

      Arnd
