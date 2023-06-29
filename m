From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 00/12] arch,fbdev: Move screen_info into arch/
Date: Thu, 29 Jun 2023 16:42:42 +0200
Message-ID: <ce4ddce0-ceea-426c-b348-d22468d7c402@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
 <f9185435-74bb-a325-8fe6-3beb51a66e0a@suse.de>
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
	List-Owner; bh=GEM6r21sC2BoiZj7euPmUn+HDBNnR5OKeyfcBfy3wjg=; b=1W1FSC5wvtKhCo
	JyYCu5rlpVPcQRd5+cLHe3gzqp4o1VQh94DqmktxVYAwTpXqBBFvTIkhbZWxt6FRU0T2i8Hdz5M03
	1v+bhZaZvulxQcUcmQu1MXqK7W6rloKGrFBfduF52wPeeRrm4TMK/MrqXXscISOImss8E3gaSb3ab
	3CiqHvo8Dti5Bn/iCcGYbgqmzYawBHhCaWfbxJSqUHeUUrTSO/v+0sqHj1fEO0xxVTT8RpZz5SmH6
	AG2Fx2+8LpbVV0a0rzyqdNjiM+dTEk4VkiIJkiHQZhmJzaSsKnuvmMqdWhQWg2TiEfEbxdYOK6afC
	88N8x+w2O4mDZSaJBeUw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1688049783; x=1688056983; bh=tH
	SCuJbmuJlT+unyX4wdwm35F06LE8SCy+Og6X/m9DI=; b=FV9nO/j/Xdm5cnG6UB
	sO9u8qjWkG4zOqKUhXnhJ2RYfN1MZ3Kurqn85lEsJl7vkP5a/wdBWaFdfq4uSulg
	eD/TXf6t4GqPVAoNus5HnjtbA1vX8VrBrjgri2vE0OiP2BSb5Sz/Pa2C0OcILLNa
	uvFS7KDmA3Z+PSTaIcpOvOnZyAi2yVT1FzCqp7iRvA0LJt1+wRraHFLOR3jih5Cs
	jATcgblkM7OGPteVBvXmW3paY0tjSC/B5Xw7fxmwX1f73RjswI9pT+zjkQRu+TqM
	Zsrmd0IqOKzH2xm5FLjlXxLg/SYtjqX8WBuItuEotXdBlqMlSIKnBw9uSc0kSFc4
	WB+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688049783; x=1688056983; bh=tHSCuJbmuJlT+
	unyX4wdwm35F06LE8SCy+Og6X/m9DI=; b=IEg6bOdqZ2fgoUmwXVc8pb/uyJ2CC
	MOuLn/CZcijB/QkegFpO4zpbp2YYMXm7i7Fu54Datj1E0vkDR3DKgAUxo6z+GWk3
	vXwluBuok2nikCjYscmpRjVF9aIs6Z3Xj7fdUsirXf+m9AdUwVoMNKOO0MYZ2R8w
	hgGHbzL0Ar9zadbigZQorDDjOWkOiah/gEi8RJBLof77Nwpm9iJ+r3Tp7gQ7XU3u
	cozoUBEjOyE8ENgbEKdyPutCHcAWlVtfgQdZBYVqqbmbh2K14vwZE6PMJ4Kx6p2+
	/+OkyxEaQgOqymqPNrwdxRUuj9S7LqeMaozoifwtEIa8O5rZRMCvumLJw==
In-Reply-To: <f9185435-74bb-a325-8fe6-3beb51a66e0a@suse.de>
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

On Thu, Jun 29, 2023, at 16:15, Thomas Zimmermann wrote:
> Am 29.06.23 um 15:31 schrieb Arnd Bergmann:
>> On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
>>> Future directions: with the patchset in place, it will become possible
>>> to provide screen_info and edid_info only if there are users. Some
>>> architectures do this by testing for CONFIG_VT, CONFIG_DUMMY_CONSOLE,
>>> etc. A more uniform approach would be nice. We should also attempt
>>> to minimize access to the global screen_info as much as possible. To
>>> do so, some drivers, such as efifb and vesafb, would require an update.
>>> The firmware's EDID data could possibly made available outside of fbdev.
>>> For example, the simpledrm and ofdrm drivers could provide such data
>>> to userspace compositors.
>> 
>> I suspect that most architectures that provide a screen_info only
>> have this in order to compile the framebuffer drivers, and provide
>> hardcoded data that does not even reflect any real hardware.
>
> That's quite possible. Only x86's bootparam and EFI code sets 
> screen_info from external data. The rest is hardcoded. A number of 
> architectures protect screen_info with CONFIG_VT, CONFIG_DUMMY_CONSOLE, 
> etc. In a later patchset, I wanted to change this such that these users 
> of screen_info would enable the feature via select in their Kconfig.
>
> Do you know the reason for this branch in dummycon:
>
> https://elixir.bootlin.com/linux/v6.4/source/drivers/video/console/dummycon.c#L21
>
> What is special about arm that dummycon uses the screeninfo?

I can only guess myself, but I see that the values are only ever
set from the old ATAGS data, and not from DT on any of the
modern ones, and my interpretation is that this is meant to
match whatever the vga console was set to on the three
platforms that support vgacon.
 
I see this was added in linux-2.1.111, just before the
corresponding sparc specific hack was removed, but I don't have
patch descriptions from that era. Russell might remember, or know
if that is actually still needed.

   Arnd
